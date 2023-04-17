# This file deploys/runs all of the various house keeping tasks for a PEON game server.
state_file="/root/peon/config/server.state"
echo "##################### UPDATING STEAMCMD ######################"
echo -n "STEAMCMD UPDATING" > $state_file
/root/.local/share/Steam/steamcmd/steamcmd.sh +app_update +quit
echo "###################### STEAMCMD UPDATED ######################"
echo "#################### PULLING GAME SERVER #####################"
echo "> SERVER ID [$STEAMID]"
echo -n "GAME SERVER UPDATING" > $state_file
/root/.local/share/Steam/steamcmd/steamcmd.sh +force_install_dir ./data +login anonymous +app_update $STEAMID +quit
echo "#################### GAME SERVER UPDATED #####################"