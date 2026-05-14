# original_code/

This folder contains a **byte-for-byte copy** of the `Main/` directory as it existed at the start of the archive/reproducibility project.

These files are the original thesis simulation scripts. **Do not modify them.**

| File | Scenario |
|---|---|
| `Physiologisch` | No therapy — physiological baseline |
| `Radiotherapie` | Radiotherapy only (applied at t=100h) |
| `ROCK1 Inhibition` | Drug therapy only (ROCK1 inhibition) |
| `Bachelor Arbeit Code` | Combined therapy (ROCK1 + radiotherapy) |
| `Plot Mean` | 100-run mean trajectories (physiological) |
| `Kummuliert.jl` | Comparative plots across all 4 scenarios |
| `Eigenwerte.jl` | Stationary distribution via eigenvalue analysis |

Note: files without a `.jl` extension are valid Julia scripts — the extension was omitted in the original thesis code.

See `../docs/` for full documentation and `../src/` for the reproducibility-ready copies.
