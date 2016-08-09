FROM lsiobase/alpine
MAINTAINER j0nnymoe

# install packages
RUN \
 apk add --no-cache \
	curl \
	openvpn

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
