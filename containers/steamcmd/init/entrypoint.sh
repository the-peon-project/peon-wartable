#!/bin/bash
state_file="/home/steam/peon/state"
ip_file="/home/steam/peon/ip"
#echo -e "\e[32mword\e[0m"
echo "###################################################"
echo -e "##### Starting e[32PEON\e[0m SteamCMD server v$VERSION"
echo "##### $(date)"
echo "###################################################"
echo "##### Initialisation [START]"
# ONBOOT
echo -n "BOOTING" > $state_file
echo "0.0.0.0" > $ip_file
# RUN STANDARD SCRIPT
/init/init.sh && echo "PEON INIT - COMPLETE" || { echo "PEON INIT - FAILED"; exit 1; }
# RUN CUSTOM INIT, IF FOUND
if [ -e "/init/init_custom" ]
then
    /init/init_custom && echo "CUSTOM INIT [COMPLETE]" || { echo "CUSTOM INIT [FAILED]"; exit 1; }
fi
echo "##### Initialisation [END]"
### SERVER START
echo "##### Server [START]"
if [ -e "/init/server_start" ]
then
    echo -n "ACTIVE" > $state_file
    dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '\"' > $ip_file
    /init/server_start
else
    echo -n "ERROR.MISSING_START_SCRIPT" > $state_file
    echo " ERROR /init/server_start.sh not found. Did you forget to configure the mount for it?"
fi
echo "##### Server [END]"
