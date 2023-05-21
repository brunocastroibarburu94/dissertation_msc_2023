#  Jupyter Notebook with Julia

### How to Run Locally ###
1. run lcBuid.sh to build the image 
1. Option A: 2 steps
    2. run lcRun.sh to run the container with that image and enter in an interactive console
    2. run "make jupyterlab" within the console to start the jupyter server
1. Option B: 1 step
    2. run lcDeploy.sh to run the container with that image and start spin up the jupyter server simultaneously

```bash
# Build local container
. lcBuid.sh

# A.1 Run local container
. lcRun.sh
# A.2 Deploy Jupyterlab server
make jupyterlab

# B.1 Run container and deploy jupyterlab server
. lcDeploy.sh
```

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
