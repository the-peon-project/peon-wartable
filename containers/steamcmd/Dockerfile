# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon SteamCMD"
LABEL "maintainer"="Umlatt <richard@noxnoctua.com>"
USER root
# TEMP: Install debug tools
RUN apt-get update
RUN apt-get -y install procps iputils-ping dnsutils vim
# VERSION
ARG VERSION
ENV VERSION=${VERSION}
RUN echo VERSION=${VERSION} >> /etc/environment
# Start application
COPY ./init /init
ENTRYPOINT [ "/bin/bash", "/init/entrypoint.sh"]