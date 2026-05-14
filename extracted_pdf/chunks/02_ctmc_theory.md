# Chapter 2 — CTMC Theory: Key Definitions for the Model

> Extracted from thesis pp. 6–28 for model-relevant theory. Full proofs omitted.
> Source: Arbeit_abgeschickt.pdf

---

## How CTMCs Connect to the Simulation

The glioblastoma model is a CTMC on state space ℕ₀⁴ (EP count, MP count, Diff count, ROCK1 count).

The theoretical machinery in Chapter 2 justifies:
1. **The existence** of such a process (Theorem 2.1.5 via Kolmogorov's extension theorem)
2. **The generator** as the primary characterization (Section 2.2)
3. **The jump process view** which directly motivates the Gillespie algorithm (Section 2.3)
4. **Explosion analysis** to bound the validity of the model (Section 2.5)

---

## Generator of the Glioblastoma Process (p. 36)

The generator for a general event ω with state change vω and rate rω(N) is:

```
Lφ(N) = Σ_{ω∈Ω} [φ(N + vω) − φ(N)] · rω(N)
```

for bounded measurable functions φ: ℕ₀⁴ → ℝ.

**Each reaction channel ω contributes one term:**
- vω = stoichiometric vector (how state changes)
- rω(N) = propensity = rate × current count of relevant cell type

This is the continuous-time analog of: expected change per unit time = Σ (change if event) × (probability of event per unit time).

---

## Jump Process as Gillespie Algorithm (p. 16–19, 37–38)

The jump process construction directly gives the SSA:

**At each step, given current state N:**

1. Compute total propensity: r₀(N) = Σⱼ rⱼ(N)
2. Generate waiting time: τ ~ Exp(r₀(N))
3. Generate reaction index j ~ Categorical(rⱼ(N)/r₀(N))
4. Update: t → t + τ, N → N + vⱼ

This is exact — no approximation. The SSA samples from the true distribution of the CTMC.

---

## Explosion Argument for the Glioblastoma Model (p. 37)

The model allows theoretically unbounded growth (no carrying capacity). The thesis argues:

> "Although the model theoretically allows explosion, it is still useful for practical purposes and short time intervals. In realistic biological systems and clinical applications, explosions do not occur, as physical and biological constraints prevent unlimited growth. For short time intervals, the probability of explosion is negligibly small."

**Consequence for simulation:** The 336-hour time horizon is chosen as a regime where explosion probability is negligible and the model gives reliable predictions.

---

## Stationary Distribution (used in Eigenwerte.jl)

The transition matrix P used for eigenvalue analysis (pp. in appendix code):

```
P = [0.6716  0.3182  0.0102]
    [0.2111  0.6433  0.1456]
    [0.0227  0.2412  0.7361]
```

The stationary distribution π satisfies πP = π (left eigenvector for eigenvalue 1 of Pᵀ).

This gives the long-run expected proportions of EP, MP, Diff cells.
