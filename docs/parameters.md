# Parameters

All parameters used in the thesis simulations. This table is the authoritative reference — values are taken directly from Table 4.1 (thesis p. 39) and the appendix code listing (pp. 59–60).

---

## Transition Rate Parameters

All rates have unit **h⁻¹** (per hour). Propensity = rate × current cell count.

| Symbol | Code index | Description | Value (h⁻¹) | Source |
|---|---|---|---|---|
| bE | rates[1] | EP birth rate | 0.0054 | Heidelberg collaborators |
| dE | rates[2] | EP death rate | 0.0004 | Heidelberg collaborators |
| sE→M | rates[3] | EP → MP switch rate | 0.0265 | Heidelberg collaborators |
| sE→D | rates[4] | EP → Diff switch rate (base) | 0.0008 | Heidelberg collaborators |
| bM | rates[5] | MP birth rate | 0.002 | Heidelberg collaborators |
| dM | rates[6] | MP death rate | 0.0018 | Heidelberg collaborators |
| sM→E | rates[7] | MP → EP switch rate | 0.0176 | Heidelberg collaborators |
| sM→D | rates[8] | MP → Diff switch rate | 0.0121 | Heidelberg collaborators |
| bD | rates[9] | Diff birth rate | 0.001 | Heidelberg collaborators |
| dD | rates[10] | Diff death rate | **0** | Heidelberg collaborators |
| sD→E | rates[11] | Diff → EP switch rate | 0.0019 | Heidelberg collaborators |
| sD→M | rates[12] | Diff → MP switch rate | 0.0201 | Heidelberg collaborators |
| dR | rates[13] | ROCK1 drug decay rate | 0.011 | Theoretical estimate (not validated) |

**Note on dD = 0:** Differentiated cells have no death rate in this model. This is a modeling choice reflecting their structural stability within the tumor network.

**Note on transition rate sources:** The 12 cell transition rates were determined in collaboration with Stella Soyka and Nirosan Sivapalan (Neurological Clinic, National Center for Tumor Diseases, University Hospital Heidelberg). These are not independently published values — they were provided specifically for this thesis.

---

## Drug and Therapy Parameters

| Symbol | Description | Value | Source |
|---|---|---|---|
| α | ROCK1 drug effect multiplier on EP→Diff rate | 100 | Theoretical estimate |
| dR | ROCK1 decay rate | 0.011 h⁻¹ | Theoretical estimate |
| γE | EP survival fraction after radiotherapy | 0.0952380952... (≈ 1/10.5) | Heidelberg collaborators |
| γM | MP survival fraction after radiotherapy | 0.1395348837... (≈ 6/43) | Heidelberg collaborators |
| γD | Diff survival fraction after radiotherapy | 0.3333333333... (= 1/3) | Heidelberg collaborators |

**Exact code values:**
```julia
rt_dying_percentage = [0.0952380952380952, 0.13953488372093, 0.333333333333333]
```

**Note on α = 100:** This means the EP→Diff transition fires 100× faster while ROCK1 is present. This is a theoretical estimate — no experimental data on the exact magnitude of ROCK1 inhibition effect was available.

**Note on dR = 0.011 h⁻¹:** Chosen so the drug is near-completely decayed by ~168h (half of the 336h simulation). Not experimentally validated. Half-life = ln(2)/0.011 ≈ 63 hours.

---

## Simulation Settings

| Setting | Value | Rationale |
|---|---|---|
| Initial state: EP | 10 cells·µm⁻³ | Literature-guided |
| Initial state: MP | 10 cells·µm⁻³ | Literature-guided |
| Initial state: Diff | 10 cells·µm⁻³ | Literature-guided |
| Initial state: ROCK1 | 10 units | Arbitrary unit count |
| Simulation duration | 336 hours (14 days) | 1 week pre-therapy + 1 week post-therapy |
| Radiotherapy time | 100 hours | After ~4 days of baseline observation |
| Random seed | 100 (or 1234 in some files) | Set for reproducibility |
| Number of mean runs | 100 | For mean trajectory plots |

---

## Net Growth Rates

From the parameters above:

| Phenotype | Net growth rate (b − d) | Per day |
|---|---|---|
| EP | 0.0054 − 0.0004 = **0.0050 h⁻¹** | 0.12 day⁻¹ |
| MP | 0.002 − 0.0018 = **0.0002 h⁻¹** | 0.0048 day⁻¹ |
| Diff | 0.001 − 0 = **0.001 h⁻¹** | 0.024 day⁻¹ |

Literature range for tumor net growth: 0.008–0.25 per day [4]. The EP net growth of 0.12 day⁻¹ falls within this range.

---

## Parameter Sensitivity and Limitations

As stated in the thesis:

> "The system behavior (e.g. the probability of ending in different scenarios) strongly depends on the choice of certain parameters. To make reliable predictions, data is required to obtain more secure estimates for the key parameters."

Known uncertainties:
- ROCK1 decay rate and effect multiplier are theoretical estimates
- Transition rates come from an unpublished clinical source (not independently verifiable)
- Initial cell counts are literature-guided, not patient-specific
- No sensitivity analysis was performed in the thesis
