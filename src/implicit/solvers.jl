"""
    BackwardEuler(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver
    ImplicitEuler(args...; kwargs...) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 1st-order backward Euler method.
"""
function BackwardEuler(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1 1;
        1 1;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

@doc (@doc BackwardEuler) function ImplicitEuler(args...; kwargs...)
    return BackwardEuler(args...; kwargs...)
end

"""
    ImplicitMidpoint(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 2nd-order implicit midpoint method.
"""
function ImplicitMidpoint(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1/2 1/2;
         2   1 ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    CrankNicolson(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 2nd-order Crank-Nicolson method.
"""
function CrankNicolson(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        0   0   0 ;
        1  1/2 1/2;
        2  1/2 1/2;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    SDIRK3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 3rd-order SDIRK method.
"""
function SDIRK3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    γ = 1/2 + √3/6
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
         γ    γ   0 ;
        1-γ 1-2γ  γ ;
         3   1/2 1/2;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    GaussLegendre4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver
    GL4(args...; kwargs...) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 4th-order Gauss-Legendre method.
"""
function GaussLegendre4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1/2-√3/6   1/4    1/4-√3/6;
        1/2+√3/6 1/4+√3/6   1/4   ;
           4       1/2      1/2   ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

@doc (@doc GaussLegendre4) function GL4(args...; kwargs...)
    return GaussLegendre4(args...; kwargs...)
end

"""
    GaussLegendre6(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver
    GL6(args...; kwargs...) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 6th-order Gauss–Legendre method.
"""
function GaussLegendre6(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1/2-√15/10     5/36    2/9-√15/15 5/36-√15/30;
           1/2     5/36+√15/24    2/9     5/36-√15/24;
        1/2+√15/10 5/36+√15/30 2/9+√15/15     5/36   ;
            6          5/18       4/9         5/18   ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

@doc (@doc GaussLegendre6) function GL6(args...; kwargs...)
    return GaussLegendre6(args...; kwargs...)
end

"""
    LobattoIIIA4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 4th-order Lobatto IIIA method.
"""
function LobattoIIIA4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
         0   0    0    0  ;
        1/2 5/24 1/3 -1/24;
         1  1/6  2/3  1/6 ;
         4  1/6  2/3  1/6 ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    LobattoIIIB2(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 2nd-order Lobatto IIIB method.
"""
function LobattoIIIB2(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1/2 1/2  0 ;
        1/2 1/2  0 ;
         2  1/2 1/2;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    LobattoIIIB4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 4th-order Lobatto IIIB method.
"""
function LobattoIIIB4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
         0  1/6 -1/6  0 ;
        1/2 1/6  1/3  0 ;
         1  1/6  5/6  0 ;
         4  1/6  2/3 1/6;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    LobattoIIIC2(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 2nd-order Lobatto IIIC method.
"""
function LobattoIIIC2(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        0  1/2 -1/2;
        1  1/2  1/2;
        2  1/2  1/2;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    LobattoIIIC4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 4th-order Lobatto IIIC method.
"""
function LobattoIIIC4(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
         0   1/6 -1/3   1/6 ;
        1/2  1/6  5/12 -1/12;
         1   1/6  2/3   1/6 ;
         4   1/6  2/3   1/6 ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    RadauIA3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 3rd-order Radau IA method.
"""
function RadauIA3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
         0  1/4 -1/4 ;
        2/3 1/4  5/12;
         3  1/4  3/4 ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    RadauIA5(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 5th-order Radau IA method.
"""
function RadauIA5(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
            0     1/9   -1/18-√6/18     -1/18+√6/18  ;
        3/5-√6/10 1/9  11/45+7*√6/360 11/45-43*√6/360;
        3/5+√6/10 1/9 11/45+43*√6/360  11/45-7*√6/360;
            5     1/9    4/9+√6/36       4/9-√6/36   ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    RadauIIA3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 3rd-order Radau IIA method.
"""
function RadauIIA3(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        1/3  5/12 -1/12;
         1   3/4   1/4 ;
         3   3/4   1/4 ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end

"""
    RadauIIA5(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10) :: ImplicitRungeKuttaSolver

returns an [`ImplicitRungeKuttaSolver`](@ref) for the 5th-order Radau IIA method.
"""
function RadauIIA5(; h::Real=0.0, ϵ::Real=1e-3, K::Integer=10)
    h_T = typeof(h)
    tableau = ButcherTableau(h_T[
        2/5-√6/10   11/45-7*√6/360   37/225-169*√6/1800 -2/225+√6/75;
        2/5+√6/10 37/225+169*√6/1800   11/45+7*√6/360   -2/225-√6/75;
           1           4/9-√6/36          4/9+√6/36          1/9    ;
           5           4/9-√6/36          4/9+√6/36          1/9    ;
    ])
    newton = NewtonParameters(ϵ=ϵ, K=K)
    return IRK(tableau, h, newton)
end