#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
rootpath="/home/steam/steamcmd"
cd $rootpath
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "##################### UPDATING STEAMCMD ######################"
echo "STEAMCMD UPDATING" > ./data/server.state
./steamcmd.sh +app_update +quit
echo "###################### STEAMCMD UPDATED ######################"
echo "################## DOWNLOADING GAME SERVER ###################"
echo "> SERVER ID [$STEAMID]"
echo "GAME SERVER UPDATING" > ./data/server.state
./steamcmd.sh +force_install_dir ./data +login anonymous +app_update $STEAMID +quit
echo "#################### GAME SERVER UPDATED #####################"