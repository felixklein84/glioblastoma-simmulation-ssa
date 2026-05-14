# Thesis Summary

**Title:** Mathematische Hirntumormodellierung am Beispiel des Glioblastoms: Analyse der Zelldynamik und Therapieeffekte mittels zeitstetiger Markovketten

**English:** Mathematical Brain Tumor Modeling Using Glioblastoma as a Case Study: Analysis of Cell Dynamics and Therapy Effects via Continuous-Time Markov Chains

**Author:** Felix Klein  
**Submitted:** 30 September 2024  
**Supervisor:** Prof. Dr. Martin Slowik  
**Reviewer:** Prof. Dr. Leif Döring  
**Degree:** Bachelor of Science, University of Mannheim  
**Pages:** 71  
**Language:** German  

---

## Abstract (translated)

This thesis addresses the mathematical modeling of glioblastoma cell dynamics, an aggressive brain tumor characterized by high therapy resistance and rapid spread. The focus is on applying continuous-time Markov chains to analyze cell transitions between states of proliferation and migration. A stochastic model is developed to simulate and evaluate the effects of therapies including radiotherapy and drug therapy. The goal is to precisely map tumor cell dynamics and enable clinically relevant predictions that can contribute to optimizing therapeutic approaches.

---

## Core Contributions

1. **Three-state stochastic model** of glioblastoma population dynamics (EP, MP, Diff) using continuous-time Markov chains
2. **Gillespie SSA implementation** in Julia for generating stochastic trajectories
3. **Simulation of four scenarios:** physiological baseline, ROCK1 inhibition (drug), radiotherapy, and combined therapy
4. **Comparative analysis** of therapy effectiveness on tumor size and cell type composition

---

## Key Findings

| Scenario | Effect on Tumor |
|---|---|
| No therapy | Continuous growth driven by EP and MP proliferation |
| ROCK1 inhibition | Significant EP reduction; tumor redifferentiates; rebounds after drug decay (~168h) |
| Radiotherapy (t=100h) | Strong acute reduction in EP (~90%) and MP (~86%); Diff more resistant (survives ~33%); regrowth follows |
| Combined (ROCK1 + RT) | Most effective; sustained EP suppression; delayed regrowth; buys clinically relevant time |

---

## Model Summary

- **State space:** (E(t), M(t), D(t), R(t)) ∈ ℕ₀⁴ — counts of EP, MP, Diff cells and ROCK1 drug concentration
- **Dynamics:** Birth-death process + phenotype switching, described as a CTMC with 13 reaction channels
- **Algorithm:** Gillespie SSA — exact stochastic simulation
- **Time horizon:** 336 hours (14 days)
- **Initial state:** [10, 10, 10] cells per phenotype (+ 10 ROCK1 units where applicable)

---

## Limitations Stated in Thesis

- No spatial effects or tumor microenvironment
- No therapy resistance mechanisms
- No carrying capacity or competition terms
- Drug degradation rate (ROCK1, β = 0.011 h⁻¹) not experimentally validated
- Parameters partially based on estimates and theoretical considerations
- No pharmacokinetics/pharmacodynamics modeling

---

## Parameter Origins

| Parameter group | Source |
|---|---|
| Transition rates (sX→Y) | Collaboration with medical doctors at University of Heidelberg (Stella Soyka, Nirosan Sivapalan, NCT) |
| Net growth rates (b−d) | Literature [4]: between 0.008–0.25 per day |
| RT survival fractions (γE, γM, γD) | Collaboration with University of Heidelberg |
| ROCK1 decay rate (dR = 0.011 h⁻¹) | Not validated; chosen so drug decays in ~half of simulation |
| Drug effect multiplier (α = 100) | Theoretical estimate |
| Initial cell counts (10 each) | Literature-guided (cells·µm⁻³) |
| Simulation duration (336h) | Chosen to observe 1 week before and after therapy |
