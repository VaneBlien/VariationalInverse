module VariationalInverse

using Optim: optimize, minimizer, LBFGS
using LinearAlgebra: dot

export inverse, InverseSolver, solve

function inverse(Ψ, y::Number; method=LBFGS(), kwargs...)
    obj(x) = Ψ(x[1]) - x[1] * y
    x0 = [0.0]
    result = optimize(obj, x0, method; kwargs...)
        return minimizer(result)[1]
end

function inverse(Ψ, y::AbstractVector; method=LBFGS(), kwargs...)
    obj(x) = Ψ(x) - dot(x, y)
    x0 = zeros(eltype(y), length(y))
    result = optimize(obj, x0, method; kwargs...)
    return minimizer(result)
    end

function inverse(Ψ, Y::AbstractMatrix; method=LBFGS(), kwargs...)
    X = similar(Y)
    for (i, col) in enumerate(eachcol(Y))
        X[:, i] = inverse(Ψ, col; method=method, kwargs...)
    end
        return X
end

struct InverseSolver{F,M,K}
    Ψ::F
    method::M
    kwargs::K
end

function InverseSolver(Ψ; method=LBFGS(), kwargs...)
    return InverseSolver(Ψ, method, kwargs)
end

function solve(s::InverseSolver, y)
    return inverse(s.Ψ, y; method=s.method, s.kwargs...)
end

end
