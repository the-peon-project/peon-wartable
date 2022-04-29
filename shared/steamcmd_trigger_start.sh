#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
rootpath="/home/steam/steamcmd"
cd $rootpath
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
echo "################## WAITING FOR SERVER FILES ##################"
echo -n "INITIALIZING" > ./data/server.state
sleep 2 # Allow server update script to clean its log
timeout=0
tracked_log="/var/log/peon/steamcmd_server_update.sh.log"
string_01="Success! App .* fully installed."
string_02="Success! App .* already up to date."
while [ -z $(grep -P  "$string_01" $tracked_log) ] && [ -z $(grep -P  "$string_02" $tracked_log) ]; do
    ((timeout++))
    printf "."
    sleep 1
    if (( $timeout >= 1800 )); then 
        printf "\n! Timeout after 30 minutes, waiting for the install/update to complete.\n*"
        echo -n "UPDATE TIMEOUT" > ./data/server.state
        exit 124
    fi
done
printf "\nUpdate took $timeout seconds.\n"
echo "############### SERVER FILES AVAILABLE READY ################"
printf "\nStarting game server.\n"
echo -n "STARTED" > ./data/server.state
./peon/unique/server_start.sh
echo "##################### SERVER STARTING #######################"
