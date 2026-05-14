# Appendix — Code and Supplementary Material

> Thesis pages 55–65. Source: Arbeit_abgeschickt.pdf

---

## Julia Language Note (p. 55)

The thesis explicitly chooses Julia for:
- Scientific computing: intuitive dynamic syntax + high performance
- Solves the "two-language problem" (no need to prototype in Python then rewrite in C++)
- Efficient and flexible for complex mathematical systems

Reference: https://julialang.org

---

## Appendix Code (pp. 55–60)

The appendix contains the full annotated Julia SSA implementation used for all simulations in Chapter 4. This is the **canonical reference implementation** — the `Main/Bachelor Arbeit Code` file is the production version of this code.

### Key code structures:

**ReactionStruct** — one reaction channel:
```julia
struct ReactionStruct
    transitions::Vector{Int}   # state changes (EP, MP, Diff, ROCK1)
    reac_prob::Function        # propensity function
end
```

**SSA_Struct** — mutable simulation state:
```julia
mutable struct SSA_Struct
    reactions::Vector{ReactionStruct}
    state::Vector{Int}           # current cell counts
    t::Float64                   # current time
    time_points::Vector{Float64} # event times
    hit_counts::Vector{Vector{Int}} # state at each event
    radiotherapy_time::Float64
    radiotherapy_done::Bool
end
```

**Random seed:** `Random.seed!(100)` — used for reproducibility

### create_reactions function (p. 58)

The 13 reaction channels in order:
1. EP birth: transitions=[1,0,0,0], rate = rates[1] × x[1]
2. EP death: transitions=[-1,0,0,0], rate = rates[2] × x[1]
3. EP→MP: transitions=[-1,1,0,0], rate = rates[3] × x[1]
4. EP→Diff: transitions=[-1,0,1,0], rate = rock1_effect(x) × x[1]
5. MP birth: transitions=[0,1,0,0], rate = rates[5] × x[2]
6. MP death: transitions=[0,-1,0,0], rate = rates[6] × x[2]
7. MP→EP: transitions=[1,-1,0,0], rate = rates[7] × x[2]
8. MP→Diff: transitions=[0,-1,1,0], rate = rates[8] × x[2]
9. Diff birth: transitions=[0,0,1,0], rate = rates[9] × x[3]
10. Diff death: transitions=[0,0,-1,0], rate = rates[10] × x[3]
11. Diff→EP: transitions=[1,0,-1,0], rate = rates[11] × x[3]
12. Diff→MP: transitions=[0,1,-1,0], rate = rates[12] × x[3]
13. ROCK1 decay: transitions=[0,0,0,-1], rate = rates[13] × x[4]

**ROCK1 effect:**
```julia
rock1_effect = (x) -> x[4] > 0 ? 100 * rates[4] : rates[4]
```
When ROCK1 present: EP→Diff rate × 100 (α = 100).

### Canonical parameter values from appendix (p. 59)

```julia
initial_state = [10, 10, 10, 10]  # EP, MP, Diff, ROCK1

rates = [
    0.0054, 0.0004, 0.0265, 0.0008,  # EP: birth, death, EP→MP, EP→Diff
    0.002,  0.0018, 0.0176, 0.0121,  # MP: birth, death, MP→EP, MP→Diff
    0.001,  0,      0.0019, 0.0201,  # Diff: birth, death, Diff→EP, Diff→MP
    0.011                             # ROCK1 decay
]

rt_dying_percentage = [0.0952380952380952, 0.13953488372093, 0.333333333333333]
# Exact fractions: 2/21, 6/43, 1/3

radiotherapy_time = 400.0  # set to 400 to disable RT in ROCK1-only example
run_time = 336.0
```

### Note on exact RT fraction values

The thesis states:
- γE = 9.52% ≈ 2/21 ≈ 0.095238...
- γM = 13.95% ≈ 6/43 ≈ 0.139535...
- γD = 33.33% = 1/3 ≈ 0.333333...

The code uses full floating-point precision. These values come from Heidelberg collaborators.

### Note on a bug in the appendix code (p. 57)

The appendix listing shows a minor inconsistency in the radiotherapy application:
```julia
ssa.state[2] = round(Int, rt_dying_percentage[3] * ssa.state[2])  # uses index 3, not 2
ssa.state[3] = round(Int, rt_dying_percentage[3] * ssa.state[3])  # also index 3
```
Both MP and Diff use `rt_dying_percentage[3]` (Diff survival = 33.33%).

This appears to be a copy-paste error in the appendix listing specifically. The production files in `Main/` should be verified against thesis Table 4.1 to confirm whether the intended behavior uses separate γM and γD or both equal to γD.

---

## Supplementary Theorems (p. 61)

Standard mathematical results included for completeness:
- **Daniell-Kolmogorov existence theorem** — guarantees existence of CTMC from consistent finite-dimensional distributions
- **Lemma 0.2** — subadditive function lemma (used in Q-matrix derivation)
- **Lemma 0.3** — continuous function with continuous right derivative is continuously differentiable

---

## Abbreviations (p. 61)

| Abbreviation | German | English |
|---|---|---|
| MKSZ | Markovketten in stetiger Zeit | Continuous-time Markov chains |
| MKDZ | Markovketten in diskreter Zeit | Discrete-time Markov chains |
| GBM | Glioblastom | Glioblastoma |
| MCT | Monotone Convergence Theorem | Monotone Convergence Theorem |
| EP | Early Progenitor | Early Progenitor |
| MP | Metastable Progenitor | Metastable Progenitor |
| Diff | Differentiated Typ | Differentiated Type |
| SSA | Stochastischer Simulationsalgorithmus | Stochastic Simulation Algorithm |
