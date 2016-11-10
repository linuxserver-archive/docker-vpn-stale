FROM lsiobase/alpine
MAINTAINER j0nnymoe

# copy local files
COPY root/ /

# install packages and set exec flag
RUN \
 apk add --no-cache \
	curl \
	iptables \
	openvpn && \
 chmod +x /usr/bin/*.sh

# ports and volumes
VOLUME /config
