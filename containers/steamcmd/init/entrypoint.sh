#!/bin/bash
state_file="/root/peon/config/server.state"
echo "-> Starting PEON SteamCMD server v$VERSION"
echo "##### Initialisation - START - $(date) #####"
# ONBOOT
echo -n "CONTAINER BOOTING" > $state_file
# RUN STANDARD SCRIPT
/init/init.sh && echo "PEON INIT - COMPLETE" || { echo "PEON INIT - FAILED"; exit 1; }
# RUN CUSTOM INIT, IF FOUND
if [ -e "/init/init_custom.sh" ]
then
    /init/init_custom.sh && echo "CUSTOM INIT - COMPLETE" || { echo "CUSTOM INIT - FAILED"; exit 1; }
fi
echo "##### Initialisation - END #####"
echo "##### Server - START #####"
echo -n "SERVER STARTED" > $state_file
### SERVER START
/init/start_server.sh
echo "##### Server - END #####"