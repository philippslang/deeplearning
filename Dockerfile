FROM nvidia/cuda:8.0-cudnn6-runtime-centos7

RUN yum install -y git curl bzip2 wget && yum clean all

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p /opt/conda \   
    && /opt/conda/bin/conda clean -ya \
    && rm ~/miniconda.sh

# instead of an environment we just add root distro to path, container anyways
ENV PATH /opt/conda/bin:$PATH
RUN conda install -y numpy pyyaml scipy ipython mkl pytorch torchvision cuda80 -c soumith
RUN conda install -c conda-forge tensorflow
RUN conda install -c anaconda tensorflow-tensorboard 
RUN conda install -c anaconda notebook 
RUN conda install -c conda-forge jupyterlab
