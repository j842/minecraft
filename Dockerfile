# A simple hello world example!

FROM debian:wheezy

MAINTAINER j842

RUN apt-get update 
RUN apt-get -y install openjdk-7-jre-headless wget
RUN wget -q https://s3.amazonaws.com/Minecraft.Download/versions/1.8.7/minecraft_server.1.8.7.jar

RUN groupadd -g 22922 drgroup
RUN adduser --disabled-password --gecos '' -u 22922 --gid 22922 druser

# copy in the assets.
COPY ["./drunner","/drunner"]
RUN chmod a-w -R /drunner && chmod a+r /minecraft*

EXPOSE 25565

# lock in druser.
USER druser
