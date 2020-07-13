### A Pluto.jl notebook ###
# v0.10.5

using Markdown
using InteractiveUtils

# ╔═╡ 2ec6aa1c-bf3e-11ea-3405-bfad44ce8a1c
using Measurements

# ╔═╡ e6044c0e-c121-11ea-09e7-83fe06b2b0fe
using Unitful

# ╔═╡ 5568d6ae-c0f9-11ea-26f1-5b93f8746b3e
using Unitful: ac, ha, g, kg, Mg, m, s

# ╔═╡ b011e41a-c123-11ea-2cb2-c50d24efcfad
using Plots, UnitfulRecipes

# ╔═╡ d5c47124-bf3d-11ea-3a7f-5de680c0ccb7
md"""
# Introducing Julia with an example

Let's redo Rachel's estimates of trace metals released during the Thomas fire. 
"""

# ╔═╡ ece6186a-c122-11ea-3c63-c189705eef4b
md"## Uncertainties with [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl)"

# ╔═╡ f4c371a8-c4ac-11ea-0ff8-d98137189222
a = 150.0 ± 10.0

# ╔═╡ e05472ec-c4ad-11ea-0427-150f712b5d5a
b = 10 ± 5

# ╔═╡ 38a6cabc-c4ac-11ea-2505-af427c8e5e8e
md"""
With Measurements.jl, you can essentially work with `±` in all your variables. And uncertainties are propagated correctly. For example, if you define 

`a` = $a

`b` = $b

And you wanted to compute 2a+b or a/5b, you could study the [uncertainty-propagation formulae](https://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulae)... Or use Measurements.jl to do it for you!

`2a+b` = $(2a + b)

`a/5b` = $(a / 5b)
"""

# ╔═╡ c90f87ba-c4ac-11ea-1b58-a7a350c5d258
md"""
> Note that Measurements.jl is good for linear propagation. For nonlinear propagation (e.g., `log` or `exp`), you should use [MonteCarloMeasurements](https://github.com/baggepinnen/MonteCarloMeasurements.jl) which propagates uncertainties with Monte-Carlo simulations.
"""

# ╔═╡ 6aec1ad8-c0f9-11ea-1d4a-0b1c2f3bbdf7
md"## Units with Unitful.jl"

# ╔═╡ 24b2c264-c122-11ea-291c-2d3c129113a9
md"With Unitful.jl, you can simply express values with units, by prefixing a `u` to a string that spells the unit. 

An example is probably the easiest to showcase this. So, to for m s⁻¹, you can write"

# ╔═╡ 24a160b2-c122-11ea-0f5a-ab0261434f0a
15u"m/s"

# ╔═╡ e5f36dc6-c121-11ea-2eaa-d3b5dc827d1b
md"""
---

##### Extras (for things to look pretty)

###### We can import symbols
"""

# ╔═╡ a594242e-c122-11ea-37b5-4bb8c868c124
md"Importing `m` (a variable for meters) and `s` (for seconds) from Unitful, I can now simply write"

# ╔═╡ bf764442-c122-11ea-16c7-6b13e38340be
15m/s

# ╔═╡ c44f50ee-c122-11ea-091d-bd1d5ed0deb4
md"which is a bit nicer and shorter, making it easier to read.

###### We can define units

Let us create an alias for tons, so that we can us `t` instead of `Mg`, with"

# ╔═╡ cf6c1f2e-c0f9-11ea-2dca-cf6b6f09f8bc
Unitful.register(@__MODULE__); @unit t "t" Ton 1Mg true; nothing

# ╔═╡ 6c29f7bc-c1a3-11ea-2fba-cdd7a06e97ea
md"And a unit for parts per million (instead of using, e.g., `g/t`), with"

# ╔═╡ 7ec2397c-c1a3-11ea-14ed-f1c11622a3ad
Unitful.register(@__MODULE__); @unit ppm "ppm" PartsPerMillion 1g/t false; nothing

# ╔═╡ d8dd06b2-c4bc-11ea-0b3b-6b0d3e39958c
md"""## The Thomas Fire variables

Here's how to compute the release value in tons of iron. We define 4 variables (with uncertainty and units!). The values are taken either from the literature of from Rachel's observations:
"""

# ╔═╡ c79a8d28-c0f9-11ea-17ba-71521c81a5db
surface_burnt = (281893 ± 1000)ac

# ╔═╡ 21afb2c8-c121-11ea-3312-ffe7712013e9
fuel_density = (27 ± 5)t/ha

# ╔═╡ 2765d092-c121-11ea-37e0-c33057cc27b0
PM25_concentration = (6.7 ± 2)g/kg

# ╔═╡ 27fe7a90-c121-11ea-3780-1599ac8dce0b
Fe_content = (4000 ± 1000)ppm

# ╔═╡ 9fbd5b3c-c17b-11ea-23c8-273e8621e916
md"## Computing the trace-element release"

# ╔═╡ 445b670c-c121-11ea-38fd-e15f9a6de0fa
md"Now let's compute the burnt biomass released"

# ╔═╡ 4b796bd8-c121-11ea-33b1-cf75fd8ca91f
biomass_release = surface_burnt * fuel_density

# ╔═╡ 57af0fac-c121-11ea-3061-1b4849b505d2
md"Great! See how the units are carried over? However, this looks like we could simplify the units a bit (the `ac * ha⁻¹` part in particular). We could do this unit conversion by hand, but we can also do it automatically in Julia! We could use Unitful's `uconvert` function or the pipe symbol, `|>`"

# ╔═╡ 4ea07cfc-c121-11ea-22d1-5da737414604
biomass_release |> Mt

# ╔═╡ fe15290a-c124-11ea-23da-37a9f5b8c015
md"The amount of aerosols released depends on the concentration of PM25 particles"

# ╔═╡ 28c406d2-bf3e-11ea-1588-85dcbb06da28
PM25_release = PM25_concentration * biomass_release |> kt

# ╔═╡ 609d994e-c17b-11ea-3491-290c7401e4cf
md"Finally to estimate the iron release, we can use the iron content"

# ╔═╡ 87041770-c17b-11ea-1d6c-f3f33c6161a8
Fe_release = Fe_content * PM25_release |> t

# ╔═╡ d2273856-c0f9-11ea-1790-631713619b05
md"""## The Thomas Fire

About $(surface_burnt) of land burned during the Thomas fire.
The average biomass fuel over the burnt area was estimated at $fuel_density.
With about $(PM25_concentration * 1kg) of PM25 particles per $kg of fuel and an approximate PM25 Fe content of $Fe_content, **the Thomas fire released $Fe_release of iron in less than a month**.
"""

# ╔═╡ 982cf198-c17b-11ea-2d4b-2156579bb13d
md"## Now let's visualize this all"

# ╔═╡ a254156e-c123-11ea-098a-cfca38b0054f
md"Finally, we will make some plots, so let's load [Plots.jl](https://github.com/JuliaPlots/Plots.jl) and [UnitfulRecipes.jl](https://github.com/jw3126/UnitfulRecipes.jl). We load UnitfulRecipes.jl because it contains plotting recipes for units. (Recipes for uncertainties are already in Measurements.jl.)"

# ╔═╡ d09f6c50-c4b3-11ea-1568-1de9fc982a1c
md"We define the ppm content of the trace elements using Rachel's work"

# ╔═╡ 32133e3e-c19f-11ea-2ce4-5727bc4bc0c9
TE_contents = (Fe = (3852 ±  500)ppm,
			   Zn = (2062 ±  300)ppm,
               Cu = ( 292 ±   50)ppm,
               Ni = ( 121 ±   60)ppm,
               Mn = (  69 ±   31)ppm,
               Pb = (  36 ±   16)ppm,
               Cd = (  12 ±    5)ppm,
               Co = (   3 ±    2)ppm)

# ╔═╡ 49c1aa26-c4b4-11ea-20d9-9d2795891a5e
md"I can then simply plot the trace-element release as bars with Plots:"

# ╔═╡ 4f7be70a-c19f-11ea-3ea0-27bb9c774415
bar([v * PM25_release |> t for v in TE_contents], 
	label="", # this prevents a legend from appearing
	ylabel="Trace element release",
	xticks=(1:8, keys(TE_contents)))

# ╔═╡ 55e89f2c-c4c0-11ea-04ee-bd13048f4fa3
begin
	x = rand(10) .± 0.1rand(10)
	y = rand(10) .± 0.2rand(10)
	plot(x, y, l=false, m=:o)
end

# ╔═╡ ae478a32-c1a4-11ea-2811-897674e59cc7
scatter([v * PM25_release |> t for v in TE_contents], 
	label="", # this prevents a legend from appearing
	yscale=:log10,
	ylabel="Trace element concentration",
	xticks=(1:8, keys(TE_contents)), xlims=(0,9))

# ╔═╡ Cell order:
# ╟─d5c47124-bf3d-11ea-3a7f-5de680c0ccb7
# ╟─ece6186a-c122-11ea-3c63-c189705eef4b
# ╠═2ec6aa1c-bf3e-11ea-3405-bfad44ce8a1c
# ╟─38a6cabc-c4ac-11ea-2505-af427c8e5e8e
# ╟─f4c371a8-c4ac-11ea-0ff8-d98137189222
# ╟─e05472ec-c4ad-11ea-0427-150f712b5d5a
# ╟─c90f87ba-c4ac-11ea-1b58-a7a350c5d258
# ╟─6aec1ad8-c0f9-11ea-1d4a-0b1c2f3bbdf7
# ╠═e6044c0e-c121-11ea-09e7-83fe06b2b0fe
# ╟─24b2c264-c122-11ea-291c-2d3c129113a9
# ╠═24a160b2-c122-11ea-0f5a-ab0261434f0a
# ╟─e5f36dc6-c121-11ea-2eaa-d3b5dc827d1b
# ╠═5568d6ae-c0f9-11ea-26f1-5b93f8746b3e
# ╟─a594242e-c122-11ea-37b5-4bb8c868c124
# ╠═bf764442-c122-11ea-16c7-6b13e38340be
# ╟─c44f50ee-c122-11ea-091d-bd1d5ed0deb4
# ╠═cf6c1f2e-c0f9-11ea-2dca-cf6b6f09f8bc
# ╟─6c29f7bc-c1a3-11ea-2fba-cdd7a06e97ea
# ╠═7ec2397c-c1a3-11ea-14ed-f1c11622a3ad
# ╟─d2273856-c0f9-11ea-1790-631713619b05
# ╟─d8dd06b2-c4bc-11ea-0b3b-6b0d3e39958c
# ╟─c79a8d28-c0f9-11ea-17ba-71521c81a5db
# ╟─21afb2c8-c121-11ea-3312-ffe7712013e9
# ╟─2765d092-c121-11ea-37e0-c33057cc27b0
# ╠═27fe7a90-c121-11ea-3780-1599ac8dce0b
# ╟─9fbd5b3c-c17b-11ea-23c8-273e8621e916
# ╟─445b670c-c121-11ea-38fd-e15f9a6de0fa
# ╠═4b796bd8-c121-11ea-33b1-cf75fd8ca91f
# ╟─57af0fac-c121-11ea-3061-1b4849b505d2
# ╠═4ea07cfc-c121-11ea-22d1-5da737414604
# ╟─fe15290a-c124-11ea-23da-37a9f5b8c015
# ╠═28c406d2-bf3e-11ea-1588-85dcbb06da28
# ╟─609d994e-c17b-11ea-3491-290c7401e4cf
# ╠═87041770-c17b-11ea-1d6c-f3f33c6161a8
# ╟─982cf198-c17b-11ea-2d4b-2156579bb13d
# ╟─a254156e-c123-11ea-098a-cfca38b0054f
# ╠═b011e41a-c123-11ea-2cb2-c50d24efcfad
# ╟─d09f6c50-c4b3-11ea-1568-1de9fc982a1c
# ╠═32133e3e-c19f-11ea-2ce4-5727bc4bc0c9
# ╟─49c1aa26-c4b4-11ea-20d9-9d2795891a5e
# ╠═4f7be70a-c19f-11ea-3ea0-27bb9c774415
# ╠═55e89f2c-c4c0-11ea-04ee-bd13048f4fa3
# ╠═ae478a32-c1a4-11ea-2811-897674e59cc7
