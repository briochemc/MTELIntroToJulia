### A Pluto.jl notebook ###
# v0.10.1

using Markdown
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 2ec6aa1c-bf3e-11ea-3405-bfad44ce8a1c
using Measurements

# ╔═╡ e6044c0e-c121-11ea-09e7-83fe06b2b0fe
using Unitful

# ╔═╡ 5568d6ae-c0f9-11ea-26f1-5b93f8746b3e
using Unitful: ac, ha, g, kg, Mg, m, s

# ╔═╡ b011e41a-c123-11ea-2cb2-c50d24efcfad
using Plots

# ╔═╡ 6d647e6c-c19f-11ea-104c-6fb9455a399b
using UnitfulRecipes

# ╔═╡ 1cc808fc-c1c2-11ea-0a9d-6b9d73935d86
using Pkg; Pkg.add("PlutoUI")

# ╔═╡ 86ded2a8-c1c1-11ea-08e7-f9fa2961fd1d
begin
	using ColorSchemes, PlutoUI
	@bind k Select(string.(keys(colorschemes)))
end

# ╔═╡ d5c47124-bf3d-11ea-3a7f-5de680c0ccb7
md"""
# An example with Pluto

Let's redo Emily's estimate of trace metal input to the ocean during the Thomas fire. 
"""

# ╔═╡ ece6186a-c122-11ea-3c63-c189705eef4b
md"## Setting us up with some packages"

# ╔═╡ eb5b6d46-c0f8-11ea-19c6-c1fbb16a3af3
md"For uncertainties, we will use Measurements.jl"

# ╔═╡ 6aec1ad8-c0f9-11ea-1d4a-0b1c2f3bbdf7
md"For units, we will use Unitful.jl."

# ╔═╡ e5f36dc6-c121-11ea-2eaa-d3b5dc827d1b
md"""On top of this, we will import some symbols from Unitful than define units as variables:
- `ac` for acres
- `ha` for hectares
- `g` for grams
- `kg` for kilograms
- `Mg` for Megagrams (i.e., tons, and we will add a `t` alias for tons)
"""

# ╔═╡ 24b2c264-c122-11ea-291c-2d3c129113a9
md"Why export these symbols? Because the default way to use units with Unitful is to prefix a `u` to a string that spells the unit. For example, to get 9.81 m s⁻¹, you could write"

# ╔═╡ 24a160b2-c122-11ea-0f5a-ab0261434f0a
9.81u"m/s"

# ╔═╡ a594242e-c122-11ea-37b5-4bb8c868c124
md"But since I imported `m` (a variable for meters) and `s` (for seconds) from Unitful, I can simply write"

# ╔═╡ bf764442-c122-11ea-16c7-6b13e38340be
9.81m/s

# ╔═╡ c44f50ee-c122-11ea-091d-bd1d5ed0deb4
md"which is a bit nicer and shorter, making it easier to read. Let's quickly define an alias for tons so that we can us `t` instead of `Mg`, with"

# ╔═╡ 8ab93d92-c1a2-11ea-05bf-2b66301e2509
md"For Unitful to show tons as `t` instead of `Mg`, we must define a new unit `t`"

# ╔═╡ cf6c1f2e-c0f9-11ea-2dca-cf6b6f09f8bc
Unitful.register(@__MODULE__); @unit t "t" Ton 1Mg true; nothing

# ╔═╡ f1ad188e-c1a2-11ea-0102-6153b6ee6f1b
md"(This is just for things to look pretty.)"

# ╔═╡ 6c29f7bc-c1a3-11ea-2fba-cdd7a06e97ea
md"We can also define a unit for parts per million (instead of using, e.g., `g/t`), with"

# ╔═╡ 7ec2397c-c1a3-11ea-14ed-f1c11622a3ad
Unitful.register(@__MODULE__); @unit ppm "ppm" PartsPerMillion 1g/t false; nothing

# ╔═╡ a254156e-c123-11ea-098a-cfca38b0054f
md"Finally, we will make some plots, so let's load the Plots package."

# ╔═╡ 6cd13f62-c19f-11ea-19d6-2f4e46a990f8
md"And since we want the plots to work with units, we also load UnitfulRecipes"

# ╔═╡ d2273856-c0f9-11ea-1790-631713619b05
md"""## Defining variables of what we know

Now let's write the things know (with uncertainty and units). The surface burnt is"""

# ╔═╡ c79a8d28-c0f9-11ea-17ba-71521c81a5db
surface_burnt = (281893 ± 0)ac

# ╔═╡ 7afa2b5a-c120-11ea-3702-7f1a103709d1
md"Similarly, we define variables for everything we estimate (from the litterature or from the Thomas Fire study):"

# ╔═╡ 21afb2c8-c121-11ea-3312-ffe7712013e9
fuel_density = (27 ± 10)t/ha

# ╔═╡ 2765d092-c121-11ea-37e0-c33057cc27b0
PM25_concentration = (6.7 ± 1)g/kg

# ╔═╡ 27fe7a90-c121-11ea-3780-1599ac8dce0b
TE_ppm = (3852 ± 1000)ppm

# ╔═╡ 9fbd5b3c-c17b-11ea-23c8-273e8621e916
md"## Computing the trace-element release"

# ╔═╡ 445b670c-c121-11ea-38fd-e15f9a6de0fa
md"Now let's compute the burnt biomass released"

# ╔═╡ 4b796bd8-c121-11ea-33b1-cf75fd8ca91f
biomass_release = surface_burnt * fuel_density

# ╔═╡ 57af0fac-c121-11ea-3061-1b4849b505d2
md"Great! See how the units are carried over? However, this looks like we could simplify the units a bit (the `ac * ha⁻¹` part in particular). We could do this unit conversion by hand, but we can also do it automatically in Julia! We could use Unitful's `uconvert` function"

# ╔═╡ b68eebd2-c121-11ea-1182-85627e982ded
uconvert(t, biomass_release)

# ╔═╡ bb754e84-c121-11ea-0cf3-b71b04581505
md"or the pipe symbol `|>`"

# ╔═╡ 4ea07cfc-c121-11ea-22d1-5da737414604
biomass_release |> t

# ╔═╡ fe15290a-c124-11ea-23da-37a9f5b8c015
md"The amount of aerosols released depends on the concentration of PM25 particles"

# ╔═╡ 28c406d2-bf3e-11ea-1588-85dcbb06da28
PM25_release = PM25_concentration * biomass_release

# ╔═╡ 86f543c8-c124-11ea-1028-1770400aab41
md"Again, we can convert this to tons"

# ╔═╡ 877c337e-c124-11ea-1e12-c594d264d9df
PM25_release |> g

# ╔═╡ 609d994e-c17b-11ea-3491-290c7401e4cf
md"Finally to get the tracer element release, we can use the tracer element concentration"

# ╔═╡ 87041770-c17b-11ea-1d6c-f3f33c6161a8
TE_release = TE_ppm * PM25_release |> t

# ╔═╡ 982cf198-c17b-11ea-2d4b-2156579bb13d
md"## Now let's visualize this all"

# ╔═╡ 32133e3e-c19f-11ea-2ce4-5727bc4bc0c9
TE_all = [(3852 ±  500)ppm, # Fe
          (2062 ±  300)ppm, # Zn
          ( 292 ±   50)ppm, # Cu
          ( 121 ±   60)ppm, # Ni
          (  69 ±   31)ppm, # Mn
          (  36 ±   16)ppm, # Pb
          (  12 ±    5)ppm, # Cd
          (   3 ±    1)ppm] # Co

# ╔═╡ a5daaa70-c1c5-11ea-3346-418fe6a5348c
begin
	plt = plot(palette=Symbol(k))
	for (i,y) in enumerate(TE_all)
		scatter!(plt, [i], [y], color=i)
	end
	plt
end

# ╔═╡ 4f7be70a-c19f-11ea-3ea0-27bb9c774415
bar(TE_all .* PM25_release, label="",
	yunit=t, ylabel="Trace element release", color=Symbol(k),
	xticks=(1:8, ["Fe", "Zn", "Cu", "Ni", "Mn", "Pb", "Cd", "Co"]))

# ╔═╡ ae478a32-c1a4-11ea-2811-897674e59cc7
scatter(TE_all .* PM25_release, label="", yscale=:log10,
	yunit=t, ylabel="Trace element concentration", color=Symbol(k),
	xticks=(1:8, ["Fe", "Zn", "Cu", "Ni", "Mn", "Pb", "Cd", "Co"]))

# ╔═╡ 67154410-c1c2-11ea-2fb9-21d587241bfc
c = colorschemes[Symbol(k)]

# ╔═╡ 239ced20-c1c5-11ea-3b90-77a1914c4058
colorschemes

# ╔═╡ 679c6436-c253-11ea-1ae1-31bb577a8351
foo = @bind x Slider(5:15)

# ╔═╡ 784afcc0-c253-11ea-234f-85399ba1434b
foo

# ╔═╡ 83e54004-c253-11ea-068d-bd90f53688be
x

# ╔═╡ Cell order:
# ╟─d5c47124-bf3d-11ea-3a7f-5de680c0ccb7
# ╟─ece6186a-c122-11ea-3c63-c189705eef4b
# ╟─eb5b6d46-c0f8-11ea-19c6-c1fbb16a3af3
# ╠═2ec6aa1c-bf3e-11ea-3405-bfad44ce8a1c
# ╟─6aec1ad8-c0f9-11ea-1d4a-0b1c2f3bbdf7
# ╠═e6044c0e-c121-11ea-09e7-83fe06b2b0fe
# ╟─e5f36dc6-c121-11ea-2eaa-d3b5dc827d1b
# ╠═5568d6ae-c0f9-11ea-26f1-5b93f8746b3e
# ╟─24b2c264-c122-11ea-291c-2d3c129113a9
# ╠═24a160b2-c122-11ea-0f5a-ab0261434f0a
# ╟─a594242e-c122-11ea-37b5-4bb8c868c124
# ╠═bf764442-c122-11ea-16c7-6b13e38340be
# ╟─c44f50ee-c122-11ea-091d-bd1d5ed0deb4
# ╟─8ab93d92-c1a2-11ea-05bf-2b66301e2509
# ╠═cf6c1f2e-c0f9-11ea-2dca-cf6b6f09f8bc
# ╟─f1ad188e-c1a2-11ea-0102-6153b6ee6f1b
# ╟─6c29f7bc-c1a3-11ea-2fba-cdd7a06e97ea
# ╠═7ec2397c-c1a3-11ea-14ed-f1c11622a3ad
# ╟─a254156e-c123-11ea-098a-cfca38b0054f
# ╠═b011e41a-c123-11ea-2cb2-c50d24efcfad
# ╟─6cd13f62-c19f-11ea-19d6-2f4e46a990f8
# ╠═6d647e6c-c19f-11ea-104c-6fb9455a399b
# ╟─d2273856-c0f9-11ea-1790-631713619b05
# ╟─c79a8d28-c0f9-11ea-17ba-71521c81a5db
# ╟─7afa2b5a-c120-11ea-3702-7f1a103709d1
# ╟─21afb2c8-c121-11ea-3312-ffe7712013e9
# ╟─2765d092-c121-11ea-37e0-c33057cc27b0
# ╟─27fe7a90-c121-11ea-3780-1599ac8dce0b
# ╟─9fbd5b3c-c17b-11ea-23c8-273e8621e916
# ╟─445b670c-c121-11ea-38fd-e15f9a6de0fa
# ╠═4b796bd8-c121-11ea-33b1-cf75fd8ca91f
# ╟─57af0fac-c121-11ea-3061-1b4849b505d2
# ╠═b68eebd2-c121-11ea-1182-85627e982ded
# ╟─bb754e84-c121-11ea-0cf3-b71b04581505
# ╠═4ea07cfc-c121-11ea-22d1-5da737414604
# ╟─fe15290a-c124-11ea-23da-37a9f5b8c015
# ╠═28c406d2-bf3e-11ea-1588-85dcbb06da28
# ╟─86f543c8-c124-11ea-1028-1770400aab41
# ╠═877c337e-c124-11ea-1e12-c594d264d9df
# ╟─609d994e-c17b-11ea-3491-290c7401e4cf
# ╠═87041770-c17b-11ea-1d6c-f3f33c6161a8
# ╟─982cf198-c17b-11ea-2d4b-2156579bb13d
# ╠═32133e3e-c19f-11ea-2ce4-5727bc4bc0c9
# ╠═a5daaa70-c1c5-11ea-3346-418fe6a5348c
# ╠═4f7be70a-c19f-11ea-3ea0-27bb9c774415
# ╠═ae478a32-c1a4-11ea-2811-897674e59cc7
# ╠═1cc808fc-c1c2-11ea-0a9d-6b9d73935d86
# ╠═86ded2a8-c1c1-11ea-08e7-f9fa2961fd1d
# ╠═67154410-c1c2-11ea-2fb9-21d587241bfc
# ╠═239ced20-c1c5-11ea-3b90-77a1914c4058
# ╠═679c6436-c253-11ea-1ae1-31bb577a8351
# ╠═784afcc0-c253-11ea-234f-85399ba1434b
# ╠═83e54004-c253-11ea-068d-bd90f53688be
