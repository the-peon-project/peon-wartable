#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
echo "" > $logfile
# Handle parameters
if [ $# -eq 0 ]
  then
    echo "Steam game id required. e.g. > ./${0##*/} 12345"
    echo "Script was run without a steam ID" >> $logfile
    exit 1
else
    game_id=$1
fi
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "STEAMCMD UPDATING" > ./data/server.state
./steamcmd.sh +app_update +quit
echo "############################## STEAMCMD UPDATED ##############################"
echo "GAME SERVER UPDATING" > ./data/server.state
./steamcmd.sh +force_install_dir ./data +login anonymous +app_update $game_id +quit
echo "############################## GAME SERVER UPDATED ##############################"
echo "READY" > ./data/server.state