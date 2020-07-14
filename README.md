# MTELIntroToJulia


## Preliminary setup

This repository uses a number of Julia packages that you may not have installed on your machine (listed in the [`Project.toml`](Project.toml) file) . You can either
- "instantiate" the project –
    Start julia at the root of the repository (in `MTELIntroToJulia/`),
    type `]` to enter package mode,
    and then

    ```julia
    (@v1.4) pkg> activate .
     Activating environment at `~/Projects/MTELIntroToJulia/Project.toml`

    (MTELIntroToJulia) pkg> instantiate
    ```
    This should be all you need to get all setup, and you can now follow the instructions in [Getting started](#getting-started)

- or you can install packages manually at the REPL. E.g., to install Pluto.jl, you can type `]` to enter package mode, and then

    ```julia
    (@v1.4) pkg> add Pluto
    ```

(Press `delete` to get out of Pkg mode and back into normal REPL mode.)


## Getting started

### The pluto notebook

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

        <img width=50% src="https://user-images.githubusercontent.com/4486578/87274939-5c83fa80-c520-11ea-9aec-f25ea28e051e.png">

        Enter the path (`src/tuto1.jl`) and click "Open" to start the notebook.

### The Jupyter notebook

Follow the instructions on [`notebooks/ReadMe.md`](notebooks/ReadMe.md).
