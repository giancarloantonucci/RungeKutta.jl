"""
    ExplicitRungeKuttaSolver <: AbstractRungeKuttaSolver

A composite type for explicit solvers.

# Constructors
```julia
ExplicitRungeKuttaSolver(tableau, stepsize[, adaptive])
ERK(args...; kwargs...)
```

# Arguments
- `tableau :: AbstractButcherTableau`
- `stepsize :: Union{AbstractStepSize, Real}`
- `adaptive :: Union{AbstractAdaptiveParameters, Nothing}`

# Methods

    (solver::ExplicitRungeKuttaSolver)(solution::AbstractRungeKuttaSolution, problem::AbstractInitialValueProblem) :: RungeKuttaSolution
    (solver::ExplicitRungeKuttaSolver)(problem::AbstractInitialValueProblem) :: RungeKuttaSolution
    
returns the `solution` of a `problem` using `solver`.
"""
struct ExplicitRungeKuttaSolver{tableau_T<:AbstractButcherTableau, stepsize_T<:AbstractStepSize, adaptive_T<:Union{AbstractAdaptiveParameters, Nothing}} <: AbstractRungeKuttaSolver
    tableau::tableau_T
    stepsize::stepsize_T
    adaptive::adaptive_T
end

ExplicitRungeKuttaSolver(tableau::AbstractButcherTableau, h::Real, adaptive::Union{AbstractAdaptiveParameters, Nothing}) = ExplicitRungeKuttaSolver(tableau, StepSize(h), adaptive)
ExplicitRungeKuttaSolver(tableau::AbstractButcherTableau, stepsize::Union{AbstractStepSize, Real}) = ExplicitRungeKuttaSolver(tableau, stepsize, nothing)
@doc (@doc ExplicitRungeKuttaSolver) ERK(args...; kwargs...) = ExplicitRungeKuttaSolver(args...; kwargs...)

#####
##### Methods
#####

(solver::ExplicitRungeKuttaSolver)(solution::AbstractRungeKuttaSolution, problem::AbstractInitialValueProblem) = solve!(solution, problem, solver)
(solver::ExplicitRungeKuttaSolver)(problem::AbstractInitialValueProblem) = solve(problem, solver)