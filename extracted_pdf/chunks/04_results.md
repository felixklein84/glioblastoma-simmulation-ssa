# Chapter 4 & 5 — Results and Conclusion

> Thesis pages 39–54. Source: Arbeit_abgeschickt.pdf

---

## 4.1 Parameter Table (p. 39) — CANONICAL REFERENCE

This is the authoritative parameter table from the thesis. All values match the code.

| Parameter | Description | Value | Unit | Source |
|---|---|---|---|---|
| bE | Birth rate factor EP | 0.0054 | h⁻¹ | Heidelberg collaborators |
| bM | Birth rate factor MP | 0.002 | h⁻¹ | Heidelberg collaborators |
| bD | Birth rate factor Diff | 0.001 | h⁻¹ | Heidelberg collaborators |
| dE | Death rate factor EP | 0.0004 | h⁻¹ | Heidelberg collaborators |
| dM | Death rate factor MP | 0.0018 | h⁻¹ | Heidelberg collaborators |
| dD | Death rate factor Diff | 0 | h⁻¹ | Heidelberg collaborators |
| sE→M | Phenotype switch rate EP→MP | 0.0265 | h⁻¹ | Heidelberg collaborators |
| sE→D | Phenotype switch rate EP→Diff | 0.0008 | h⁻¹ | Heidelberg collaborators |
| sM→E | Phenotype switch rate MP→EP | 0.0176 | h⁻¹ | Heidelberg collaborators |
| sM→D | Phenotype switch rate MP→Diff | 0.0121 | h⁻¹ | Heidelberg collaborators |
| sD→E | Phenotype switch rate Diff→EP | 0.0019 | h⁻¹ | Heidelberg collaborators |
| sD→M | Phenotype switch rate Diff→MP | 0.0201 | h⁻¹ | Heidelberg collaborators |
| dR | ROCK1 drug decay rate | 0.011 | h⁻¹ | Theoretical estimate (not validated) |
| α | Drug effect multiplier (EP→Diff) | 100 | — | Theoretical estimate |
| γE | RT survival probability EP | 9.52% (= 1/10.5) | — | Heidelberg collaborators |
| γM | RT survival probability MP | 13.95% (≈ 1/7.17) | — | Heidelberg collaborators |
| γD | RT survival probability Diff | 33.33% (= 1/3) | — | Heidelberg collaborators |

**Initial state:** [10, 10, 10] cells·µm⁻³ for each phenotype (+ 10 ROCK1 units where applicable)

**Simulation duration:** 336 hours = 14 days (1 week before + 1 week after therapy)

**Radiotherapy applied at:** t = 100 hours

### Parameter Justification (p. 40)

- **Initial cell counts (10 each):** Literature-guided (cells·µm⁻³)
- **Net growth rates (b−d):** Range 0.008–0.25 per day from literature [4]
- **Transition rates:** Determined with Heidelberg medical collaborators
- **ROCK1 decay rate (0.011 h⁻¹):** Not validated; chosen so drug decays in ~half of 336h simulation (~168h); within typical range of oncology drugs
- **Radiotherapy survival fractions:** From Heidelberg collaborators
- **Simulation duration (336h):** 1 week observation before + after therapy

---

## 4.2.1 Physiological Model Results (p. 40–41)

**Scenario:** No therapy. Parameters as in Table 4.1. Initial state [10, 10, 10].

**Observations:**
- Cell counts show stochastic fluctuations but gradual increase, especially MP and Diff
- MPs dominate the tumor population, followed by EP and Diff
- No dramatic changes — stable dynamics without external intervention
- 100 simulations show rapid convergence to stable mean trajectories → model robustness

**Interpretation:** "The physiological model shows typical tumor development in stable equilibrium. No aggressive growth phases are observed." — consistent with unmodified tumor growth before treatment.

**Plots produced:**
- (a) Hourly cell counts by type (EP=green, MP=red, Diff=blue)
- (b) Relative proportions (stacked area)
- (c) Mean trajectories over 100 simulations

---

## 4.2.2 ROCK1 Inhibition Results (p. 41–43)

**Scenario:** Drug therapy only. Initial ROCK1 = 10 units. EP→Diff rate multiplied by α=100 while R(t)>0.

**Important caveat from thesis:** "The simulations serve primarily a theoretical purpose... no exact biological data on the actual influence of ROCK1 or the decay rate were available."

**ROCK1 is NOT classical chemotherapy** — it does not directly shrink the tumor. Its goal is to convert EP cells into Diff cells, making the tumor more amenable to surgical removal.

**Observations:**
- EP count strongly reduced while ROCK1 active
- Diff cells become the dominant population
- After ROCK1 concentration reaches zero (~168h): EP count rises again
- Cell proportion shifts back toward physiological pattern (EP dominates)
- Effect rapidly wears off after drug decay

**Interpretation:** "Therapy should be continued until tumor can be surgically removed." The model does not account for side effects or long-term ROCK1 effects.

**Plots produced:**
- (a) Hourly cell counts
- (b) ROCK1 concentration decay
- (c) Relative cell type proportions

---

## 4.2.3 Radiotherapy Results (p. 43–44)

**Scenario:** Radiotherapy applied at t = 100h. Survival fractions: EP=9.52%, MP=13.95%, Diff=33.33%.

**Observations:**
- Before t=100h: tumor grows as in physiological model
- At t=100h: EP and MP reduced to ~10% of pre-RT size; EP nearly eliminated
- Diff cells show significantly higher resistance (33% survival) — "robust and less sensitive to radiation"
- After RT: populations stabilize at low level for ~100h, then regrowth begins, especially MP
- Tumor eventually returns to physiological-like dynamics

**Interpretation:** "Radiotherapy shows high effectiveness against EP and MP... However, Diff cells survive in greater numbers and can provide the basis for renewed tumor growth. Short-term highly effective, but insufficient for long-term control."

**Plots produced:**
- (a) Hourly cell counts
- (b) Relative cell type proportions

---

## 4.2.4 Combined Therapy Results (p. 45–46)

**Scenario:** ROCK1 inhibition from t=0 + radiotherapy at t=100h. Same parameters as individual scenarios — allows direct comparison.

**Observations:**
- Tumor grows more slowly (ROCK1 differentiating EPs)
- After radiotherapy: EP count remains near zero
- Diff and MP cells drop drastically after RT
- Even after ROCK1 fully decayed (~200h): no significant growth surge
- Cell proportions shift slightly toward EP, but no strong growth as in physiological model
- Populations remain in stable state with mainly cell transitions rather than divisions

**Interpretation:** "By combined therapy, valuable time can be gained." Synergy between both approaches achieves sustained EP suppression and delayed regrowth.

**Plots produced:**
- (a) Total cell counts over time
- (b) Relative cell type proportions

---

## 4.3 Comparative Analysis (p. 47–48)

**Figure 4.5a — Tumor size comparison (all 4 scenarios):**
- No therapy: continuous growth
- ROCK1: tumor not directly reduced but composition changes
- Radiotherapy: immediate strong reduction, then regrowth
- Combined: most effective; sustained low tumor size

**Figure 4.5b — EP count comparison (all 4 scenarios):**
- No therapy: rapid EP expansion
- ROCK1: significant EP reduction
- Radiotherapy: strong initial reduction, regrowth
- Combined: sustained EP suppression

**Conclusion from analysis:** "Combined therapy targeting both proliferating and differentiated cell types potentially achieves better results than monotherapies."

---

## 4.4 Justification for CTMC Approach (p. 48–49)

Why continuous-time Markov chains?

1. **Captures randomness:** Cell division, cell death, and phenotype switching are inherently stochastic — deterministic models cannot capture this
2. **Continuous time transitions:** State changes at any moment — realistic vs. discrete steps
3. **Clinical consistency:** Observed tumor regrowth patterns after therapy match clinical observations
4. **Robustness:** 100-simulation mean trajectories show consistent patterns despite stochastic variation

**Limitation:** "The system behavior strongly depends on parameter choice. Reliable predictions require data for more robust parameter estimates."

---

## 5. Conclusion (p. 50–54)

### Summary (p. 50–51)

- EP and MP are the main drivers of tumor growth in the physiological scenario
- ROCK1 inhibition: clear EP reduction, but tumor rebounds after drug decay
- Radiotherapy: most immediately effective, but insufficient for long-term control due to Diff cell resistance
- **Combined therapy:** most effective — suppresses growth and delays recurrence

### Limitations of the Work (p. 51–52)

1. Parameter choice partially based on experimental data from Heidelberg; other parameters theoretical
2. No spatial effects or tumor microenvironment interactions
3. No therapy resistance mechanisms
4. No carrying capacity or competition terms
5. Drug assumed to act instantaneously (no pharmacokinetics/pharmacodynamics)

### Future Extensions (p. 52–53)

1. **Branching process model** — model individual division events; study rare events (extinction, resistant cell lines)
2. **Spatial and temporal effects** — partial differential equations for tumor invasion; nutrient gradients; blood vessel effects
3. **Additional therapy effects** — pharmacokinetics (delayed drug buildup); drug-cell interactions reducing drug effectiveness

### Closing Remark (p. 53–54)

> "The proposed model extensions offer multiple possibilities to increase complexity and realism. By incorporating additional biological processes and more detailed therapy representations, the model can contribute to better understanding glioblastoma dynamics. Future work should aim to integrate these extensions stepwise and validate the model with experimental and clinical data."
