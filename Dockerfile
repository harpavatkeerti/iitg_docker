FROM tensorflow/tensorflow:latest-gpu-py3
#ENV http_proxy http://172.16.117.121:3128
#ENV https_proxy http://172.16.117.121:3128

# Identify the maintainer of an image
LABEL maintainer="keert170101031@iitg.ac.in"
LABEL version="0.1"
LABEL description="pytorch + some other libraries"
#
# Update the image to the latest packages
#RUN apt-get update && apt-get upgrade -y
RUN apt-get update

#
RUN apt-get install -y wget vim htop fish datamash graphviz libgraphviz-dev

RUN pip3 --no-cache-dir install ipython pandas

RUN pip3 --no-cache-dir install docopt joblib natsort scipy

RUN pip3 --no-cache-dir install matplotlib librosa scikit-learn numpy torch==1.6.0+cu101

RUN pip3 --no-cache-dir install dill bleach namedtupled

RUN pip3 --no-cache-dir install PyEMD

# RUN pip3 --no-cache-dir install pytorch-pretrained-bert==0.6.1 torch==1.0.1.post2 seqeval==0.0.5 nltk

RUN pip3 --no-cache-dir install networkx pathlib pygraphviz

RUN apt-get install -y git

#
RUN apt-get install -y python3-venv

# Install locales
RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
