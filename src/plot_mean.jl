# Reproducibility fix applied: added Pkg.activate and .jl extension.
# All model logic, parameters, and algorithm are identical to original_code/Plot Mean.
import Pkg; Pkg.activate(joinpath(@__DIR__, ".."))

using Random
using Plots
using Distributions
using Statistics

mutable struct ReactionStruct
    stoichiometry::Vector{Int}
    propensity::Function
end

mutable struct SSA_Struct
    reactions::Vector{ReactionStruct}
    state::Vector{Int}
    t::Float64
    time_points::Vector{Float64}
    hit_counts::Vector{Vector{Int}}
end

function initialize_ssa(reactions, initial_state)
    SSA_Struct(reactions, copy(initial_state), 0.0, [0.0], [copy(initial_state)])
end

function compute_total_propensity(reactions, state)
    sum(r.propensity(state) for r in reactions)
end

function update_state!(ssa::SSA_Struct, reaction_index)
    ssa.state .+= ssa.reactions[reaction_index].stoichiometry
    push!(ssa.hit_counts, copy(ssa.state))
end

function select_reaction(reactions, state, total_propensity)
    r = rand() * total_propensity
    cumulative_sum = 0.0
    for (i, reaction) in enumerate(reactions)
        cumulative_sum += reaction.propensity(state)
        if cumulative_sum > r
            return i
        end
    end
end

function run_ssa!(ssa::SSA_Struct, max_time)
    while ssa.t < max_time
        total_propensity = compute_total_propensity(ssa.reactions, ssa.state)
        if total_propensity == 0
            break
        end
        dt = rand(Exponential(1 / total_propensity))
        ssa.t += dt
        push!(ssa.time_points, ssa.t)
        reaction_index = select_reaction(ssa.reactions, ssa.state, total_propensity)
        update_state!(ssa, reaction_index)
    end
end

function create_reactions(rates)
    return [
        ReactionStruct([1, 0, 0], x -> rates[1] * x[1]),  # EP birth
        ReactionStruct([-1, 0, 0], x -> rates[2] * x[1]),  # EP death
        ReactionStruct([-1, 1, 0], x -> rates[3] * x[1]),  # EP zu MP
        ReactionStruct([-1, 0, 1], x -> rates[4] * x[1]),  # EP zu Diff
        ReactionStruct([0, 1, 0], x -> rates[5] * x[2]),  # MP birth
        ReactionStruct([0, -1, 0], x -> rates[6] * x[2]),  # MP death
        ReactionStruct([1, -1, 0], x -> rates[7] * x[2]),  # MP zu EP
        ReactionStruct([0, -1, 1], x -> rates[8] * x[2]),  # MP zu Diff
        ReactionStruct([0, 0, 1], x -> rates[9] * x[3]),  # Diff birth
        ReactionStruct([0, 0, -1], x -> rates[10] * x[3]),  # Diff death
        ReactionStruct([1, 0, -1], x -> rates[11] * x[3]),  # Diff zu EP
        ReactionStruct([0, 1, -1], x -> rates[12] * x[3])  # Diff zu MP
    ]
end

function run_simulation(initial_state, rates, max_time)
    reactions = create_reactions(rates)
    ssa = initialize_ssa(reactions, initial_state)
    run_ssa!(ssa, max_time)
    return ssa
end

function run_multiple_simulations(initial_state, rates, max_time, num_simulations)
    all_time_points = []
    all_hit_counts = []

    for i in 1:num_simulations
        ssa = run_simulation(initial_state, rates, max_time)
        push!(all_time_points, ssa.time_points)
        push!(all_hit_counts, ssa.hit_counts)
    end

    return all_time_points, all_hit_counts
end

function calculate_mean_trajectories(all_time_points, all_hit_counts, max_time, num_simulations)
    num_steps = 1000
    time_vector = range(0, stop=max_time, length=num_steps)

    mean_state1 = zeros(num_steps)
    mean_state2 = zeros(num_steps)
    mean_state3 = zeros(num_steps)

    for i in 1:num_steps
        current_time = time_vector[i]
        state1_values = []
        state2_values = []
        state3_values = []

        for j in 1:num_simulations
            for k in 1:length(all_time_points[j])
                if all_time_points[j][k] >= current_time
                    push!(state1_values, all_hit_counts[j][k][1])
                    push!(state2_values, all_hit_counts[j][k][2])
                    push!(state3_values, all_hit_counts[j][k][3])
                    break
                end
            end
        end

        mean_state1[i] = mean(state1_values)
        mean_state2[i] = mean(state2_values)
        mean_state3[i] = mean(state3_values)
    end

    return time_vector, mean_state1, mean_state2, mean_state3
end

# Beispiel: Übergangsraten und Anfangszustand
initial_state = [10, 10, 10]
rates = [
    0.0054, 0.0004, 0.0265, 0.0008,  # Raten für EP, MP, Diff, ROCK1
    0.002, 0.0018, 0.0176, 0.0121,   # MP zu EP/Diff
    0.001, 0, 0.0019, 0.0201         # Diff zu EP/MP
]
# Simulationen ausführen
num_simulations = 100
max_time = 336.0
all_time_points, all_hit_counts = run_multiple_simulations(initial_state, rates, max_time, num_simulations)

# Mittelwerte berechnen
time_vector, mean_state1, mean_state2, mean_state3 = calculate_mean_trajectories(all_time_points, all_hit_counts, max_time, num_simulations)

# Plot erstellen
plot(title="Mean # of tumor cells vs Time", xlabel="Time", ylabel="# of tumor cells")
for i in 1:num_simulations
    plot!(all_time_points[i], [count[1] for count in all_hit_counts[i]], color=:green, alpha=0.2, label=false)
    plot!(all_time_points[i], [count[2] for count in all_hit_counts[i]], color=:red, alpha=0.2, label=false)
    plot!(all_time_points[i], [count[3] for count in all_hit_counts[i]], color=:blue, alpha=0.2, label=false)
end

plot!(time_vector, mean_state1, label="Mean EP", color=:green, linewidth=3)
plot!(time_vector, mean_state2, label="Mean MP", color=:red, linewidth=3)
plot!(time_vector, mean_state3, label="Mean Diff", color=:blue, linewidth=3)
