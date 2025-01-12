# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon Steamcmd & Wine HQ"
LABEL "maintainer"="Umlatt <richard@lazylionconsulting.com>"
# CHANGE USER
USER root
# BRANDING
COPY ./media/motd /etc/motd
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
RUN apt-get install -y gnupg software-properties-common xvfb lib32gcc-s1 libstdc++6
RUN dpkg --add-architecture i386
RUN curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /usr/share/keyrings/winehq-archive-keyring.gpg
RUN DEBIAN_VERSION=$(cat /etc/os-release | grep '^VERSION_CODENAME=' | cut -d '=' -f 2) && echo "deb [signed-by=/usr/share/keyrings/winehq-archive-keyring.gpg] https://dl.winehq.org/wine-builds/debian/ $DEBIAN_VERSION main" > /etc/apt/sources.list.d/winehq.list
RUN apt-get update && apt-get install -y --install-recommends winehq-stable
RUN mkdir /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix
RUN export PATH=$PATH:/opt/wine-stable/bin
# WINE HQ
ENV OS_TYPE=windows
# ----------------------------------------
# CONFIGURE ENVIRONMENT
ENV LOG_PATH=/proc/1/fd/1
RUN touch /etc/environment && chown 1000:1000 /etc/environment
USER steam
RUN mkdir -p /home/steam/config/
# Configure version
ENV CONTAINER_TYPE="steamcmd-winehq"
ARG VERSION
ENV VERSION=${VERSION}
RUN echo VERSION=${VERSION} >> /etc/environment
ENTRYPOINT [ "/bin/bash", "/init/entrypoint"]