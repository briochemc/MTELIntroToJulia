# MTELIntroToJulia


## Getting started

1. Start Pluto with

    ```julia
    julia> using Pluto

    julia> Pluto.run(1234)
    Go to http://localhost:1234/ to start writing ~ have fun!

    Press Ctrl+C in this terminal to stop Pluto
    ```

2. Open Pluto in the browser

    Go to `[http://localhost:1234/](http://localhost:1234/)` on your browser
    (or CMD-click the link displayed at the REPL instead of copy-pasting the URL).

3. Open the `tuto1` notebook

    Enter the path (`src/tuto1.jl`) and that should start the notebook.

## Packages

This repository uses a number of Julia packages that you may not have installed on your machine (listed in the `Projects.toml` file) . To solve this problem, you can either install them manually, or you can "instantiate" the project's "Manifest", by going at the root of the repo, starting Julia, and, at the REPL, typing

```julia
julia> using Pkg; Pkg.activate("."); Pkg.instantiate()
 Activating environment at `~/Projects/MTELIntroToJulia/Project.toml`
```

