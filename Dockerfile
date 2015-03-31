# Based on Ubuntu with Java 8 installed.
FROM dockerfile/java:oracle-java8

ADD matlab.txt /mcr-install/matlab.txt

RUN \
	apt-get update && \
	apt-get install -y wget xorg unzip

# Install MatLab runtime.
RUN \
	cd /mcr-install && \
	wget -nv http://de.mathworks.com/supportfiles/downloads/R2015a/deployment_files/R2015a/installers/glnxa64/MCR_R2015a_glnxa64_installer.zip && \
	unzip MCR_R2015a_glnxa64_installer.zip && \
	mkdir /opt/mcr && \
	./install -inputFile matlab.txt && \
	cd / && \
	rm -rf mcr-install

# Define default command.
CMD ["bash"]
