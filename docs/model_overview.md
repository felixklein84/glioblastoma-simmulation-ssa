# Model Overview

## Biological Background

Glioblastoma (GBM) is the most common and aggressive malignant brain tumor in adults (~78% of primary malignant brain tumors). Its 5-year survival rate is approximately 5% for the IDH-wildtype form. Despite radiotherapy, chemotherapy, and immunotherapy, treatment success is severely limited by the tumor's properties:

- **Rapid cell division and infiltrative invasion** — surgical removal is nearly impossible
- **Phenotypic heterogeneity** — the tumor contains cell subpopulations with fundamentally different behaviors
- **Go-or-Grow dichotomy** — cells either proliferate at their current location ("Grow") or migrate invasively into surrounding tissue ("Go"), switching dynamically in response to environmental signals
- **Tumor microtubule networks** — cells form communication networks via ultrathin membrane extensions, enabling collective resistance to therapy

### Three Cell Phenotypes

The model distinguishes three phenotypic states, following Soyka & Sivapalan [16] and Lan et al. [10]:

| Phenotype | Symbol | Biological role |
|---|---|---|
| Early Progenitors | EP | Most stem-like; high division rate; pluripotent; migratory; radiosensitive but long-term therapy resistant |
| Metastable Progenitors | MP | Intermediate state; both proliferative and migratory; more radioresistant than EP |
| Differentiated Cells | Diff | Most mature; less division and migration; form stationary networks; highest radioresistance |

The central biological insight: EP cells are the main growth drivers but are also radiosensitive. Diff cells survive radiotherapy best but are less proliferative. The tumor's ability to switch between these phenotypes is what makes it so difficult to treat.

---

## Mathematical Model

### State Space

The system is described as a **continuous-time Markov chain (CTMC)** on:

```
N(t) = (E(t), M(t), D(t), R(t)) ∈ ℕ₀⁴
```

- **E(t):** number of EP cells at time t
- **M(t):** number of MP cells at time t
- **D(t):** number of Diff cells at time t
- **R(t):** ROCK1 drug molecule count at time t (present only in drug/combined scenarios)

### Why a CTMC?

Cell division, death, and phenotype switching are inherently **random events** — they occur at unpredictable times with rates that depend on the current cell counts. A CTMC captures this exactly: the process stays in state N for a random (exponentially distributed) holding time, then jumps to a new state. This is more realistic than deterministic (ODE) models, which cannot represent the stochastic fluctuations observed in small cell populations.

### Model Assumptions

1. Each reaction rate is **proportional to the current cell count** (mass-action kinetics)
2. Phenotype switching is modeled as a **direct transition** between types (biologically, differentiation often follows division, but this is mathematically equivalent and simpler)
3. All complex biological influences (extracellular matrix, age-dependent differentiation, spatial structure) are **absorbed into stochastic rate parameters**
4. **No carrying capacity** — the population can grow without bound (explosion is theoretically possible but negligible for the 336h simulation window)
5. **No spatial effects** — cells are treated as a well-mixed population

### The 13 Reaction Channels

Each reaction ω has a stoichiometric vector vω (how N changes) and a propensity rω(N) (rate at which the event occurs):

| # | Reaction | State change vω | Propensity rω(N) |
|---|---|---|---|
| 1 | EP birth | (+1, 0, 0, 0) | bE · E |
| 2 | EP death | (−1, 0, 0, 0) | dE · E |
| 3 | EP → MP | (−1, +1, 0, 0) | sE→M · E |
| 4 | EP → Diff | (−1, 0, +1, 0) | α · sE→D · E if R>0, else sE→D · E |
| 5 | MP birth | (0, +1, 0, 0) | bM · M |
| 6 | MP death | (0, −1, 0, 0) | dM · M |
| 7 | MP → EP | (+1, −1, 0, 0) | sM→E · M |
| 8 | MP → Diff | (0, −1, +1, 0) | sM→D · M |
| 9 | Diff birth | (0, 0, +1, 0) | bD · D |
| 10 | Diff death | (0, 0, −1, 0) | dD · D |
| 11 | Diff → EP | (+1, 0, −1, 0) | sD→E · D |
| 12 | Diff → MP | (0, +1, −1, 0) | sD→M · D |
| 13 | ROCK1 decay | (0, 0, 0, −1) | dR · R |

### Generator

The process is characterized by its generator:

```
Lφ(N) = Σ_{ω} [φ(N + vω) − φ(N)] · rω(N)
```

for bounded measurable functions φ: ℕ₀⁴ → ℝ. This is the infinitesimal description of the expected change in any observable quantity.

---

## Stochastic Simulation Algorithm (Gillespie SSA)

Because the state space is infinite and an analytical solution of the forward equation is not feasible, the thesis uses the **Gillespie SSA** (Masuda & Vestergaard [11]) to generate exact sample paths of the CTMC.

**At each step, given current state N and time t:**

1. Compute propensity for each of the 13 reactions: rⱼ(N)
2. Compute total rate: r₀ = Σⱼ rⱼ(N)
3. If r₀ = 0: stop (absorbing state)
4. Draw time to next event: τ ~ Exp(r₀); update t → t + τ
5. Select which reaction fires: j ~ Categorical(rⱼ/r₀)
6. Update state: N → N + vⱼ
7. Record (t, N); repeat until t ≥ max_time

This is **exact** — it samples from the true probability distribution of the CTMC without any approximation.

---

## Therapy Mechanisms

### Radiotherapy

Applied as a **single instantaneous event** at t = 100h. Each cell population is multiplied by its phenotype-specific survival fraction:

| Phenotype | Survival fraction γ | Killed |
|---|---|---|
| EP | 9.52% | ~90.5% |
| MP | 13.95% | ~86.1% |
| Diff | 33.33% | ~66.7% |

These fractions reflect the biological observation that more differentiated cells are more radioresistant. Values were provided by clinical collaborators at the University of Heidelberg.

### ROCK1 Inhibition (Drug Therapy)

ROCK1 inhibition **amplifies the EP→Diff transition rate** by a factor of α = 100 as long as R(t) > 0. The drug decays as a first-order process with rate dR = 0.011 h⁻¹, giving a half-life of approximately 63 hours and near-complete decay by ~168h (half the 336h simulation).

Biological goal: force EP cells (the aggressive, stem-like population) into a differentiated state, making the tumor less invasive and more amenable to surgical removal. This is **not** a direct cytotoxic drug — it does not kill cells directly.

### Combined Therapy

Both interventions applied simultaneously: ROCK1 inhibition from t = 0, radiotherapy at t = 100h. Uses identical parameters to the individual scenarios, enabling direct comparison.

---

## References

[4] Baar et al. — Net growth rate range 0.008–0.25 per day (*Scientific Reports*, 2016)  
[10] Lan et al. — Glioblastoma stem cell hierarchy (*Nature*, 2017)  
[11] Masuda & Vestergaard — Gillespie Algorithms (*Cambridge UP*, 2023)  
[16] Soyka & Sivapalan — Glioblastoma atlas update for mathematicians (unpublished, Heidelberg, 2024)  
[18] Venkataramani et al. — GBM hijacks neuronal mechanisms (*Cell*, 2022)
