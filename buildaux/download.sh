#!/bin/bash
# read in VERSION variable.
source /buildaux/version.sh
SCRIPTPATH="/usr/local/bin/runminecraft.sh"

# download minecraft server jar
mkdir /minecraft
cd /minecraft
wget -q "https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar"
chown -R druser:drgroup /minecraft
#chmod a+r /minecraft/*

# write out script to start minecraft.
tee ${SCRIPTPATH} <<EOF
#!/bin/bash
cd /minecraft/data
echo "eula=true" > eula.txt
echo java "-Xms${XMS}" "-Xmx${XMX}" -jar "/minecraft/minecraft_server.${VERSION}.jar" nogui
java "-Xms${XMS}" "-Xmx${XMX}" -jar "/minecraft/minecraft_server.${VERSION}.jar" nogui
EOF

chmod a+rx ${SCRIPTPATH}
