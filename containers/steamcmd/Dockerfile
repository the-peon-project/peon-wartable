# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon SteamCMD"
LABEL "maintainer"="Umlatt <richard@lazylionconsulting.com>"
# CHANGE USER
USER root
# BRANDING
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
COPY ./init /init
RUN chown -R 1000:1000 /init
# FIRSTBOOT PERMISSIONS
RUN cp /etc/shadow /etc/shadow.bkp && sed -i 's/^root:[^:]*:/root::/' /etc/shadow
# CONFIGURE ENVIRONMENT
ENV LOG_PATH=/proc/1/fd/1
USER steam
RUN mkdir -p /home/steam/config/
ENTRYPOINT [ "/bin/bash", "/init/entrypoint"]