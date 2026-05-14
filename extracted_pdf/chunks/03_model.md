# Chapter 3 — Glioblastoma Model

> Thesis pages 29–38. Source: Arbeit_abgeschickt.pdf

---

## 3.1 Biology of Glioblastoma (p. 29–31)

**Glioblastoma (GBM):**
- Most common malignant brain tumor in adults (~78% of primary malignant brain tumors)
- Arises from glial cells of the central nervous system
- 5-year survival rate: ~5% (IDH-wildtype, most common form)
- Challenges: aggressive spread, rapid division, infiltrative invasion — surgical removal nearly impossible

**Key biological features:**
- **Phenotypic heterogeneity:** Different cell types with different behaviors within the same tumor
- **"Go-or-Grow" dichotomy:** Cells either migrate ("Go") OR proliferate ("Grow") — adaptation to environment
- **Tumor microtubules:** Ultrathin membrane extensions connecting cells, enabling communication via gap junctions — central to therapy resistance
- **Network formation:** Cells form networks resistant to treatment; neuronal activity can further stimulate these networks

---

## 3.2 Three Phenotypes (p. 30–31)

Source: Soyka & Sivapalan [16] (unpublished, Heidelberg NCT); Lan et al. [10]

### EP — Early Progenitors
- Most immature phenotype
- **High division rate** and pluripotency (can develop into different cell types)
- Long-term therapy resistant: strong self-renewal and environmental adaptation
- **Highly migratory** — can infiltrate new brain regions
- **Radiosensitive** — respond to radiotherapy

### MP — Metastable Progenitors
- Intermediate state between EP and Diff
- Both **proliferative and migratory** — particularly dangerous
- Can remain near primary tumor OR migrate to distant brain regions
- Flexible — change properties based on environmental signals
- **More resistant to radiotherapy** than EP

### Diff — Differentiated Cells
- Most mature phenotype
- **Less division and migration** capability
- Form large, stationary networks with other tumor cells and astrocytes
- **Resistant to treatment** via structural network integrity
- Can rarely de-differentiate back to undifferentiated state
- Contribute to structural tumor integrity

---

## 3.3 Mathematical Model (p. 34–36)

### State Space

The model is a CTMC {N(t)}ₜ≥₀ on ℕ₀⁴:

```
N(t) = (E(t), M(t), D(t), R(t))
```

Where:
- **E(t):** Number of EP cells at time t
- **M(t):** Number of MP cells at time t
- **D(t):** Number of Diff cells at time t
- **R(t):** ROCK1 drug concentration at time t (discrete count, decays over time)

### 3.3.1 Model Assumptions (p. 34)

- Birth-death process with three phenotypic cell types
- Cells can switch between differentiation states
- All biological influences (age-dependent differentiation, extracellular matrix interactions, etc.) are **strongly simplified** and treated as stochastic effects
- ROCK1 drug **accelerates EP→Diff transition** by factor α and decays over time
- Radiotherapy **reduces all three populations** at a single time point
- No carrying capacity / no competition for resources
- No spatial effects

### 3.3.2 Reaction Channels (p. 35–36)

**Birth and death processes (6 channels):**

| Reaction | State change | Rate |
|---|---|---|
| EP birth | +δE | bE · E(t) |
| EP death | −δE | dE · E(t) |
| MP birth | +δM | bM · M(t) |
| MP death | −δM | dM · M(t) |
| Diff birth | +δD | bD · D(t) |
| Diff death | −δD | dD · D(t) |

**Phenotype switching (6 channels):**

| Reaction | State change | Rate |
|---|---|---|
| EP → MP | −δE + δM | sE→M · E(t) |
| EP → Diff | −δE + δD | α · sE→D · E(t) if R(t)>0; else sE→D · E(t) |
| MP → EP | −δM + δE | sM→E · M(t) |
| MP → Diff | −δM + δD | sM→D · M(t) |
| Diff → EP | −δD + δE | sD→E · D(t) |
| Diff → MP | −δD + δM | sD→M · D(t) |

**Drug decay (1 channel):**

| Reaction | State change | Rate |
|---|---|---|
| ROCK1 decay | −δR | dR · R(t) |

**Total: 13 reaction channels**

### 3.3.3 Drug Effect (ROCK1 Inhibition)

The drug **amplifies the EP→Diff transition rate** by factor α = 100 while R(t) > 0.

Biological meaning: ROCK1 inhibition promotes differentiation of early progenitor cells, converting aggressive stem-like EP cells into less dangerous differentiated cells — making them more amenable to surgical removal.

### 3.3.4 Generator (p. 36)

```
Lφ(N) = Σ_{ω∈Ω} [φ(N + vω) − φ(N)] · rω(N)
```

### 3.3.5 Explosion Possibility (p. 37)

Positive net growth rate for EP cells + no carrying capacity → theoretical explosion possible.

**Mitigation:** For short time intervals (336h clinical window), explosion probability is negligible.

---

## 3.4 Stochastic Simulation Algorithm (p. 37–38)

Algorithm from Masuda & Vestergaard [11] (Gillespie SSA).

**At each step:**

1. Compute propensities rⱼ(N) for each of the 13 reaction channels
2. Compute total rate: r₀(N) = Σⱼ rⱼ(N)
3. **Time step:** sample s ~ Exp(r₀(N)); update t → t + s
4. **Reaction selection:** sample index j ~ Categorical(rⱼ(N)/r₀(N)); update N → N + vⱼ
5. Repeat until t ≥ max_time

**Properties:**
- Exact simulation (no approximation)
- Propensities change after every event → distributions change dynamically
- Code in appendix (pp. 55–60); implementation in `Main/` directory

---

## Biological Model Systems Context (p. 32–33)

**In vivo experiments** (Venkataramani et al. [18]):
- Mice implanted with skull window
- Patient-derived GBM cells injected + fluorescent markers (SR101)
- Observed 3 weeks post-implantation via microscopy
- SR101 used to distinguish phenotypes
- Limitation: time-consuming, cannot observe full brain simultaneously

**In vitro experiments:**
- Tumor cells from patient samples cultured in lab
- More controlled but don't fully reflect in vivo complexity
- Cells may adopt broader, less specialized forms in culture

**Mathematical models as complement:** Enable testing hypotheses without biological experiments, flexible scenario exploration.

---

## Notes for Documentation

- The transition rates (sX→Y) were **determined in collaboration with medical doctors at the University of Heidelberg** (Stella Soyka, Nirosan Sivapalan, NCT). This is stated explicitly in the thesis (p. 40).
- The radiotherapy survival fractions (γE, γM, γD) were also **provided by the Heidelberg collaborators**.
- The drug decay rate (β = 0.011 h⁻¹) and drug effect multiplier (α = 100) are **theoretical estimates not experimentally validated**.
