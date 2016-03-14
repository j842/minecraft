# A simple hello world example!

FROM debian:wheezy

MAINTAINER j842

RUN apt-get update
RUN apt-get -y install openjdk-7-jre-headless wget

RUN groupadd -g 22922 drgroup \
    && adduser --disabled-password --gecos '' -u 22922 --gid 22922 druser \
    && mkdir /minecraft \
    && cd /minecraft \
    && wget -q https://s3.amazonaws.com/Minecraft.Download/versions/1.9/minecraft_server.1.9.jar \
    && chown -R druser:drgroup /minecraft

# copy in the assets.
COPY ["./drunner","/drunner"]

RUN chmod a-w -R /drunner && chmod a+r /minecraft*  \
    && echo "#!/bin/bash\ncd /minecraft ; java -jar minecraft_server.1.9.jar" >> /usr/local/bin/runminecraft.sh \
    && chmod a+rx /usr/local/bin/runminecraft.sh \
    && echo "eula=true" > /minecraft/eula.txt && chmod a+r /minecraft/eula.txt

EXPOSE 25565

# lock in druser.
USER druser
