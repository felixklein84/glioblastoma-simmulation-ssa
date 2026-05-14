# Reproducibility fix applied: added Pkg.activate, .jl extension, and updated include paths.
# All model logic, parameters, and algorithm are identical to original_code/Kummuliert.jl.
# Note: includes src/ versions (with RT bug fix). To reproduce original thesis figures, use original_code/ files.
import Pkg; Pkg.activate(joinpath(@__DIR__, ".."))

using Plots

# Physiological
include("physiological.jl")
phys_time = time_points
phys_tumor = total_cells
EP_Phys = state1_hits
# Plot ausgeben
display(plot_phys_1)
display(plot_phys_2)
display(plot(plot_phys_1, plot_phys_2, layout=(1, 2)))
display(plot_phys_3)

# Radiotherapy
include("radiotherapy.jl")
radio_time = time_points
radio_tumor = total_cells
EP_radio = state1_hits
# Plot ausgeben
display(plot_radio_1)
display(plot_radio_2)
display(plot(plot_radio_1, plot_radio_2, layout=(1, 2)))
display(plot_radio_3)


# ROCK1 Inhibition
include("rock1_inhibition.jl")
rock1_time = time_points
rock1_tumor = total_cells
EP_rock1 = state1_hits
# Plot ausgeben
display(plot_rock_2)
display(plot_rock_3)
display(plot(plot_rock_1, plot_rock_2, layout=(1, 2)))
display(plot(plot_rock_1, plot_rock_3, layout=(1, 2)))
display(plot(plot_rock_1, plot_rock_2, plot_rock_3, layout=(3, 1)))
display(plot_rock_4)


# ROCK1 + Radiotherapy
include("combined_therapy.jl")
comb_time = time_points
comb_tumor = total_cells
EP_comb = state1_hits
# Plot ausgeben
display(plot(plot_0, plot_1, layout=(1, 2)))
display(plot_2)
display(plot_3)


# Tumorsize vs. Time
plot_tumorsize = plot(phys_time, phys_tumor, label="Physiological", xlabel="Time in hours", ylabel="Tumorsize", title="Tumorsize vs. Time", lw=2)
plot!(radio_time, radio_tumor, label="Radiotherapy", lw=2)
plot!(rock1_time, rock1_tumor, label="ROCK1 Inhibition", lw=2)
plot!(comb_time, comb_tumor, label="ROCK1 Inhibition + Radiotherapy", lw=2)
display(plot_tumorsize)

# EP's vs. Time
plot_EP_all = plot(phys_time, EP_Phys, label="Physiological", xlabel="Time in hours", ylabel="# of EP's", title="# of EP's vs. Time", lw=2)
plot!(radio_time, EP_radio, label="Radiotherapy", lw=2)
plot!(rock1_time, EP_rock1, label="ROCK1 Inhibition", lw=2)
plot!(comb_time, EP_comb, label="ROCK1 Inhibition + Radiotherapy", lw=2)
display(plot_EP_all)

# Interpolation
(mean(log.(phys_tumor)))/300

using GLM
lrm = lm(@formula(cells ~ time), (time=phys_time, cells=log.(phys_tumor)))
display(lrm)
