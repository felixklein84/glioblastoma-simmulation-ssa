# Chapter 1 & 2 — Introduction and Mathematical Foundations

> Thesis pages 1–28. Source: Arbeit_abgeschickt.pdf

---

## 1. Introduction (p. 7)

**Research goal:** Develop a mathematical model of glioblastoma cell population dynamics using stochastic processes, incorporating therapy effects (radiotherapy and drug therapy).

**Model basis:** Stochastic birth-death process on three cell types:
- **EP** — Early Progenitors
- **MP** — Metastable Progenitors
- **Diff** — Differentiated Cells

Each cell type has specific growth and differentiation rates that vary with therapeutic interventions.

**Key themes:**
- Transition rates between cell types as stochastic processes
- Generator of the stochastic process
- Explosion analysis (as model of uncontrolled tumor growth)
- Numerical simulation to understand complex dynamics

---

## 1.1 Mathematical Foundations (p. 8–11)

Based on Klenke [9] and Norris [12].

### Stochastic Processes
- Family of (E,ε)-valued random variables X = (Xᵢ)ᵢ∈I on probability space (Ω, F, P)
- State space E, index set I (discrete or continuous)
- Trajectory/path: function t ↦ Xₜ(ω) for fixed ω

### Polish Space (Definition 1.1.1)
A topological space (E, ρ) is Polish if completely metrizable and separable.

### Filtrations (Definition 1.1.5)
Increasing family of sub-σ-algebras (Fₜ)ₜ≥₀: Fs ⊆ Fₜ ⊆ F∞ for s ≤ t.

### Discrete Markov Chains (1.1.4)
Markov property: P[Xₙ₊₁ = xₙ₊₁ | X₀,...,Xₙ] = P[Xₙ₊₁ = xₙ₊₁ | Xₙ]

**Transition matrix P = (p(x,y)):** stochastic matrix with p(x,y) ≥ 0 and Σᵧ p(x,y) = 1.

---

## 2. Continuous-Time Markov Chains (p. 12–28)

Main reference: [14] (Scheutzow).

### Key Distinction from Discrete MC
- Continuous time index t ∈ ℝ≥₀
- State changes can occur at any time t ≥ 0
- Process stays in initial state for random holding time, then jumps

### CTMC Markov Property (p. 12)
For any 0 ≤ t₁ < t₂ < ... < tₙ < tₙ₊₁ and states x₁,...,xₙ₊₁:

P[Xₜₙ₊₁ = xₙ₊₁ | Xₜ₁ = x₁,...,Xₜₙ = xₙ] = P[Xₜₙ₊₁ = xₙ₊₁ | Xₜₙ = xₙ]

### Standard Transition Function (Definition 2.1.1)
Family (Pₜ)ₜ≥₀ satisfying:
- (i) pₜ(x,y) ≥ 0
- (ii) Σᵧ pₜ(x,y) ≤ 1 (markovian if equality)
- (iii) Chapman-Kolmogorov: pₜ₊ₛ(x,y) = Σz pₜ(x,z)pₛ(z,y)
- (iv) limₜ→₀ pₜ(x,y) = δₓᵧ (standard)

### Generator Matrix Q (p. 11)
Q-matrix (q(x,y))ₓ,ᵧ∈E characterizes the CTMC:
- Off-diagonal: q(x,y) ≥ 0, x ≠ y (transition rates)
- Diagonal: q(x,x) = −Σᵧ≠ₓ q(x,y) (total exit rate, negative)

**Kolmogorov equations:**
- **Backward:** P'ₜ = QPₜ
- **Forward:** P'ₜ = PₜQ

### Jump Process (p. 16–19)

The CTMC can be viewed as a jump process:
1. Enter state x at time τₙ
2. Holding time in x: Tₓ ~ Exp(q(x)) where q(x) = −q(x,x)
3. Jump to state y at time τₙ₊₁ with probability p(x,y) = q(x,y)/q(x)
4. Jump chain (Yₙ) is a discrete MC with matrix p(x,y)

### Explosion in Finite Time (p. 24–26)

**Definition 2.5.2:** A CTMC is non-explosive if Pₓ[τ = ∞] = 1 for all x ∈ E.

**Example 2.5.1:** Cell division with rate q(x, x+1) = x(x+1)/2.
Expected explosion time: E[τ] = 2 (finite! — process explodes).

**Non-explosion conditions (Proposition 2.5.3):**
- E is finite, OR
- supₓ q(x) < ∞ (bounded rates)

**Biological relevance:** Since the glioblastoma model has positive net growth for EP cells and no carrying capacity, explosion is theoretically possible. The thesis argues this is negligible for short time horizons (14 days) used in simulations.

### Birth-Death Processes (p. 27–28)

Special CTMC where state = population size, transitions only ±1.

Q-matrix:
- q(x, x+1) = λₓ (birth rate)
- q(x, x−1) = µₓ (death rate)
- q(x, x) = −(λₓ + µₓ)

The glioblastoma model extends this to three coupled birth-death processes with additional phenotype-switching transitions.
