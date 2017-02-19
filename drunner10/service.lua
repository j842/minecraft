-- drunner 1.0 service definition for minecraft

-- addconfig( VARIABLENAME, DEFAULTVALUE, DESCRIPTION )
addconfig("PORT","25565","The port to run minecraft on.")
addconfig("XMS","1G","Initial memory allocation")
addconfig("XMX","2G","Maximum memory allocation")

datavol = "drunner-${SERVICENAME}-minecraftdata"
containername = "drunner-${SERVICENAME}-minecraft"

-- source for this image is in the docker folder.
imagename = "j842/minecraft"

function start()
   print(dsub("Launching minecraft with ${XMS} memory (${XMX} max)"))

   if (drunning(containername)) then
      print("Minecraft is already running.")
   else
      result=docker("run", "-d",
      "-p", "${PORT}:25565",
      "-p", "${PORT}:25565/udp",
      "-v", datavol .. ":/minecraft/data",
      "-e", "XMS",
      "-e", "XMX",
      "--restart=always",
      "--name", containername,
      imagename,
      "/usr/local/bin/runminecraft.sh")

      if result~=0 then
        print("Failed to start minecraft.")
      end
   end
end

function stop()
  dockerstop(containername)
end

function obliterate()
   stop()
end

function uninstall()
   stop()
end

function update()
   stop()
   dockerpull(imagename)
   start()
end

function backup()
   docker("pause",containername)
   dockerbackup(datavol)
   docker("unpause",containername)
end

function info()
   if (drunning(containername)) then
      print(dsub("Minecraft is running on port ${PORT}."))
   else
      print("Minecraft is not currently running.")
   end
end

function enter()
   os_exec("docker exec -ti "..containername.." /bin/bash")
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
