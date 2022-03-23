#!/bin/bash
export LD_LIBRARY_PATH=/home/steam/steamcmd/data:/home/steam/steamcmd/data/bin

# https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Docker

# srcds -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +sv_setsteamaccount [STEAM_APP_ID http://steamcommunity.com/dev/managegameservers]