using LinearAlgebra
include("max_subdiagonal.jl")

"""
Complete pivoting strategy
"""
function bparlett(A::Hermitian{T}) where T

    α = (1+sqrt(17))/8
    n = size(A,1)

    pivot = []
    pivot_size = 0

    μ_0 = abs(A[1,1])
    q = 1
    p = 1

    μ_1 = μ_0
    r = 1

    # Find max element in sub-diagonal matrix and max diagonal element
    for j in 1:n
        for i in j:n

            # Max on the diagonal : μ_1 = max |a_ij|
            if (i == j)
                if(abs(A[i,j]) > μ_1)
                    μ_1 = abs(A[i,j])
                    r = i
                end
            end

            # Max between all elements
            if(abs(A[i,j]) > μ_0) 
                μ_0 = abs(A[i,j])
                p = i
                q = j
            end
        end
    end

    # Pivoting between 1 and r (line and column)
    if (μ_1 >= α*μ_0)
        pivot_size = 1
        push!(pivot, (1,r))

    # 1) Pivoting between 1 and p (line and column)
    # 2) Pivoting between 2 and q (line and column)
    else
        pivot_size = 2
        push!(pivot, (1,p))
        push!(pivot, (2,q))          
    end

    
    return pivot, pivot_size
end