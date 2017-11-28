FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

RUN apt-get update && apt-get install -y git curl vim && rm -rf /var/lib/apt/lists/*

ENV VENV=pythondl
ENV PYTHON_VERSION=3.6
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/conda \     
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda create -y --name $VENV python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl \
    && /opt/conda/bin/conda clean -ya

# instead of sourcing the environment we just add it to path, container anyways
ENV PATH /opt/conda/envs/$VENV/bin:$PATH
RUN conda install -y --name $VENV pytorch torchvision cuda80 -c soumith
