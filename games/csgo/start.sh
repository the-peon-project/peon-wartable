#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
echo "################## WAITING FOR SERVER FILES ##################"
timeout=0
while [ -z $(grep -P  "Success! App .* fully installed." /var/log/peon/update.sh.log) ]; do
    ((timeout++))
    printf "."
    sleep 1
    if (( $timeout >= 1200 )); then 
        printf "\nThe start script timedout after 10 minutes."
        exit 124
    fi
done
printf "\nUpdate took $timeout seconds.\n"
echo "############### SERVER FILES AVAILABLE READY ################"
printf "\nStarting game server."
data/srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount $STEAM_APP_ID
echo "RUNNING" > ./data/server.state