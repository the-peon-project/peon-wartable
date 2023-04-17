state_file="/root/peon/config/server.state"
echo -n "ERROR [BAD PLAN]" > $state_file
echo "ERROR - No valid `/init/start_server.sh` provided."
echo "Please make sure that the recipe provides the script that will start the server services, and that this in mounted into the container as `/init/start_server.sh`"