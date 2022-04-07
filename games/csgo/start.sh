#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
echo "################## WAITING FOR SERVER FILES ##################"
timeout=0
tracked_log="/var/log/peon/update.sh.log"
string_01="Success! App .* fully installed."
string_02="Success! App .* already up to date."
while [ -z $(grep -P  "$string_01" $tracked_log) ] && [ -z $(grep -P  "$string_02" $tracked_log) ]; do
    ((timeout++))
    printf "."
    sleep 1
    if (( $timeout >= 1800 )); then 
        printf "\n! Timeout after 30 minutes, waiting for the install/update to complete.\n*"
        echo "UPDATE TIMEOUT" > ./data/server.state
        exit 124
    fi
done
printf "\nUpdate took $timeout seconds.\n"
echo "############### SERVER FILES AVAILABLE READY ################"
printf "\nStarting game server."
data/srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount $STEAM_APP_ID
echo "RUNNING" > ./data/server.state