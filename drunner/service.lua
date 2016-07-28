-- drunner service configuration for helloworld

function drunner_setup()
-- addconfig(NAME, DESCRIPTION, DEFAULT VALUE, TYPE, REQUIRED)
   addconfig("PORT","The port to run minecraft on.","25565","port",true)

-- addvolume(NAME, BACKUP, EXTERNAL)

-- addcontainer(NAME)
   addcontainer("drunner/minecraft")  -- First one must always be this container.
end


-- everything past here are functions that can be run from the commandline,
-- e.g. helloworld run

function start()
  result=drun("docker run -d -p ${PORT}:25565 -p ${PORT}:25565/udp "..
  "-v drunner-${SERVICENAME}-minecraftdata:/minecraft/data " ..
  "--restart=always --name drunner-${SERVICENAME}-minecraft " ..
  "drunner/minecraft /usr/local/bin/runminecraft.sh")

  if result~=0 then
     print("Failed to start minecraft.")
   end
end

function stop()
  dstop("drunner-${SERVICENAME}-minecraft")
end

function obliterate_start()
   stop()
end

function uninstall_start()
   stop()
end

function backup_start()
   drun("docker pause drunner-${SERVICENAME}-minecraft")
end

function backup_end()
   drun("docker resume drunner-${SERVICENAME}-minecraft")
end

function help()
   return [[
   NAME
      ${SERVICENAME} - Runs minecraft

   SYNOPSIS
      ${SERVICENAME} help             - This help
      ${SERVICENAME} configure [PORT] - Show configuration, or set PORT
      ${SERVICENAME} start            - Make it go!
      ${SERVICENAME} stop             - Stop it

   DESCRIPTION
      Built from ${IMAGENAME}.
   ]]
end
