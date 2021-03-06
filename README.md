# LBLFactorizations.jl

# LBL: Bloc Diagonal Factorization for Hermitian Matrices

IMPORTANT: This package isn't efficient compared to bunchkaufman() and was done for academic purpose only. Use bunchkaufman() from LinearAlgebra for optimal results.
IMPORTANT: This package is compatible with Julia v1.5.2 and higher

An implementation of Bloc diagonal factorization

Please cite this repository if you use LBLFactorizations.jl in your work

This package is appropriate for indefinite hermitian matrix A where we want a factorization of the form PAP*=LBL*.

LBLFactorizations.jl should not be expected to be as fast as bunchkaufman.jl which uses LAPACK.

The main advantages of LBLFactorizations.jl are that it is implemented in Julia so it does not require external compiled dependencies and it can work with all the julia data types.

# Installing

```julia
julia> ]
pkg> add https://github.com/edhhan/LBLFactorizations.jl
```

# Usage

The exported functions are `lbl`, `lbl_solve`, `bkaufmann`,`bparlett`,`rook`,`build_matrix` and `permutation_matrix`.


`lbl` returns a factorization in the form of a LBL object.
The `lbl_solve` method is implemented for objects of type `LBL` so that
solving a linear system can be done as follow:

```julia
using LinearAlgebra, LBLFactorizations
A=Hermitian(rand(Float64, n,n))
LBLT = lbl(A,strategy)  # LBLᵀ factorization of A with pivoting strategy strategy: "rook", "bkaufmann" or "bparlett"

x = lbl_solve(LBLT, b) # solves Ax = b
```

Factors can be accessed as `LBLT.L`, `LBLT.B`, and the permutation vector as `LBLT.permutation`.
L factor is unit lower triangular and the block diagonal matrix B is tridiagonal and contains independant submatrices 2x2 and 1x1.

Examples, benchmark and tests can be found in tests examples:

1. test_profile can be used to produce flamegraph of the solver and the factorization
2. test_solver provides a benchmark to produce graphs and data concerning the performance in time of lbl(), lbl_solve() vs bunchkaufman().
3. test_random applies lbl() on hermitian matrix A and compare the reconstruction of LBL with PAP'.
4. tests_pivots does unitary tests on matrices to be sure that the strategies bkaufmann(), bparlett() and rook() give the right pivots.
5. analyse.py is a python scripts that analyze the CSV returned by test_solver in order to get the complexity of the factorizations.

# References

The strategies and the factorization were based on:

N. J. Higham,Accuracy and stability of numerical algorithms.  SIAM, 2002
