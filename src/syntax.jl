
# # Julia Introduction

#
# ## The REPL


# `;` to go to shell mode
# `]` to go to Pkg mode
# `?` to go to help mode
#
# `delete` to go out of special mode back to normal REPL
#
# Or help with `apropos` (`methods`, `@which`, and so on)
#
# `include("script.jl")` to run script
#
# `ans` for last answer
#
# Ctrl-C stops current run
#
# Ctrl-L clears the screen (like shell's `clear`)
#
# Exit REPL with `exit()`

# ## Standard libraries

# Packages that are installed by default (but you must type `using XXX` to use them).

# - LinearAlgebra

using LinearAlgebra

M = [1 2; 3 4]

x = rand(2)
M * x

M \ x

I

M + I

Mf = factorize(M)

Mf \ x # much faster than `M \ x`!

Diagonal

# - Random

using Random

rand()

randn()

rand(10)

rand(3,3)

# - Statistics

using Statistics

x = exp.(randn(10000))
mean(x)

std(x)

median(x)

# - SparseArrays

using SparseArrays

M = sprand(5, 5, 0.5)

Matrix(M)

i, j, v = findnz(M)

sparse(i, j, 2v, 5, 5)

sparse(Diagonal([1, 2, 3]))

# - Dates

using Dates

d = Date(2018, 1, 1)

t = Time(8, 15, 42)

DateTime(d, t)

# ## Packages



# ## Assignment and basic types

x = 1

# mutiple assignment (only the last line is shown in output)

x = 1
y = 2

# or in single lines

x = 1; y = 2

# or better yet,

x, y = 1, 2

# (Note `;` suppresses output)

x = 1 ;




# ## Base types

# Integers

1

# Real numbers (default `Float64` AKA double precision)

2.0

# Fractions

3 // 4

# (not the same as `3/4`)

3 / 4

# Strings

"A string"

# Characters

'a'

# Symbols

:aSymbol

# Booleans

true, false

# Vectors

[1, "2", :3]

# Arrays

[1 "2"; :3 4.0]

#

[ 1 "2"
 :3 4.0]

# Tuples

(1, "2", :3)

# Named tuples

(a = 1, b = "2", c = :3)



# ## Operations

# `+`, `-`, `*`, `/`

2 * 1.3 + 0.455 / 5 - 3.0

# exponentiation

2 ^ 10

# Equality

5.55 == 5.55, 1 == 2

# Almost equal

1.00000001 ≈ 1.0

# Order

1 ≤ 2 < 3 <= 4

# Element-wise operations using `.` (broadcast)

2 .* [1, 2, 3]

# `NaN`s, `missing`, and `nothing`

[1.0, NaN, missing, nothing]

# ternary operator (short syntax if-then-else)

a, b = 1, 2
a < b ? "b wins!" : "a wins!"

# Short-circuit

a, b = true, false
a && println("A")
a || println("B")
b && println("C")
b || println("B")

# functions

f(x) = 2x


# Unicode / LaTeX

# Type `\pi` and then `TAB` will turn `pi` into `π`.

π # (`pi` has a default value in Julia)

# `\epsilon` + `TAB` will give `ϵ`, `\delta` + `TAB` will give `δ`, and so on.

ϵ = 1e-7

δ = 2e-6

# You can do more complicated things, like

∑i⁻² = sum(i^-2 for i in 1:100)



# udating value

x

x += 1

x -= 2

x *= 3

x /= 4

