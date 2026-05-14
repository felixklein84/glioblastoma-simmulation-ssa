# Change Log

This document records every difference between the original thesis code (`original_code/`, `Main/`, `Workplace/`) and the reproducibility-ready copy in `src/`.

The original code is preserved byte-for-byte in `original_code/`. The `src/` copy contains only the minimal changes listed here.

---

## Changes Applied to `src/`

### 1. File extensions added (cosmetic, zero logic change)

Files in `Main/` have no `.jl` extension, which prevents editors from recognizing them as Julia files and blocks running them with `julia filename.jl`. Extensions added in `src/`:

| Original name | New name in `src/` |
|---|---|
| `Physiologisch` | `physiological.jl` |
| `Radiotherapie` | `radiotherapy.jl` |
| `ROCK1 Inhibition` | `rock1_inhibition.jl` |
| `Bachelor Arbeit Code` | `combined_therapy.jl` |
| `Plot Mean` | `plot_mean.jl` |

Files already named with `.jl` (`Kummuliert.jl`, `Eigenwerte.jl`) are renamed to `comparative.jl` and `eigenvalues.jl` for clarity.

**Scientific impact: none.**

---

### 2. `Pkg.activate(".")` added at top of each script

Without activating the project environment, scripts may pick up system-wide Julia packages rather than the pinned versions in `Manifest.toml`. Each `src/` script begins with:

```julia
import Pkg; Pkg.activate(joinpath(@__DIR__, ".."))
```

**Scientific impact: none.** This only affects which package versions are loaded. The pinned `Manifest.toml` is unchanged.

---

### 3. Bug fix: radiotherapy survival fraction indexing

**Severity: affects thesis results for `Radiotherapie` and `Bachelor Arbeit Code`**

**Original code (lines 53–55 of `Main/Radiotherapie`, lines 63–65 of `Main/Bachelor Arbeit Code`):**
```julia
ssa.state[1] = round(Int, rt_dying_percentage[1] * ssa.state[1])  # EP — correct (index 1)
ssa.state[2] = round(Int, rt_dying_percentage[3] * ssa.state[2])  # MP — BUG: uses index 3
ssa.state[3] = round(Int, rt_dying_percentage[3] * ssa.state[3])  # Diff — correct (index 3)
```

`rt_dying_percentage = [0.0952, 0.1395, 0.3333]`

**Problem:** MP (index 2) uses `rt_dying_percentage[3]` = 33.33% (the Diff survival fraction) instead of `rt_dying_percentage[2]` = 13.95% (the intended MP survival fraction from Table 4.1).

**Effect:** In the original code, both MP and Diff survive radiotherapy at 33.33%, not at the thesis-stated values of 13.95% (MP) and 33.33% (Diff). The thesis figures for the radiotherapy and combined therapy scenarios were therefore produced with γM = 33.33%, not γM = 13.95% as stated in Table 4.1.

**Fixed in `src/`:**
```julia
ssa.state[1] = round(Int, rt_dying_percentage[1] * ssa.state[1])  # EP
ssa.state[2] = round(Int, rt_dying_percentage[2] * ssa.state[2])  # MP — fixed to index 2
ssa.state[3] = round(Int, rt_dying_percentage[3] * ssa.state[3])  # Diff
```

**Scientific impact:** The `src/` scripts now implement the parameters as stated in Table 4.1. The `original_code/` scripts reproduce the exact thesis figures (with the indexing as-is).

**To reproduce original thesis figures exactly:** use `original_code/` or set `rt_dying_percentage[2] = 0.3333` in `src/` scripts.

---

## What Was NOT Changed

The following were explicitly not changed in `src/`:

- All numerical parameter values (rates, survival fractions, initial conditions)
- Simulation duration (336h)
- Radiotherapy application time (100h)
- Random seeds
- Algorithm logic (SSA implementation)
- Struct definitions and function signatures
- The ROCK1 effect multiplier (α = 100)
- The drug decay rate (dR = 0.011)
- Plot colors, labels, and output structure
- The `Workplace/` experimental variants (not copied to `src/`)
- The `Jump Process/` mathematical demos (not copied to `src/`)

---

## Notes on the Workspace Variants

`Workplace/Radiotherapie komplex` and `Workplace/Radiotherapie fortgeschritten` are experimental variants that differ in how EP birth is suppressed post-radiotherapy. Neither was used in the thesis results. They are preserved as-is in `Workplace/` and are not included in `src/`.
