#!/bin/bash
# STEAM GAME ID
game_id='740'
#SCRIPT START
logfile="/var/log/peon/${0##*/}.log"
# Logging config start - Create logfile and capture all stdout to it
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "UPDATING STEAMCMD" > ./data/server.state
echo "Updating steamcmd."
./steamcmd.sh +app_update +quit
echo "PULLING SERVER FILES" > ./data/server.state
echo "Installing/configuring the game server."
./steamcmd.sh +force_install_dir ./data +login anonymous +app_update $game_id +quit
echo "Adding server ready file, for hand back"
echo "READY" > ./data/server.state
echo "Processing complete."

# https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Docker