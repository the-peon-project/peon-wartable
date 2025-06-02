# Base image cm2network's steamcmd
FROM cm2network/steamcmd
# Build information
LABEL "com.peon.description"="Peon Steamcmd & Proton (GE)"
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
# CONFIGURE ENVIRONMENT
ENV LOG_PATH=/proc/1/fd/1
RUN dpkg --add-architecture i386 
RUN apt-get install --no-install-recommends -y ca-certificates winbind dbus libfreetype6 curl jq locales lib32gcc-s1 
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN rm -f /etc/machine-id && dbus-uuidgen --ensure=/etc/machine-id
RUN rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove -y
RUN touch /etc/environment && chown 1000:1000 /etc/environment
USER steam
ENV STEAMCMD_PATH="/home/steam/steamcmd"
ENV STEAM_SDK64_PATH="/home/steam/.steam/sdk64"
ENV STEAM_SDK32_PATH="/home/steam/.steam/sdk32"
ENV OS_TYPE=windows
# ---------------------------------------- 
# PROTON GE
ENV GE_PROTON_VERSION "10-4"
ENV GE_PROTON_URL "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${GE_PROTON_VERSION}/GE-Proton${GE_PROTON_VERSION}.tar.gz"
RUN mkdir "${STEAMCMD_PATH}/compatibilitytools.d/" && curl -sqL "$GE_PROTON_URL" | tar zxvf - -C "${STEAMCMD_PATH}/compatibilitytools.d/"
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH "$STEAMCMD_PATH"
ENV STEAM_COMPAT_DATA_PATH "${STEAMCMD_PATH}/steamapps/compatdata/${STEAM_APP_ID}"
RUN mkdir -p $STEAM_COMPAT_DATA_PATH && chmod -R 755 $STEAM_COMPAT_DATA_PATH
ENV WINEDEBUG=-all
ENV UMU_ID 0
# PROTON GE
# ----------------------------------------
RUN mkdir -p /home/steam/config/
# Configure version
ENV CONTAINER_TYPE="umlatt/steamcmd-proton"
ARG VERSION
ENV VERSION=${VERSION}
RUN echo VERSION=${VERSION} >> /etc/environment
ENTRYPOINT [ "/bin/bash", "/init/entrypoint"]