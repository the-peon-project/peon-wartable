# SteamCMD [SteamCMD]

[![Docker Pulls](https://img.shields.io/docker/pulls/umlatt/steamcmd.svg)](https://hub.docker.com/r/umlatt/steamcmd)
[![Docker Stars](https://img.shields.io/docker/stars/umlatt/steamcmd.svg)](https://hub.docker.com/r/umlatt/steamcmd)

## The Easy Game Server Manager

### Installation

> This can be deployed as a stand-alone container to run windows steam game servers. *Not yet tested in stand-alone mode (working as part of [Peon Project](https://github.com/the-peon-project/peon))
> Alternatively, this is based on [cm2network's steamcmd](https://hub.docker.com/r/cm2network/steamcmd) image.

### [Peon Project](https://github.com/the-peon-project/peon)

An **OpenSource** project to assist gamers in self-deploying/managing game servers.\
Intended to be a one-stop-shop for game server deployment/management.\
If run on a public/paid cloud, it is architected to try to minimise costs (easy schedule/manage uptime vs downtime)\

### Peon SteamCMD

The [github](https://github.com/the-peon-project/peon-wartable/tree/master/containers/steamcmd) repo for developing the container.

## State

> **INITIAL RELEASE**

Functionilty working as required (tested with VRising windows steam server)

## Version Info

Check [changelog](https://github.com/the-peon-project/peon-wartable/blob/master/containers/steamcmd/changelog.md) for more information

- Deployed with ``cm2network/steamcmd`` as a base image

### Known Bugs

*N/A*

### Architecture/Rules

Source container provided by [Valve SteamCMD - Docker](https://developer.valvesoftware.com/wiki/SteamCMD#Docker)

### Notes

This image should track close to the orginal source image. All that is being changed is the addition of a runtime script.

## Support the Project

PEON is an open-source project that I am working on in my spare time (for fun).
However, if you still wish to say thanks, feel free to pick up a virtual coffee for me at Ko-fi.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/K3K567ILJ)
