FROM nvidia/cuda:9.1-cudnn7-runtime-centos7

RUN yum install -y git curl bzip2 wget && yum clean all

RUN curl -o ~/conda.sh -O  https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh \
    && chmod +x ~/conda.sh \
    && ~/conda.sh -b -p /opt/conda \   
    && /opt/conda/bin/conda clean -ya \
    && rm ~/conda.sh

# instead of an environment we just add root distro to path, container anyways
ENV PATH /opt/conda/bin:$PATH
RUN conda update -y -n base conda
RUN conda install -y ipython mkl 
RUN conda install pytorch torchvision cuda91 -c pytorch
RUN conda install -y -c anaconda tensorflow-gpu 
RUN pip install tensorboard==1.8.0
RUN conda install -y -c anaconda notebook 
RUN conda install -y -c conda-forge jupyterlab attrdict tensorboardx

# tensorboard default port
EXPOSE 6006
