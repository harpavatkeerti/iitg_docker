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
RUN apt-get update -y

#
ADD file:c3e6bb316dfa6b81dd4478aaa310df532883b1c0a14edeec3f63d641980c1789 in /

/bin/sh -c [ -z "$(apt-get indextargets)" ]
/bin/sh -c set -xe 		&& echo '#!/bin/sh' > /usr/sbin/policy-rc.d 	&& echo 'exit 101' >> /usr/sbin/policy-rc.d 	&& chmod +x /usr/sbin/policy-rc.d 		&& dpkg-divert --local --rename --add /sbin/initctl 	&& cp -a /usr/sbin/policy-rc.d /sbin/initctl 	&& sed -i 's/^exit.*/exit 0/' /sbin/initctl 		&& echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup 		&& echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean 	&& echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean 	&& echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean 		&& echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages 		&& echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes 		&& echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests
/bin/sh -c mkdir -p /run/systemd && echo 'docker' > /run/systemd/container
CMD ["/bin/bash"]
LABEL com.nvidia.volumes.needed=nvidia_driver
RUN /bin/sh -c apt-get update && apt-get install -y --no-install-recommends         ca-certificates         libjpeg-dev         libpng-dev &&     rm -rf /var/lib/apt/lists/* # buildkit
COPY /opt/conda /opt/conda # buildkit
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
WORKDIR /workspace

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
