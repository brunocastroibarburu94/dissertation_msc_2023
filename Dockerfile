FROM python:3.9-bullseye


# ========== Install Julia ==========
WORKDIR /
# For installation of Julia
ENV JULIA_VER=1.8.5
ENV JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.8
# For correct routing of PyCall
ENV PYTHON=/root/.julia/conda/3/x86_64

# Download Julia binary
RUN curl -LO ${JULIA_URL}/julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	tar -xf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	ln -s /julia-${JULIA_VER}/bin/julia /usr/local/bin/julia && \
	rm -rf julia-${JULIA_VER}-linux-x86_64.tar.gz 


# ========== Update System ==========
RUN apt-get -y update  && apt-get -y upgrade

# ========== Install Python Extras ==========

# Pip-tools dependencies
RUN apt-get -y install build-essential libssl-dev libffi-dev python-dev curl

# Install dependencies for zipline-reloaded, it uses Cython and TA-Lib
RUN apt install -y libatlas-base-dev python-dev gfortran pkg-config libfreetype6-dev hdf5-tools
WORKDIR /temp
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz
WORKDIR /temp/ta-lib/
RUN  ./configure
RUN make
RUN make install


RUN pip install pip-tools

# Python Packages
COPY ./python/requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt


# ========== Install Julia Extras ==========
# Get Packages requirements
# Replace manifest and project tomls with the ones in project 
# (this will allow to pre-download all packages from them) 

COPY ./julia/Project.toml /root/.julia/environments/v1.8/Project.toml 
COPY ./julia/Manifest.toml /root/.julia/environments/v1.8/Manifest.toml 

RUN julia -e 'using Pkg; Pkg.instantiate()'

# ========== Setup Working directory ==========
WORKDIR /root/project


ENTRYPOINT ["bash",  "/root/project/entrypoint.sh"]

