# A simple hello world example!

FROM kitematic/minecraft

MAINTAINER j842

RUN apt-get update && apt-get -y install sudo

RUN groupadd -g 22922 drgroup
RUN adduser --disabled-password --gecos '' -u 22922 --gid 22922 druser
RUN adduser druser sudo

# TODO: Lock down sudoers so we can only run a start up script!

# add in the assets.
ADD ["./drunner","/drunner"]
#ADD ["./usrlocalbin","/usr/local/bin"]
RUN chmod a+rx -R /usr/local/bin  &&  chmod a-w -R /drunner && chmod a+r /minecraft*

# lock in druser.
USER druser

# expose volume
VOLUME /config /data

