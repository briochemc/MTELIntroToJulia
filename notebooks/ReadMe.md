# Notebooks

This directory contains the notebooks generated for this introduction to Julia.
It should be empty when you first clone this repository (except for this `ReadMe.md`)

To generate the notebooks, go to the root of the repository, start Julia, and copy-paste

```julia
using Literate
for f in ["syntax.jl"]
    notebook(joinpath(pwd(), "src", f), outputdir=joinpath(pwd(), "notebooks"))
end
```

(TODO: Maybe use a small makefile instead.)
