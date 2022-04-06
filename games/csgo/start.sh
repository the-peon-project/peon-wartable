#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
# Handle parameters
if [ $# -eq 0 ]; then
    echo "Steam App ID required. e.g. > ./${0##*/} 12345"
    echo "Script was run without a steam App ID" >>$logfile
    exit 1
else
    steam_app_id=$1
fi
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
printf "Waiting for update to complete\n"
timeout=0
while [[ $(cat data/server.state) != "READY" ]]; do
    ((timeout++))
    printf "."
    sleep 1
    if (( $timeout >= 600 )); then 
        printf "\nThe update script did not complete within 10 minutes."
        exit 124
    fi
done
printf "\nUpdate took $timeout seconds.\n"
printf "Starting game server."
data/srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount $steam_app_id &
