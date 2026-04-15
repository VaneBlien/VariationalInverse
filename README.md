
# VariationalInverse.jl

`VariationalInverse.jl` is a lightweight Julia package designed to solve **inverse mapping problems** using variational optimization. It transforms the task of finding an inverse function into an unconstrained optimization problem, powered by the robust solvers in `Optim.jl`.

## 💡 Core Principle

For a given mapping $\Psi$, the inverse $x = \Psi^{-1}(y)$ is found by minimizing the following objective function:
$$f(x) = \Psi(x) - \langle x, y \rangle$$

By default, the package uses the **L-BFGS** algorithm, which is highly efficient for high-dimensional problems.

## ✨ Features

- **Multi-Dimensional Support**: Works seamlessly with scalars, vectors, and matrices (processed column-wise).
- **Customizable Optimizers**: Full compatibility with `Optim.jl` solvers (e.g., `LBFGS`, `GradientDescent`, `Newton`).
- **Solver Interface**: Use the `InverseSolver` struct to pre-configure optimization settings for repeated use.

## 📦 Installation

This package is currently in development. You can install it via the Julia REPL:

```julia
using Pkg
Pkg.add(url="[https://github.com/VaneBlien/VariationalInverse.jl](https://github.com/VaneBlien/VariationalInverse.jl)")
```

## 🚀 Quick Start

### 1. Basic Usage (Scalar)
Find the inverse of $f(x) = x^2$ at $y = 4.0$:

```julia
using VariationalInverse

Ψ(x) = x^2 
y = 4.0
x_inv = inverse(Ψ, y)
println("Result: ", x_inv) # Expected: ~2.0
```

### 2. Vector and Matrix Inputs
```julia
using LinearAlgebra

# Vector input
Ψ_vec(x) = 0.5 * dot(x, x)
y_vec = [1.0, 2.0, 3.0]
x_vec = inverse(Ψ_vec, y_vec)

# Matrix input (computes inverse for each column)
Y = [1.0 2.0; 3.0 4.0]
X = inverse(Ψ_vec, Y)
```

### 3. Using the Solver Pattern
For production workflows, pre-define your solver settings:

```julia
solver = InverseSolver(Ψ_vec, method=LBFGS(), iterations=1000)
result = solve(solver, y_vec)
```

## 🧪 Running Tests

To verify the installation, run the following command in the project root:

```bash
julia --project -e 'using Pkg; Pkg.test()'
```

## 🛠 Dependencies
- [Optim.jl](https://github.com/JuliaOpt/Optim.jl)
- [LinearAlgebra](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/)

## 📄 License
MIT License
```

---

### One-Click Deployment (Final Push)
Now that you have the English README and the test file I gave you earlier, run these in your VS Code terminal to finish the job:

```bash
# Save your work
git add .
git commit -m "docs: add English README and comprehensive tests"

# Push to GitHub
git push origin master
```
