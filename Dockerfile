# A simple minecraft server!

FROM debian

MAINTAINER j842

RUN apt-get update && \
      apt-get -y install openjdk-7-jre-headless wget && \
      rm -rf /var/lib/apt/lists/*

RUN groupadd -g 22922 drgroup \
    && adduser --disabled-password --gecos '' -u 22922 --gid 22922 druser \
    && mkdir /minecraft \
    && cd /minecraft \
    && wget -q https://s3.amazonaws.com/Minecraft.Download/versions/1.9.2/minecraft_server.1.9.2.jar \
    && chown -R druser:drgroup /minecraft

# copy in the assets.
COPY ["./drunner","/drunner"]

RUN chmod a-w -R /drunner && chmod a+r /minecraft*  \
    && echo "#!/bin/bash\ncd /minecraft/data\necho "eula=true" > eula.txt\njava -Xms1G -Xmx1G -jar /minecraft/minecraft_server.1.9.jar nogui" >> /usr/local/bin/runminecraft.sh \
    && chmod a+rx /usr/local/bin/runminecraft.sh

EXPOSE 25565

# lock in druser.
USER druser
