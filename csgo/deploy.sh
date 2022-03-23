#!/bin/bash
# Get script name for logging
rootpath=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Get parameters
PARAMS=""
overwrite=false
while (( "$#" )); do
  case "$1" in
    -g|--game)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        game=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -n|--server-name)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        servername=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -o|--overwrite)
      overwrite=true
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ -z ${game+x} ] || [ -z ${servername+x} ] ; then 
    echo "Not all parameters were passed."
    exit
fi
# Logging config start - Create logfile and capture all stdout to it
log_file_path=/var/log/peon/$game/$servername
mkdir -p $log_file_path
logfile="$log_file_path/${0##*/}.log"
chown -R 1000:1000 $log_file_path
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
mkdir -p /var/log/peon/$game/$servername
chmod +x run_steamcmd.sh
server_path="$PWD/$servername"
container="peon.warcamp.$game.$servername"
containers=`docker ps -a | grep -i $container`
chown -R 1000:1000 .
if [ "$containers" ] && $overwrite ; then
    echo "Container exists, but overwrite configured. Removing containers before proceeding."
    docker stop $container 
    docker rm $container
    rm -rf $server_path/server.state
fi
containers=`docker ps -a | grep -i $container`
if [ -z "$containers" ]; then
    echo "Creating data paths: [$server_path]"
    mkdir -p $server_path
    ehco "DEPLOYING CONTAINERS" > $server_path/server.state
    chown -R 1000:1000 $server_path
    echo "Starting container/s..."
    docker run -dit -v $server_path:/home/steam/steamcmd/data -v /var/log/peon/$game/$servername:/var/log/peon --name $container --user steam cm2network/steamcmd
    echo "Adding deploy code to container."
    docker cp run_steamcmd.sh $container:/home/steam/steamcmd/.
    echo "Run 'run_steamcmd.sh in container.'"
    docker exec -d --workdir /home/steam/steamcmd --user steam $container bash run_steamcmd.sh
else
    echo "Container already exists. Exiting."
fi
echo "Script comeplete."

# Docker container recommmended in - https://developer.valvesoftware.com/wiki/SteamCMD#Docker