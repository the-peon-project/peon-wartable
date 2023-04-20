# This file deploys/runs all of the various house keeping tasks for a PEON game server.
state_file="/home/steam/peon/state"
steamcmd="/home/steam/steamcmd/steamcmd.sh"
# FILESYSTEM
## Links the config path to the downloads folder for external axcess
if [ -z "$CONFIG_PATH" ]; then
    config_setting="$CONFIG_PATH /home/steam/peon/download none bind 0 0"
    if ! grep -q $config_setting /etc/fstab; then
        echo "##### Configuring SAVE location"
        echo $config_setting  >> /etc/fstab
        mount -a
    fi
fi
# STEAM
echo "###### SteamCMD [UPDATING]"
echo -n "STEAMCMD_UPDATING" > $state_file
$steamcmd_path +app_update +quit
# GET CREDS
if [ -z "$STEAM_USER" ]; then
    STEAM_USER='anonymous'
    STEAM_PASSWORD=''
fi

# GAME SERVER
echo "> STEAM GAME SERVER ID [$STEAMID]"
echo "###### Server [UPDATE CHECK]"

#$steamcmd +login +app_info_update 1 +app_info_print $STEAMID +quit
#$steamcmd +force_install_dir /home/steam/steamcmd/data +login $STEAM_USER $STEAM_PASSWORD +app_update $STEAMID +quit

update_output=$(steamcmd +login $STEAM_USER $STEAM_PASSWORD +app_info_update 1 +app_info_print $STEAMID +quit)
if echo "$update_output" | grep -q '"up_to_date" : false'; then
    echo "###### Server [UPDATE REQUIRED]"
    echo -n "GAME_SERVER_UPDATING" > $state_file
    $steamcmd +login $STEAM_USER $STEAM_PASSWORD +force_install_dir $INSTALL_DIR +app_update $STEAMID validate +quit
fi
echo "###### Server [UP TO DATE]"
echo -n "READY" > $state_file