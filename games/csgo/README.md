# Peon Recipe - Counterstrike Source : Global Offensive

The battle plan that your Peon uses to deploy your game server.

## Source

[CSGO Docker Deployment Guide](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Docker)

## Settings

> TODO - Add simple description of all server settings

### Game Server Login Token (GSLT)

If you wish to run this server outside of your private network (required by Steam for any servers running outside of your home LAN), you will need to get a game server login token.\
[Registering Game Server Login Token](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Registering_Game_Server_Login_Token)

### [Advanced Server Settings](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers)

- If you wish to customise the default servers, log into your server (running Peon) and run ``peon_connect``.
- Alternatively, you should be able to edit the server files in the data directory of the server (e.g. ``./peon/servers/[game_uid]/[server_name]/``)
- Logging can be found in ``/var/log/peon/[game_uid].[server_name]``, if required.
