### A Pluto.jl notebook ###
# v0.10.9

using Markdown
using InteractiveUtils

# ╔═╡ 40d0c1c2-c649-11ea-2373-a7f12fbda046
md"## Random and Statistics"

# ╔═╡ 3d578724-c649-11ea-174a-bd0111402285
md"""
Use 
- `rand` to generate a uniformly-distributed random number between 0 and 1
- `randn` to generate a normally-distributed random number with mean 0 and variance 1
"""

# ╔═╡ a4b67a4c-c649-11ea-30f4-adea7b953f1e
md"You can generate many random numbers"

# ╔═╡ 9459d500-c648-11ea-0118-ed043c222e0d
md"## LinearAlgebra and SparseArrays"

# ╔═╡ 68425c66-c649-11ea-1ab9-8d01591f3880
using Plots # not a standard library

# ╔═╡ a1043ae8-c648-11ea-2e69-5184a118eadc
using Random, Statistics

# ╔═╡ 9b52f67a-c648-11ea-0688-938f54428f2f
using LinearAlgebra, SparseArrays

# ╔═╡ 4d777034-c64d-11ea-3a57-33c61be38a15
let 
	using Latexify
	A = 0.01rand(3,3) + I
	b = rand(3)
	x = A \ b
	md"""
	If A = $(latexify(round.(A, digits=3))) and b = $(latexify(round.(b, digits=3)))
	
	the solution to Ax = b is $(latexify(round.(x, digits=3)))
	"""
end

# ╔═╡ 63a1041e-c649-11ea-016a-e12761a17fdd
x = rand()

# ╔═╡ 87fb231c-c649-11ea-3e6f-2bc7e3ad35de
xs = 3randn(10000) .+ 1

# ╔═╡ 8f72d9d4-c649-11ea-1918-5fea38ed4b8b
histogram(xs, bins=100, α=0.4)

# ╔═╡ a281297e-c64a-11ea-139d-d1745e242da2
mean(xs, dims=1)

# ╔═╡ be1ed750-c64a-11ea-3214-c36dd2b4764e
let
	x = min.(exp.(randn(100000) .+ 2), 100)
	histogram(x, bins=100, α=0.4, lab="data", xlab="x", ylab="count")
	μ, m, σ = mean(x), median(x), std(x)
	vline!([μ], lab="μ = mean(x)")
	vline!([m], lab="m = median(x)")
	vspan!([μ-σ, μ+σ], lab="μ ± σ interval", α=0.1)
end

# ╔═╡ b06a94f6-c64c-11ea-1fc0-ad4ceb30386d
set1 = ["●", "○"]

# ╔═╡ b0234d0a-c64c-11ea-371a-ff7f8e1cdbdb
rand(set1)

# ╔═╡ 02fa121e-c64d-11ea-1686-df45404e16d1
set2 = 0:9

# ╔═╡ 0b19140e-c64d-11ea-1adc-9d47a8474940
set3 = ["Emily T.", "Phil", "Seth", "Xiaopeng", "Janine", "Rachel", "Emily S.", "Shun", "Cecilia", "Robert", "Hengdi", "Isabel"]

# ╔═╡ 133983f8-c64d-11ea-0388-c1aa871e9f56
md"**$(rand(set3))** will present at next week's lab meeting!"

# ╔═╡ 4e9ae950-c64d-11ea-0143-a56a92c1ee66
[1, 2, 3]

# ╔═╡ 62311e1c-c64d-11ea-2a7a-4d488ad1b3f5
1:10

# ╔═╡ 579720f2-c64d-11ea-2a41-0f3ba73d8268
[1 2; 3 4]

# ╔═╡ 41c108b8-c64d-11ea-303c-81ff2f215362
[1 2
 3 4]

# ╔═╡ d8f79776-c64e-11ea-3f23-79d117f0307e


# ╔═╡ db9d4fe6-c648-11ea-0e47-f35171e7e77e


# ╔═╡ Cell order:
# ╟─40d0c1c2-c649-11ea-2373-a7f12fbda046
# ╠═68425c66-c649-11ea-1ab9-8d01591f3880
# ╠═a1043ae8-c648-11ea-2e69-5184a118eadc
# ╟─3d578724-c649-11ea-174a-bd0111402285
# ╠═63a1041e-c649-11ea-016a-e12761a17fdd
# ╟─a4b67a4c-c649-11ea-30f4-adea7b953f1e
# ╠═87fb231c-c649-11ea-3e6f-2bc7e3ad35de
# ╠═8f72d9d4-c649-11ea-1918-5fea38ed4b8b
# ╠═a281297e-c64a-11ea-139d-d1745e242da2
# ╠═be1ed750-c64a-11ea-3214-c36dd2b4764e
# ╠═b06a94f6-c64c-11ea-1fc0-ad4ceb30386d
# ╠═b0234d0a-c64c-11ea-371a-ff7f8e1cdbdb
# ╠═02fa121e-c64d-11ea-1686-df45404e16d1
# ╠═0b19140e-c64d-11ea-1adc-9d47a8474940
# ╠═133983f8-c64d-11ea-0388-c1aa871e9f56
# ╟─9459d500-c648-11ea-0118-ed043c222e0d
# ╠═9b52f67a-c648-11ea-0688-938f54428f2f
# ╠═4e9ae950-c64d-11ea-0143-a56a92c1ee66
# ╠═62311e1c-c64d-11ea-2a7a-4d488ad1b3f5
# ╠═579720f2-c64d-11ea-2a41-0f3ba73d8268
# ╠═41c108b8-c64d-11ea-303c-81ff2f215362
# ╠═d8f79776-c64e-11ea-3f23-79d117f0307e
# ╠═4d777034-c64d-11ea-3a57-33c61be38a15
# ╠═db9d4fe6-c648-11ea-0e47-f35171e7e77e
