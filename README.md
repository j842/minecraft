# drunner-minecraft

A simple dRunner compatible Minecraft container. Based on Kitematic/Minecraft.

Pauses server on backup/restore. All data and configuration in backup. Can run multiple servers on
a host just by using different ports. :-)

## Use

```
drunner install drunner/minecraft
minecraft configure 25565
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
   ${SERVICENAME} status          - Is it running?
   
   ${SERVICENAME} export PATH     - export world and config to PATH
   ${SERVICENAME} import PATH     - import world and config from PATH
   
DESCRIPTION
   Built from ${IMAGENAME}.   
```