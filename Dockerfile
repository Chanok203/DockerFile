ARG python_version=3.5 
ARG cuda_version=10.1


FROM nvidia/cuda:${cuda_version}}-cudnn7-devel-ubuntu18.04

LABEL maintainer "pathompatai_c@silpakorn.edu"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        curl \
        wget \
        ca-certificates \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        links2 \
        nano \
        libx11-6 \
        libglib2.0-dev \
        libfontconfig1 \
        libxrender1 \
        libsm6 \
        libxext6 \
        git \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh \
        && chmod +x Anaconda3-2020.02-Linux-x86_64.sh \
        && ./Anaconda3-2020.02-Linux-x86_64.sh -b \
        && rm Anaconda3-2020.02-Linux-x86_64.sh

ENV PATH=/root/anaconda3/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

RUN conda create -y --name python_env python=${python_version}

ENV CONDA_DEFAULT_ENV=python_env
ENV CONDA_PREFIX=/root/anaconda3/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH

RUN conda install -y conda-build
RUN conda install -y -c anaconda nodejs jupyterlab ipywidgets \
        && conda clean -ya
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

RUN python -m jupyter notebook --generate-config
COPY ./.bashrc /root
COPY ./jupyter_notebook_config.py /root/.jupyter/

RUN mkdir /notebooks
RUN mkdir /notebooks/Test-Code

WORKDIR /notebooks/Test-Code
COPY ./tensorflow.ipynb ./
COPY ./pytorch.ipynb ./

WORKDIR /notebooks


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
# WEB DEVOLOPMENT
EXPOSE 5000
# WEB PRODUCTION
EXPOSE 80

CMD ["bash", "-c", "python -m jupyter lab --port 8888 --ip 0.0.0.0 --no-browser --allow-root"]
