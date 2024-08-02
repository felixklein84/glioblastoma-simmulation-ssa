using JumpProcesses, Plots

rate(u, p, t) = p.λ
affect!(integrator) = (integrator.u[1] += 1)
crj = ConstantRateJump(rate, affect!)

u₀ = [0]
p = (λ = 2.0,)
tspan = (0.0, 10.0)

dprob = DiscreteProblem(u₀, tspan, p)
jprob = JumpProblem(dprob, Direct(), crj)

sol = solve(jprob, SSAStepper())
plot(sol, label = "N(t)", xlabel = "t", legend = :bottomright)