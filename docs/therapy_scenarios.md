# Therapy Scenarios

Four simulation scenarios were developed for the thesis. Each is a separate Julia script in `src/` (reproducibility copy) and `original_code/` (original unchanged).

---

## Scenario 1: Physiological Baseline (No Therapy)

**File:** `src/physiological.jl` | `original_code/Physiologisch`  
**Thesis section:** 4.2.1 (p. 40–41)

### What it models
Tumor growth with no therapeutic intervention. The three cell populations evolve under birth, death, and phenotype switching according to baseline rates. ROCK1 is not included (3-state model).

### Initial conditions
```
EP = 10, MP = 10, Diff = 10
```

### Key dynamics
- MP cells dominate the tumor population due to their balance of moderate birth rate and low death
- EP cells are the primary growth driver (highest net birth rate)
- Diff cells accumulate slowly via transitions from EP and MP
- Stochastic fluctuations are visible in individual runs; 100-run mean converges quickly

### Outputs
- Plot (a): Cell counts over 336h (EP=green, MP=red, Diff=blue)
- Plot (b): Relative cell type proportions (stacked area)
- Plot (c): Mean over 100 simulation runs

### Thesis interpretation
> "The physiological model shows typical tumor development in stable equilibrium. No aggressive growth phases are observed." — consistent with unmodified tumor progression without external intervention.

---

## Scenario 2: Drug Therapy — ROCK1 Inhibition

**File:** `src/rock1_inhibition.jl` | `original_code/ROCK1 Inhibition`  
**Thesis section:** 4.2.2 (p. 41–43)

### What it models
Pharmacological inhibition of ROCK1, which forces EP cells into a differentiated state. This is a 4-state model (EP, MP, Diff, ROCK1).

### Mechanism
- While ROCK1 > 0: EP→Diff rate is multiplied by α = 100
- ROCK1 decays at rate dR = 0.011 h⁻¹ (half-life ≈ 63h, near-zero by ~168h)
- After ROCK1 = 0: EP→Diff rate returns to baseline

### Initial conditions
```
EP = 10, MP = 10, Diff = 10, ROCK1 = 10
```

### Key dynamics
- Strong EP suppression while drug is active
- Diff becomes the dominant population
- After drug decay (~168h): EP count rises again, tumor composition reverts toward physiological pattern
- Effect is **transient** — therapy must continue until surgery is possible

### Outputs
- Plot (a): ROCK1 count over time
- Plot (b): Cell counts over 336h
- Plot (c): Relative proportions

### Important caveat
ROCK1 inhibition is **not a cytotoxic drug** — it does not directly kill cells. Its goal is to convert aggressive EP cells into less dangerous Diff cells. No exact biological data on ROCK1 effect magnitude or decay rate was available; both α and dR are theoretical estimates.

### Thesis interpretation
> "Therapy should be continuously maintained until the tumor can be surgically removed."

---

## Scenario 3: Radiotherapy

**File:** `src/radiotherapy.jl` | `original_code/Radiotherapie`  
**Thesis section:** 4.2.3 (p. 43–44)

### What it models
A single radiotherapy event applied at t = 100h. All three cell populations are instantly reduced by their phenotype-specific survival fractions. This is a 3-state model.

### Mechanism
At t = 100h, populations are scaled:
```
EP_new  = round(0.0952 × EP)    # ~9.5% survive
MP_new  = round(0.1395 × MP)    # ~14% survive
Diff_new = round(0.3333 × Diff)  # ~33% survive
```

### Initial conditions
```
EP = 10, MP = 10, Diff = 10
```

### Key dynamics
- Before t=100h: growth matches physiological scenario
- At t=100h: EP nearly eliminated, MP strongly reduced, Diff least affected
- Post-RT: populations stabilize at low levels for ~100h, then regrowth begins (primarily MP)
- Long-term: tumor returns toward physiological dynamics

### Outputs
- Plot (a): Cell counts over 336h
- Plot (b): Relative proportions

### ⚠️ Known issue: RT survival fraction indexing
The thesis appendix code listing (p. 57) shows a possible copy-paste error: both MP and Diff use `rt_dying_percentage[3]` (Diff survival = 33.33%) instead of MP using `rt_dying_percentage[2]` (MP survival = 13.95%). **Verify the production file `original_code/Radiotherapie` against thesis Table 4.1 before trusting radiotherapy results.** See `docs/changes.md` for details.

### Thesis interpretation
> "Radiotherapy is highly effective short-term against EP and MP, but Diff cells survive in greater numbers and can provide the basis for renewed tumor growth."

---

## Scenario 4: Combined Therapy (ROCK1 + Radiotherapy)

**File:** `src/combined_therapy.jl` | `original_code/Bachelor Arbeit Code`  
**Thesis section:** 4.2.4 (p. 45–46)

### What it models
Both interventions simultaneously: ROCK1 inhibition active from t = 0, radiotherapy applied at t = 100h. This is the 4-state model. Parameters are identical to Scenarios 2 and 3.

### Initial conditions
```
EP = 10, MP = 10, Diff = 10, ROCK1 = 10
```

### Key dynamics
- Pre-RT (0–100h): ROCK1 differentiates EP cells; tumor grows more slowly than physiological
- At t=100h: radiotherapy kills most remaining cells
- Post-RT: EP count remains near zero; Diff and MP drop drastically
- After ROCK1 decay (~200h): no significant growth surge (unlike ROCK1-only scenario)
- Populations remain stable with mainly cell transitions rather than divisions

### Outputs
- Plot (0): ROCK1 decay over time
- Plot (1): Cell counts over 336h
- Plot (2): Relative proportions
- Plot (3): Total tumor size

### Thesis interpretation
> "By combined therapy, valuable time can be gained. A possible strategy could be to use drug therapy longer to eliminate Diff cells before radiotherapy kills the radiosensitive types."

---

## Additional Scripts

### Mean Trajectory Analysis
**File:** `src/plot_mean.jl` | `original_code/Plot Mean`

Runs the physiological model N=100 times. At each of 1000 evenly-spaced time points, interpolates the state from the event-driven trajectory. Plots all 100 individual runs (alpha=0.2) overlaid with the mean trajectory (linewidth=3).

### Comparative Plots
**File:** `src/comparative.jl` | `original_code/Kummuliert.jl`

Includes all four scenarios in a single script and produces overlay comparison plots:
- Total tumor size over time (all 4 scenarios)
- EP count over time (all 4 scenarios)

Also performs linear regression on log-transformed physiological tumor size to estimate exponential growth rate.

### Stationary Distribution
**File:** `src/eigenvalues.jl` | `original_code/Eigenwerte.jl`

Computes the stationary distribution of the embedded discrete-time jump chain using eigenvalue decomposition of the transposed transition matrix P. The eigenvector for eigenvalue = 1 gives long-run phenotype proportions.

---

## Workspace / Experimental Variants

These files in `Workplace/` are **not the thesis model** — they are development-stage explorations that were not used in the final results:

| File | Difference from canonical model |
|---|---|
| `Radiotherapie komplex` | Adds `ep_replenished` flag; blocks EP birth until recovery post-RT |
| `Radiotherapie fortgeschritten` | Blocks all EP birth permanently after RT |
| `Plot Mean` (Workplace) | Earlier version of mean trajectory calculation |
| `Eigenwerte.jl` (Workplace) | Simplified eigenvalue extraction |
| `notebook_SSA` | Pluto interactive notebook with sliders for all parameters |
