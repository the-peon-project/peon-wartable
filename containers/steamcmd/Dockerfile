# BASE IMAGE
FROM debian:bullseye-slim
# BUILD INFO
LABEL "com.peon.description"="Peon Steam Server"
LABEL "maintainer"="Umlatt <richard@noxnoctua.com>"
COPY ./config/sources.list /etc/sources.list
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install software-properties-common gosu sudo 
# TEMP: The following modules can be removed for production
RUN apt-get -y install procps iputils-ping dnsutils vim
# STEAM
# Create the steam user with home directory /home/steam
RUN useradd -m -s /bin/bash steam && \
    mkdir -p /home/steam/.steam && \
    chown -R steam:steam /home/steam

# Install sudo and give the steam user non-password protected sudo access
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "steam ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/steam && \
    chmod 0440 /etc/sudoers.d/steam
# Switch to the steam user and set the working directory to /home/steam
USER steam
WORKDIR /home/steam
# Install steamcmd with sudo
RUN sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get install -y lib32gcc-s1
    
RUN sudo apt-get install -y steamcmd

# CLEANUP
#RUN apt-get update && apt-get purge -y sudo && apt-get autoremove -y && apt-get clean
USER root
# VERSION
ARG VERSION
ENV VERSION=${VERSION}
RUN echo VERSION=${VERSION} >> /etc/environment
