# Full Thesis Extraction

**Title:** Mathematische Hirntumormodellierung am Beispiel des Glioblastoms: Analyse der Zelldynamik und Therapieeffekte mittels zeitstetiger Markovketten

**Author:** Felix Klein | **Date:** 30 September 2024 | **Pages:** 71  
**Supervisor:** Prof. Dr. Martin Slowik | **Reviewer:** Prof. Dr. Leif Döring  
**University:** University of Mannheim | **Degree:** Bachelor of Science

> This file is the complete extracted and structured text of the thesis PDF.
> Images referenced in the thesis are not reproduced here.
> For concise notes, see the chunk files. For the parameter table, see `chunks/04_results.md`.

---

## Navigating this extraction

| Content | File |
|---|---|
| Summary, abstract, key findings | `document_summary.md` |
| Table of contents + all 18 references | `document_index.md` |
| Ch. 1–2: Introduction + CTMC theory | `chunks/01_intro_math_foundations.md` |
| Ch. 2: CTMC theory connected to model | `chunks/02_ctmc_theory.md` |
| Ch. 3: Glioblastoma model (biology + math) | `chunks/03_model.md` |
| Ch. 4–5: Results + conclusion | `chunks/04_results.md` |
| Appendix: Code listing + abbreviations | `chunks/05_appendix_code.md` |

---

## Abstract (p. 3, translated)

This thesis addresses the mathematical modeling of glioblastoma cell dynamics, an aggressive brain tumor characterized by high therapy resistance and rapid spread. The focus is on applying continuous-time Markov chains to analyze cell transitions between states of proliferation and migration. A stochastic model is developed to simulate and evaluate the effects of therapies including radiotherapy and drug therapy. The goal is to precisely map tumor cell dynamics and enable clinically relevant predictions that can contribute to optimizing therapeutic approaches.

---

## Acknowledgements (p. 4)

Special thanks to:
- **Prof. Dr. Martin Slowik** — supervision and patience through numerous discussions; opened the door to mathematical modeling
- **Stella Soyka and Nirosan Sivapalan** (Neurological Clinic and National Center for Tumor Diseases, University Hospital Heidelberg) — careful preparation and provision of data essential to the work

These two Heidelberg collaborators are the source of the transition rates and radiotherapy survival fractions used in the model.

---

## Chapter 1: Introduction (p. 7)

[See `chunks/01_intro_math_foundations.md`]

Key points:
- GBM is among the most aggressive malignant brain tumors
- Complex heterogeneity + invasion capacity
- Model uses stochastic birth-death process on EP/MP/Diff cell types
- Focus on transition rates between cell types as stochastic processes
- Generator of the process connects to CTMC theory
- Explosion analysis = uncontrolled tumor growth
- Numerical simulations support theoretical analysis

---

## Chapter 2: Continuous-Time Markov Chains (p. 6–28)

[See `chunks/01_intro_math_foundations.md` and `chunks/02_ctmc_theory.md`]

Sections covered:
- 2.1 Standard transition functions (Definition 2.1.1)
- 2.2 Generator matrix Q
- 2.3 Jump process construction → directly motivates Gillespie SSA
- 2.4 Kolmogorov forward/backward equations
- 2.5 Explosion in finite time (with cell division example)
- 2.6 Birth-death processes

---

## Chapter 3: Glioblastoma Model (p. 29–38)

[See `chunks/03_model.md`]

Key content:
- GBM biology, phenotypic heterogeneity, go-or-grow dichotomy
- Three phenotypes: EP, MP, Diff
- In vivo and in vitro experimental context
- Mathematical model: state space ℕ₀⁴, 13 reaction channels, generator
- Gillespie SSA algorithm description

---

## Chapter 4: Results (p. 39–49)

[See `chunks/04_results.md`]

**CANONICAL PARAMETER TABLE on p. 39** — reproduced in full in `chunks/04_results.md`.

Scenarios:
1. Physiological (no therapy): stable dynamics, MP dominant
2. ROCK1 inhibition: EP suppressed while drug active, rebounds after decay
3. Radiotherapy (t=100h): strong acute reduction, regrowth from Diff
4. Combined: most effective, sustained EP suppression

---

## Chapter 5: Conclusion (p. 50–54)

[See `chunks/04_results.md`]

- Combined therapy most promising
- Limitations: no spatial effects, no resistance, no PK/PD
- Future extensions: branching processes, spatial models, pharmacokinetics

---

## Appendix (p. 55–60)

[See `chunks/05_appendix_code.md`]

- Julia language rationale
- Full annotated SSA code listing (canonical implementation)
- All 13 reaction channels with transitions and propensity functions
- Canonical parameter values in code form
- Note: possible copy-paste error in RT application (both MP and Diff use γD index)

---

## References (p. 64–65)

[See `document_index.md` for complete list]

Key references for model:
- [11] Masuda & Vestergaard — Gillespie algorithm (SSA source)
- [16] Soyka & Sivapalan — Phenotype data + transition rates (Heidelberg, unpublished)
- [4] Baar et al. — Net growth rate range (0.008–0.25/day)
- [18] Venkataramani et al. — GBM neuronal invasion biology
- [9] Klenke; [12] Norris — CTMC mathematical foundations
