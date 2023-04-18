# This file deploys/runs all of the various house keeping tasks for a PEON game server.
state_file="/home/peon/status/server.state"
echo "###### SteamCMD [UPDATING]"
echo -n "STEAMCMD UPDATING" > $state_file
/home/steam/steamcmd/steamcmd.sh +app_update +quit
echo "###### Server [UPDATING]"
echo "> STEAM GAME SERVER ID [$STEAMID]"
echo -n "GAME SERVER UPDATING" > $state_file
/home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/server_files +login anonymous +app_update $STEAMID +quit