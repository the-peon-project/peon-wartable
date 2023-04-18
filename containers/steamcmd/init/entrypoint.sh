#!/bin/bash
state_file="/home/peon/status/server.state"
echo "###################################################"
echo "##### Starting PEON SteamCMD server v$VERSION"
echo "###################################################"
echo "##### Initialisation [START] $(date)"
# ONBOOT
echo -n "CONTAINER BOOTING" > $state_file
# RUN STANDARD SCRIPT
/init/init.sh && echo "PEON INIT - COMPLETE" || { echo "PEON INIT - FAILED"; exit 1; }
# RUN CUSTOM INIT, IF FOUND
if [ -e "/init/init_custom.sh" ]
then
    /init/init_custom.sh && echo "CUSTOM INIT - COMPLETE" || { echo "CUSTOM INIT - FAILED"; exit 1; }
fi
echo "##### Initialisation [END]"

### SERVER START
echo "##### Server [START]"
if [ -e "/init/server_start" ]
then
    echo -n "READY" > $state_file
    /init/server_start
else
    echo -n "ERROR - BAD PLAN" > $state_file
    echo " ERROR /init/server_start.sh not found. Did you forget to mount it?"
fi
echo "##### Server [END]"
echo ""
