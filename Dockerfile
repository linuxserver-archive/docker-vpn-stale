FROM lsiobase/alpine
MAINTAINER loadofpeopleatlinuxserver.io

# install packages
RUN \
 apk add --no-cache \
	curl \
	openvpn

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
