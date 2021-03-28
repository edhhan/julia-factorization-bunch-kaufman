using LinearAlgebra
using Test


include("pivot_strategies/bparlett.jl")
include("pivot_strategies/bkaufmann.jl")
include("pivot_strategies/rook.jl")
include("lbl.jl")


@testset begin

    for _ = 1:10
    
        for n = 4:4
            A = Hermitian(rand(n,n).*100)
            F = lbl(A, strategy="bparlett")
            PAPT = permute_matrix_lbl(A, F.pivot_array)
            @test norm(PAPT - F.L*F.B*F.L') ≤ sqrt(eps()) * norm(PAPT)
        end
    
    end
end


# Bunch-parlet by hand 
# Itération 1 
#P1 = [0 0 0 1 ; 0 1 0 0 ; 0 0 1 0 ; 1 0 0 0] #pivot 1 et 4
#=
P1 = Matrix(1.0*I,4,4)

hat_A1 = P1*A_assignement*P1
p1_size = 1
pivot_size = p1_size

E1 = hat_A1[1:pivot_size, 1:pivot_size]
C1 = hat_A1[(pivot_size+1):end, 1:pivot_size]
B1 = hat_A1[(pivot_size+1):end, (pivot_size+1):end]

L1= [1;  C1 * 1/E1]
#L1_P = P1'*L1     #P1 : 4x4, L1 : 4x1
Schur1 = (B1 - C1*1/E1*C1')


# Itération 2
hat_A2 = Schur1 #pivot in 2
#P2 = [0 1 0; 1 0 0; 0 0 1] #pivot 1 et 2
P2 = [0 0 1; 0 1 0; 1 0 0]
p2_size = 1
pivot_size = p2_size
hat_A2 = P2*hat_A2*P2

E2 = hat_A2[1:pivot_size, 1:pivot_size]
C2 = hat_A2[(pivot_size+1):end, 1:pivot_size]
B2 = hat_A2[(pivot_size+1):end, (pivot_size+1):end]

Schur2 = (B2 - C2*1/E2*C2')


# iteration
hat_A3 = Schur2
p3_size = 1
pivot_size = p2_size

E3 = hat_A3[1:pivot_size, 1:pivot_size]
C3 = hat_A3[(pivot_size+1):end, 1:pivot_size]
B3 = hat_A3[(pivot_size+1):end, (pivot_size+1):end]

Schur3 = (B3 - C3*1/E3*C3')
=#
