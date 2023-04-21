# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon Steamcmd & Wine HQ"
LABEL "maintainer"="Umlatt <richard@noxnoctua.com>"
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
# ---------------------------------------- 
# WINE HQ
RUN apt-get install -y gnupg software-properties-common xvfb
RUN dpkg --add-architecture i386
RUN curl https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository https://dl.winehq.org/wine-builds/debian/
RUN apt-get update && apt-get install -y --install-recommends winehq-stable
RUN mkdir /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix
RUN export PATH=$PATH:/opt/wine-stable/bin
# WINE HQ
# ----------------------------------------
# CONFIGURE ENVIRONMENT
USER steam
RUN mkdir -p /home/steam/peon/
ENTRYPOINT [ "/bin/bash", "/init/entrypoint"]