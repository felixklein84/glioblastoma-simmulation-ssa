# Glioblastoma Simulation — Stochastic Simulation Algorithm (SSA)

Archive and reproducibility repository for the Bachelor's thesis:

> **Mathematische Hirntumormodellierung am Beispiel des Glioblastoms: Analyse der Zelldynamik und Therapieeffekte mittels zeitstetiger Markovketten**  
> Felix Klein, University of Mannheim, September 2024  
> Supervisor: Prof. Dr. Martin Slowik

---

## What this is

A Julia implementation of a continuous-time Markov chain (CTMC) model for glioblastoma tumor cell population dynamics, simulated with the Gillespie SSA (Stochastic Simulation Algorithm). The model tracks three interacting cell phenotypes — Early Progenitors (EP), Metastable Progenitors (MP), and Differentiated Cells (Diff) — under four therapy scenarios.

This repository is structured as a thesis archive. The original code is preserved unchanged; the `src/` folder contains a reproducibility-ready copy with only minimal fixes documented in `docs/changes.md`.

---

## Model

Three cell types representing phenotypic heterogeneity in glioblastoma:

| Phenotype | Role |
|---|---|
| **EP** — Early Progenitors | Most stem-like; high division rate; migratory; radiosensitive |
| **MP** — Metastable Progenitors | Intermediate; both proliferative and migratory; more radioresistant |
| **Diff** — Differentiated Cells | Most mature; less division; highest radioresistance |

The model uses 13 reaction channels (birth, death, phenotype switching, drug decay) and applies therapy as state modifications at defined time points.

Full model description: [`docs/model_overview.md`](docs/model_overview.md)  
All parameters with sources: [`docs/parameters.md`](docs/parameters.md)

---

## Scenarios

| Scenario | Script | Description |
|---|---|---|
| No therapy (physiological) | `src/physiological.jl` | Baseline tumor growth |
| ROCK1 inhibition (drug) | `src/rock1_inhibition.jl` | Drug forces EP→Diff differentiation |
| Radiotherapy | `src/radiotherapy.jl` | Single RT event at t=100h |
| Combined (ROCK1 + RT) | `src/combined_therapy.jl` | Both therapies simultaneously |
| Mean trajectories | `src/plot_mean.jl` | 100-run mean over physiological scenario |
| Comparative plots | `src/comparative.jl` | All 4 scenarios overlaid |
| Stationary distribution | `src/eigenvalues.jl` | Long-run phenotype proportions |

Scenario details: [`docs/therapy_scenarios.md`](docs/therapy_scenarios.md)

---

## Setup

Requires **Julia 1.10.4** (or compatible). Exact package versions are pinned in `Manifest.toml`.

```bash
git clone <repo-url>
cd glioblastoma-simmulation-ssa

# Install all dependencies (uses Manifest.toml for exact versions)
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

---

## Running the simulations

Each script is self-contained. Run from the repository root:

```bash
# Physiological baseline
julia --project=. src/physiological.jl

# Drug therapy (ROCK1 inhibition)
julia --project=. src/rock1_inhibition.jl

# Radiotherapy
julia --project=. src/radiotherapy.jl

# Combined therapy
julia --project=. src/combined_therapy.jl

# Mean over 100 runs (takes ~1–2 min)
julia --project=. src/plot_mean.jl

# Comparative overlay plots
julia --project=. src/comparative.jl

# Stationary distribution
julia --project=. src/eigenvalues.jl
```

Each script produces plots displayed to screen and prints any scalar outputs. No files are written to disk by default.

**Interactive exploration:** Open `Workplace/notebook_SSA` in [Pluto.jl](https://github.com/fonsp/Pluto.jl) to explore parameters with live sliders.

---

## Expected outputs

| Script | Output |
|---|---|
| `physiological.jl` | 3 plots: cell counts, proportions, tumor size |
| `rock1_inhibition.jl` | 4 plots: ROCK1 decay, cell counts, proportions, tumor size |
| `radiotherapy.jl` | 3 plots: cell counts, proportions, tumor size |
| `combined_therapy.jl` | 4 plots: ROCK1 decay, cell counts, proportions, tumor size |
| `plot_mean.jl` | 1 plot: 100 individual runs + mean trajectory |
| `comparative.jl` | All individual plots + 2 overlay comparisons + regression output |
| `eigenvalues.jl` | Printed: stationary distribution ≈ [EP=30.2%, MP=44.2%, Diff=25.6%] |

---

## Repository structure

```
├── src/                  # Reproducibility-ready scripts (minimal fixes applied)
├── original_code/        # Original thesis code, byte-for-byte (do not modify)
├── Main/                 # Thesis production scripts (original, no extension)
├── Workplace/            # Experimental variants (not used in thesis results)
├── Jump Process/         # Mathematical demo scripts
├── docs/                 # Documentation
│   ├── model_overview.md     # Biology, CTMC setup, SSA algorithm
│   ├── parameters.md         # All parameters with units and sources
│   ├── therapy_scenarios.md  # Per-scenario descriptions
│   └── changes.md            # Every difference between original_code/ and src/
├── extracted_pdf/        # Structured Markdown extraction of the thesis PDF
├── Project.toml          # Julia package declarations
└── Manifest.toml         # Pinned exact dependency versions
```

---

## Known issue: radiotherapy survival fraction indexing

The original code (`Main/Radiotherapie`, `Main/Bachelor Arbeit Code`) contains a copy-paste error: MP cells receive the Diff survival fraction (33.33%) instead of the stated MP survival fraction (13.95%) from thesis Table 4.1. The thesis figures were therefore produced with γM = 33.33%.

The `src/` scripts fix this to match Table 4.1. To reproduce the exact thesis figures, use `original_code/` instead. Full explanation: [`docs/changes.md`](docs/changes.md).

---

## Parameters (key values)

All rates in h⁻¹. Full table with sources in [`docs/parameters.md`](docs/parameters.md).

| Parameter | Value | Source |
|---|---|---|
| EP net growth (bE − dE) | 0.005 h⁻¹ | Heidelberg collaborators |
| RT survival EP / MP / Diff | 9.52% / 13.95% / 33.33% | Heidelberg collaborators |
| ROCK1 drug effect (α) | ×100 on EP→Diff rate | Theoretical estimate |
| ROCK1 decay rate | 0.011 h⁻¹ (t½ ≈ 63h) | Theoretical estimate |
| Simulation window | 336 h (14 days) | Thesis design choice |

Transition rates determined in collaboration with Stella Soyka and Nirosan Sivapalan (NCT, University Hospital Heidelberg).

---

## Limitations

- No spatial effects or tumor microenvironment
- No therapy resistance mechanisms
- No carrying capacity or competition
- Drug parameters (α, dR) not experimentally validated
- Single radiotherapy time point (no fractionation)

See [`docs/model_overview.md`](docs/model_overview.md) and thesis Section 5.2 for full discussion.

---

## License

MIT — see `LICENSE`.
