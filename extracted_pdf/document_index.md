# Thesis Index

## Table of Contents (original)

| Chapter | Title (German) | Pages | Chunk file |
|---|---|---|---|
| 1 | Einführung (Introduction) | 1–5 | `chunks/01_intro_math_foundations.md` |
| 1.1 | Grundlagen — Stochastische Prozesse, Polish spaces, Filtrations, Discrete MC | 2–5 | `chunks/01_intro_math_foundations.md` |
| 2 | Zeitstetige Markovketten (Continuous-Time Markov Chains) | 6–28 | `chunks/02_ctmc_theory.md` |
| 2.1 | Definitions and Assumptions | 6–9 | `chunks/02_ctmc_theory.md` |
| 2.2 | Generator Matrix Q | 11–15 | `chunks/02_ctmc_theory.md` |
| 2.3 | Jump Process | 16–19 | `chunks/02_ctmc_theory.md` |
| 2.4 | Kolmogorov Forward/Backward Equations | 20–23 | `chunks/02_ctmc_theory.md` |
| 2.5 | Explosion in Finite Time | 24–26 | `chunks/02_ctmc_theory.md` |
| 2.6 | Birth-Death Processes | 27–28 | `chunks/02_ctmc_theory.md` |
| 3 | Modellierung des Glioblastoms (Glioblastoma Modeling) | 29–38 | `chunks/03_model.md` |
| 3.1 | Biology of Glioblastoma | 29–31 | `chunks/03_model.md` |
| 3.2 | Biological Model Systems (in vivo / in vitro) | 32–33 | `chunks/03_model.md` |
| 3.3 | Mathematical Model of Population Dynamics | 34–36 | `chunks/03_model.md` |
| 3.4 | Stochastic Simulation Algorithm | 37–38 | `chunks/03_model.md` |
| 4 | Ergebnisse (Results) | 39–49 | `chunks/04_results.md` |
| 4.1 | Parameter Choice | 39–40 | `chunks/04_results.md` |
| 4.2.1 | Physiological Model Results | 40–41 | `chunks/04_results.md` |
| 4.2.2 | ROCK1 Inhibition Results | 41–43 | `chunks/04_results.md` |
| 4.2.3 | Radiotherapy Results | 43–44 | `chunks/04_results.md` |
| 4.2.4 | Combined Therapy Results | 45–46 | `chunks/04_results.md` |
| 4.3 | Therapy Effect Analysis | 47–48 | `chunks/04_results.md` |
| 4.4 | Justification for Using CTMCs | 48–49 | `chunks/04_results.md` |
| 5 | Fazit (Conclusion) | 50–54 | `chunks/04_results.md` |
| Appendix | Code listing + supplementary theorems | 55–60 | `chunks/05_appendix_code.md` |
| References | 18 references | 64–65 | `chunks/05_appendix_code.md` |

---

## Key Concepts by Page

| Page | Key content |
|---|---|
| 3 | Abstract |
| 7 | Introduction — EP/MP/Diff model motivation |
| 30 | Definition of three phenotypes |
| 34–36 | Model assumptions, state space, generator |
| 37–38 | Gillespie SSA description |
| 39 | **Parameter table** (all rates with units) |
| 40 | **Initial conditions** and parameter justification |
| 55–60 | **Full annotated Julia source code** (appendix) |
| 64–65 | **References** (18 sources) |

---

## References (complete)

1. Alfonso et al. — Biology and mathematical modeling of glioma invasion (2017)
2. Allen — Introduction to stochastic processes with applications to biology (2010)
3. Anderson — Continuous-time Markov chains: Applications-oriented approach (2012)
4. Baar et al. — A stochastic model for immunotherapy of cancer, *Scientific Reports* (2016)
5. Chung — Markov chains, Springer-Verlag (1967)
6. Conte & Surulescu — Mathematical modeling of glioma invasion, *Applied Mathematics and Computation* (2021)
7. Dwivedi et al. — Game-theoretical description of go-or-grow dichotomy, *Scientific Reports* (2023)
8. Hiemke — Pharmakokinetik, Pharmakodynamik und Interaktionen (2016)
9. Klenke — Wahrscheinlichkeitstheorie, Springer (2006)
10. Lan et al. — Fate mapping of human glioblastoma reveals invariant stem cell hierarchy, *Nature* (2017)
11. **Masuda & Vestergaard — Gillespie Algorithms for Stochastic Multiagent Dynamics, Cambridge UP (2023)** ← SSA algorithm source
12. Norris — Markov chains, Cambridge UP (1998)
13. Oliveira et al. — Crosstalk between glial and glioblastoma cells (2017)
14. Scheutzow — Stochastische Modelle (2011)
15. Slowik — Vorlesungsskript Stochastic Processes (unpublished, FSS2024)
16. **Soyka & Sivapalan — Uncovering therapeutic vulnerabilities with a dynamic glioblastoma atlas (unpublished PowerPoint, 2024)** ← phenotype definitions and transition rates source
17. Tetzlaff et al. — Characterizing and targeting glioblastoma neuron-tumor networks, *bioRxiv* (2024)
18. Venkataramani et al. — Glioblastoma hijacks neuronal mechanisms for brain invasion, *Cell* (2022)
