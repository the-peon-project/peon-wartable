#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
rootpath="/home/steam/steamcmd/"
cd $rootpath
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "##################### STARTING SERVER ######################"
# CUSTOM GAME SERVER COMMAND
./data/srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount $STEAM_APP_ID
