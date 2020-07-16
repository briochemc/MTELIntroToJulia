# <img width=40% src="https://raw.githubusercontent.com/JuliaLang/julia-logo-graphics/master/images/julia-logo-color.svg">
# 
# # An introduction to Julia for MTEL
# 
# <img width=40% bg=white src="http://www.mtel.rocks/uploads/1/1/1/0/111085621/mtel-logo_orig.png" style="background-color:gray;padding:5px;">

# ## Installation
# 
# Go to [julialang.org](https://julialang.org/), click download, click on your OS (64-bit), and then install it.

# ## Learning Julia
# 
# A Ton of resources online now (videos, notebooks, blogs, streams, presentations, talks, books, and so on), most of them listed on [Julia's website](https://julialang.org/learning/).
# 
# - [Slack](https://slackinvite.julialang.org/) (click on the link to request an invitation) with a #helpdesk channel
#     
#     <img width=60% src="https://user-images.githubusercontent.com/4486578/87495234-341d0d00-c694-11ea-8a48-72cba8a8aa19.png">
#     
# - [Discourse](https://discourse.julialang.org/) forum
# 
# - [Stackoverflow](https://stackoverflow.com/questions/tagged/julia) questions & answers
# 
# - and documentation (for [Julia](https://docs.julialang.org/en/v1/) but also for almost all packages)
# 
# I also recommend the [**MATLAB–Python–Julia cheatsheet**](https://cheatsheets.quantecon.org/) for those familiar with one of these languages.

# ## Using Julia
# 
# You will probably use Julia interactively. There are many ways to do that:
# - at the REPL (Read Eval Print Loop)
# - in integrated development interfaces (IDE) (e.g, using [Visual Studio code](https://code.visualstudio.com/), [Atom with Juno](https://junolab.org/), etc.)
# - using notebooks: [Jupyter](https://jupyter.org/) and [Pluto.jl](https://github.com/fonsp/Pluto.jl)
# 
# 
# 
# You can also execute code in a non-interactive way (e.g., for long runs or in scripts that run on a cluster). Run scripts via
# 
# ```bash
# julia my_awesome_script.jl
# ```

# ## The REPL
# 
# The Read Eval Print Loop
# 
# - `;` to go to shell mode
# - `]` to go to Pkg mode
# - `?` to go to help mode
# - `delete` to go out of special mode back to normal REPL
# - Ctrl-C stops current run
# - Ctrl-L clears the screen (like shell's `clear`)
# - Exit REPL with `exit()`
# 
# [Here](https://gist.github.com/briochemc/44f1778d0d4e7ad2c3257157638cbb2c) are some animated gifs of tips and tricks I made for the REPL.

# ## Unicode support

# Type `\pi` and then `TAB` will turn `pi` into `π`.

π ## (`pi` has a default value in Julia)
#----------------------------------------------------------------------------

# `\epsilon` + `TAB` will give `ϵ`, `\delta` + `TAB` will give `δ`, and so on.

ϵ = 1e-7
#----------------------------------------------------------------------------

ω = 2e-6
#----------------------------------------------------------------------------

# You can do more complicated things, like

🐶 = 9 ; 🐱 = 6 ; 😪 = 0
🐶 > 🐱 > 😪
δ¹⁴C = "delta14C"
#----------------------------------------------------------------------------

# A lot of symbols are available, making the code more readbale. 
# 
# - greeks: α, β, γ, δ, ϵ, ε, ϕ, φ, Ω, ω, Γ, λ, Λ, Φ, and so on
# 
# - math symbols: ∫, ∑, ∮, ⊕, ∪, ∩, ∈, ∀, etc.
# 
# - some sub/super scripts: ⁻¹²³⁴⁵₆₇₈₉ 

 
#----------------------------------------------------------------------------

# ## Assignment and basic types

x = 1
#----------------------------------------------------------------------------

# mutiple assignment (only the last line is shown in output)

x = 1
y = 2
#----------------------------------------------------------------------------

# or in single lines

# x = 1; y = 2

# or better yet,

x, y = 1, 2
#----------------------------------------------------------------------------

# (Note `;` suppresses output)

x = 1 ;
#----------------------------------------------------------------------------

# ## Operations

# `+`, `-`, `*`, `/`

x = 2 * 1.3 + 0.455 / 5 - 3.0
#----------------------------------------------------------------------------

# exponentiation

x = 2 ^ 10 + sin(2π/3)
#----------------------------------------------------------------------------

# Equality

1 == 0.5
#----------------------------------------------------------------------------

# Almost equal

1.00000001 ≈ 1 ## type `\approx` and TAB for ≈
#----------------------------------------------------------------------------

# Comparisons

x, y = 5, 6
x <= 6
#----------------------------------------------------------------------------

# Element-wise operations using `.` (broadcast)

x = [1, 2, 3]
x .* x
#----------------------------------------------------------------------------

sin.(x)
#----------------------------------------------------------------------------

x .< 2
#----------------------------------------------------------------------------

# ## Logic

1 ≤ 2
#----------------------------------------------------------------------------

# You can do `A ? B : C` (short syntax for `if A then B else C`):

a, b = 3, 2
x = a < b ? "b wins!" : "a wins!"
x^2
#----------------------------------------------------------------------------

x, y = true, false
x & y ## x AND y
#----------------------------------------------------------------------------

x | y ## x OR y
#----------------------------------------------------------------------------

!x ## NOT x
#----------------------------------------------------------------------------

# Short-circuit with `&&` and `||`

true && println("A")
true || println("B")
false && println("C")
false || println("D")

1 < 2 && println("1<2!")
#----------------------------------------------------------------------------

# ## Functions

# For complicated functions, you can write them as

function fib(x)
    if x ≤ 1
        y = 1
    else
        y = fib(x - 1) + fib(x - 2)
    end
    return y
end
## fib2(x) = x ≤ 1 ? 1 : fib2(x-1) + fib2(x-2)
function g(x)
    return 2 * x - 1
end
#----------------------------------------------------------------------------

[println("fib($i) = $(fib(i))") for i in 0:10] ;
g(3)
#----------------------------------------------------------------------------

# - single-line functions

f(x) = 2 * cos(x) + 1
#----------------------------------------------------------------------------

f(2.5) 
#----------------------------------------------------------------------------

# ## Base types

# Integers

x = 1
x, typeof(x)
#----------------------------------------------------------------------------

# Real numbers (default `Float64` AKA double precision)

x = 1.0
x, typeof(x)
#----------------------------------------------------------------------------

# Fractions

x = 1 // 2
x, typeof(x)
#----------------------------------------------------------------------------

# (not the same as `1/2`)

x = 1 / 2 
typeof(x)
#----------------------------------------------------------------------------

# ### Some other "standard" types

x = "A string"
x, typeof(x)
#----------------------------------------------------------------------------

x = 'c'
x, typeof(x)
#----------------------------------------------------------------------------

x = :a
x, typeof(x)
#----------------------------------------------------------------------------

x = true ## or false
x, typeof(x)
#----------------------------------------------------------------------------

# Vectors and arrays of different types

x = [1, "two", :three]
#----------------------------------------------------------------------------

# Tuples (immutable)

x = (1, "two", :three) 
#----------------------------------------------------------------------------

# Named tuples

x = (a = 1, b = "two", c = :three)
#----------------------------------------------------------------------------

x.a, x.c
#----------------------------------------------------------------------------

# Dictionaries

x = Dict(:a => 1, :b => "two", :c => :three)
#----------------------------------------------------------------------------

# ## Packages
# 
# The list is *very* long, so here is a quick curated list of things that come to mind
# 
# - [OhMyREPL](https://github.com/KristofferC/OhMyREPL.jl), [Revise](https://github.com/timholy/Revise.jl)
# - notebooks: [IJulia](https://github.com/JuliaLang/IJulia.jl) and [Pluto](https://github.com/fonsp/Pluto.jl)
# - [Plots](https://github.com/JuliaPlots/Plots.jl) + backends, [Makie](https://github.com/JuliaPlots/Makie.jl), [UnicodePlots](https://github.com/Evizero/UnicodePlots.jl), [PyPlot](https://github.com/JuliaPy/PyPlot.jl) 
# - [Unitful](https://github.com/PainterQubits/Unitful.jl) for units ([UnitfulRecipes](https://github.com/jw3126/UnitfulRecipes.jl))
# - [Measurements](https://github.com/JuliaPhysics/Measurements.jl) and [MonteCarloMeasurements](https://github.com/baggepinnen/MonteCarloMeasurements.jl) for errorbars
# - [DataFrames](https://github.com/JuliaData/DataFrames.jl), [CSV](https://juliadata.github.io/CSV.jl/stable/), [NCDataSets](https://github.com/Alexander-Barth/NCDatasets.jl), [PrettyTables](https://github.com/ronisbr/PrettyTables.jl), [MAT](https://github.com/JuliaIO/MAT.jl), etc., for reading/writing tabular data
# - Ocean stuff: [JuliaOcean](https://github.com/JuliaOcean), [PlanktonIndividuals](https://github.com/JuliaOcean/PlanktonIndividuals.jl), [AIBECS](https://github.com/JuliaOcean/AIBECS.jl), [CliMA](https://github.com/CliMA/ClimateMachine.jl), [ArgoData](https://github.com/JuliaOcean/ArgoData.jl), [AirSeaFluxes](https://github.com/JuliaOcean/AirSeaFluxes.jl), [Oceananigans.jl](https://github.com/CliMA/Oceananigans.jl), [GeophysicalFlows](https://github.com/FourierFlows/GeophysicalFlows.jl), [IndividualDisplacements](https://github.com/JuliaClimate/IndividualDisplacements.jl), [Simons CMAP](https://github.com/simonscmap/CMAP.jl), [WorldOceanAtlasTools](https://github.com/briochemc/WorldOceanAtlasTools.jl), [GEOTRACES](https://github.com/briochemc/GEOTRACES.jl), [ClimateERA](https://github.com/natgeo-wong/ClimateERA.jl), [DIVAnd](https://github.com/gher-ulg/DIVAnd.jl) (interpolation for ODV), and so on
# - [SciML](https://github.com/SciML) (Differential equations + ML), [Biojulia](https://biojulia.net/), [GeoStats](https://github.com/JuliaEarth/GeoStats.jl)
# - [Latexify](https://github.com/korsbo/Latexify.jl) for LaTeX

# ---
# 
# *This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
