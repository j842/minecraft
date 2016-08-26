# drunner/minecraft

A simple Minecraft server dService.

Pauses server on backup/restore. All data and configuration in backup. Can run multiple servers on
a host just by using different ports. :-)

This is a version 2 dService, so requires the C++ version of dRunner.

See also drunner/minecraftviewer for providing the minecraft map via a webpage.

## Use

```
drunner install drunner/minecraft
minecraft configure port=25565
minecraft start
```

## Help

```
NAME
   ${SERVICENAME} - Runs minecraft
       
SYNOPSIS
   ${SERVICENAME} help            - This help
   ${SERVICENAME} configure PORT  - Configure for port PORT
   ${SERVICENAME} start           - Make it go!
   ${SERVICENAME} stop            - Stop it
   ${SERVICENAME} info            - Is it running?
   
   ${SERVICENAME} export PATH     - export world and config to PATH
   ${SERVICENAME} import PATH     - import world and config from PATH
   
DESCRIPTION
   Built from ${IMAGENAME}.   
```
