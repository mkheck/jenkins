# Pull base image
# ---------------
FROM jenkinsci/jenkins:latest

# Author
# ------
MAINTAINER Mark Heckler <mark.heckler@gmail.com, @MkHeck>

# Build the container
# -------------------

USER root

# install wget
RUN apt-get install -y wget

# get maven 3.2.2
RUN wget --no-verbose -O /tmp/apache-maven-3.3.3.tar.gz http://apache.cs.utah.edu/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz

# verify checksum
RUN echo "794b3b7961200c542a7292682d21ba36 /tmp/apache-maven-3.3.3.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.3.3.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.3.3 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.3.3.tar.gz
ENV MAVEN_HOME /opt/maven

RUN chown -R jenkins:jenkins /opt/maven

# install git (MH: Git should be preinstalled in the original Jenkins docker image prep)
# RUN apt-get install -y git

# remove download archive files
RUN apt-get clean

USER jenkins
