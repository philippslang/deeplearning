FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

RUN apt-get update && apt-get install -y git curl vim && rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/conda \   
    && /opt/conda/bin/conda clean -ya \
    && rm ~/miniconda.sh

# instead of an environment we just add root distro to path, container anyways
ENV PATH /opt/conda/bin:$PATH
RUN conda install -y numpy pyyaml scipy ipython mkl pytorch torchvision cuda80 -c soumith
