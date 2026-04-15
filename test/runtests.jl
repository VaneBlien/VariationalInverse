using VariationalInverse
using Test

@testset "VariationalInverse.jl" begin
    @testset "Scalar functions" begin
        # Linear potential: Ψ(x) = x² + x => F(x) = 2x + 1 => F⁻¹(y) = (y-1)/2
        Ψ1(x) = x^2 + x
        @test inverse(Ψ1, 5.0) ≈ 2.0
        @test inverse(Ψ1, 1.0) ≈ 0.0
        @test inverse(Ψ1, -3.0) ≈ -2.0
        
        # Exponential potential: Ψ(x) = eˣ => F⁻¹(y) = log(y)
        Ψ2(x) = exp(x)
        @test inverse(Ψ2, 1.0) ≈ 0.0
        @test inverse(Ψ2, exp(1.0)) ≈ 1.0
        @test inverse(Ψ2, 10.0) ≈ log(10.0)
        
        # Quadratic potential: Ψ(x) = 0.5x² => F⁻¹(y) = y
        Ψ3(x) = 0.5 * x^2
        @test inverse(Ψ3, 3.0) ≈ 3.0
        @test inverse(Ψ3, -1.5) ≈ -1.5
    end
    
    @testset "Vector functions" begin
        # Identity map
        Ψ4(x) = 0.5 * sum(x.^2)
        y = [1.0, 2.0, 3.0]
        @test inverse(Ψ4, y) ≈ y
        
        # Separable exponential
        Ψ5(x) = sum(exp.(x))
        y = [0.5, 1.0, 2.0]
        x_expected = log.(y)
        @test inverse(Ψ5, y) ≈ x_expected atol=1e-6
    end
    
    @testset "Batch matrix" begin
        Ψ6(x) = 0.5 * sum(x.^2)
        Y = [1.0 2.0 3.0; 4.0 5.0 6.0]
        X = inverse(Ψ6, Y)
        @test X ≈ Y
    end
    
    @testset "InverseSolver" begin
        Ψ7(x) = x^2 + x
        solver = InverseSolver(Ψ7)
        @test solve(solver, 5.0) ≈ 2.0
        @test solve(solver, 1.0) ≈ 0.0
    end
end
