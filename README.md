#  Algorithic Trading using Optimal Control in the Julia Language

Welcome to the repository containing the implementation of the final year project by Bruno Castro for the MSc. in Optimization and Control at Imperial College London.

In this repository you will find Jupyter Notebooks with examples and figures used in the final year project. This is separate from any particular package developed or enhanced by the student during his work in the project.

Instructions will be available below 


### How to Run Locally ###
1. Open a bash terminal and run 
```bash
. local_container.sh
```
2. Instantiate a jupyter lab server with
```bash
make jupyterlab
```
### Adding a custom package hosted in GitHub
Some of the packages used may not be register in the Julia registry. In principle all packages needed for the notebooks in this repository should be added automatically when building the docker image. However if any of the packages seem not to be installed this can be solved by opening a console and adding them manually using the code below as a guideline.
```julia
# From a julia console type ] to enter into REPL mode
add "https://github.com/brunocastroibarburu94/AlgoSource.jl.git#master"
# Done now you can use that package.
```

<!-- 
### Package Management ###
When developing using Docker, all the packages from the Manifest.toml will be installed during the build process.

To add/remove/update additional packages when developing, run a docker container and using the bash command line type
```bash
make julia
```
This will open a julia console using the project under "./project/". Press "]" to open the Pkg REPL and then proceed to add/remove/update packages.
```bash
add JuMP
```

**Doing it from Jupyterlab**<br>
If you wish to add a package and that package to be added to the image next time you run the build command you can switch the project using to the folder *./julia* and then proceed to add and remove packages. 
```julia
using Pkg
Pkg.activate("./julia")
Pkg.add("HTTP")
``` 
-->
