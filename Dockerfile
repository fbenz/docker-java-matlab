FROM openjdk:8u151-jre

MAINTAINER Florian Benz

ADD matlab.txt /mcr-install/matlab.txt

RUN apt-get update && \
	apt-get install -y curl wget unzip xorg

# Install python 3.7 (build from sources, because it's not yet in the debian repos)
RUN apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
	libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev && \
	cd /usr/local && \
	wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz && \
	tar xzf Python-3.7.3.tgz && \
	cd Python-3.7.3 && \
	./configure --with-ensurepip=install && \
	make && \
	make altinstall && \
	chmod +x python3.7 && \
	cd /


# Install MATLAB runtime
RUN \
	cd /mcr-install && \
	wget -nv http://de.mathworks.com/supportfiles/downloads/R2015b/deployment_files/R2015b/installers/glnxa64/MCR_R2015b_glnxa64_installer.zip && \
	unzip MCR_R2015b_glnxa64_installer.zip && \
	mkdir /opt/mcr && \
	./install -inputFile matlab.txt && \
	cd / && \
	rm -rf mcr-install

