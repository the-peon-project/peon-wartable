# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon Steamcmd & Wine HQ"
LABEL "maintainer"="Umlatt <richard@noxnoctua.com>"
USER root
# Get latest package versions & instgall dependancies
RUN apt-get update && apt-get upgrade -y && apt-get install -y gnupg software-properties-common
# Configure & install winehq
RUN dpkg --add-architecture i386
RUN curl https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository https://dl.winehq.org/wine-builds/debian/
RUN apt-get update && apt-get install -y --install-recommends winehq-stable
RUN export PATH=$PATH:/opt/wine-stable/bin
# TEMP: Install debug tools
RUN apt-get -y install procps iputils-ping dnsutils vim
# Configure run command
CMD ["/bin/bash"]