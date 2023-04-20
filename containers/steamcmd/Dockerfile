# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon SteamCMD"
LABEL "maintainer"="Umlatt <richard@noxnoctua.com>"
# CHANGE USER
USER root
# BRANDING: Copy branding into container
COPY ./media/banner /etc/motd
RUN echo "cat /etc/motd" >> /etc/bash.bashrc
# ADD LIBRARIES TO PATH
ENV LD_LIBRARY_PATH=/root/.steam/sdk32:$LD_LIBRARY_PATH
# TEMP: Install debug tools
RUN apt-get update
RUN apt-get -y install procps iputils-ping dnsutils vim
# VERSION
ARG VERSION
ENV VERSION=${VERSION}
RUN echo VERSION=${VERSION} >> /etc/environment
# PERMISSIONS
RUN mkdir -p /home/steam/peon/upload /home/steam/peon/download /home/steam/steamcmd/data
RUN chown -R 1000:1000 /home/steam
# CONFIGURE FOR START
USER steam
COPY ./init /init
ENTRYPOINT [ "/bin/bash", "/init/entrypoint.sh"]