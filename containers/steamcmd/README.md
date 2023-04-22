# Contained Steam [SteamCMD]

[![Docker Pulls](https://img.shields.io/docker/pulls/umlatt/steamcmd.svg)](https://hub.docker.com/r/umlatt/steamcmd)
[![Docker Stars](https://img.shields.io/docker/stars/umlatt/steamcmd.svg)](https://hub.docker.com/r/umlatt/steamcmd)

## Peon SteamCMD

The [github](https://github.com/the-peon-project/peon-wartable/tree/master/containers/steamcmd) repo for developing the container.

## State

> **RELEASE**

Functionality working as required (tested with VRising windows steam server)

## Version Info

Check [changelog](http://docs.warcamp.org/development/02_wartable/#contained-steam) for more information

- Deployed with ``cm2network/steamcmd`` as a base image
- Added generic functions to allow the easy creation of recipes to deploy servers.

### Architecture/Rules

This is a base image for certain game servers that are not Linux native. ``Use default [cm2network/steamcmd] if Windows is not required (waaaaaaay more efficient))``

Source container provided by [Valve SteamCMD - Docker](https://developer.valvesoftware.com/wiki/SteamCMD#Docker)

## Installation

### Automated mode

This container has been built as part of [the PEON project](http://docs.warcamp.org). The intention is to make deploying servers accessible to non-programmer container-skilled persons. It would be great if you'd be willing to test the PEON project and provide feedback. Go [here](http://docs.warcamp.org/guides/#peon-deployment) to get started.

### Stand-alone mode

Please just go to the [Github for *The PEON Projects* game servers](https://github.com/the-peon-project/peon-warplans) and get the contents of the appropriate game (or clone a game folder and use it as the basis for your own build).

#### Example

Running a `Counter Strike: Global Offensive` server

1. Download the following files from the PEON recipes [github location](https://github.com/the-peon-project/peon-warplans/tree/main/csgo)
    - .env.example
    - docker-compose.yml
    - server_start
2. Rename `.env.example` to `.env`
3. Change the settings in `.env` to your desired server settings
4. Make sure that `server_start` is owned by the docker user and is executable `chown 1000:1000 server_start && chmod u+x server_start`
5. Run `docker-compose up -d` or `docker compose up -d` (depending on your distribution).
6. Get your container name or container id. Run `docker ps` and identify which container was just started,
7. You can follow the installation/deployment of the files with `docker logs --follow [container_name]. It should process all the way through to where you see the game server running and producing logs. From here you should be able to connect and join your game.

The installation will take several minutes, depending on your connection, as this image is designed to handle as many game servers as possible, so we do not pre-stage any one game's data files (however, once downloaded, you can copy the files in `./data` to the `./data` of another directory if you want to spin up a second server).

#### Docker Run

> This **can** be deployed as a stand-alone container to run Steam game server, without the PEON integration. However, it is probably more prudent to rather use the image `cm2network/steamcmd`. 
> If you still in insist on using this one, then please see below.

```bash
# Start server
docker run -dit --entrypoint /bin/bash --name containedsteam -p [gameport_01]:[gameport_01] umlatt/steamcmd:latest
# Access container
docker exec -it containedsteam bash
```

### [Peon Project](http://docs.warcamp.org)

An **OpenSource** project to assist gamers in self-deploying/managing game servers.\
Intended to be a one-stop-shop for game server deployment/management.\
If run on a public/paid cloud, it is architected to try to minimise costs (easy schedule/manage uptime vs downtime)\

## Support the Project

PEON is an open-source project that I am working on in my spare time (for fun).
However, if you still wish to say thanks, please pick up a virtual coffee for me at Ko-fi.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K567ILJ)