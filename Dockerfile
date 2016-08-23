# A simple minecraft server!

FROM debian

MAINTAINER j842

RUN apt-get update && \
      apt-get -y install openjdk-7-jre-headless wget && \
      rm -rf /var/lib/apt/lists/*

COPY ["./buildaux","/buildaux"]
COPY ["./drunner","/drunner"]

RUN groupadd -g 22922 drgroup \
    && adduser --disabled-password --gecos '' -u 22922 --gid 22922 druser
RUN /bin/bash /buildaux/download.sh
RUN /bin/bash /buildaux/createlaunchscript.sh
RUN chmod a-w -R /drunner

EXPOSE 25565

# lock in druser.
USER druser
