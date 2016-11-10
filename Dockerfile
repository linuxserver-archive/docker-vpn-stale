FROM lsiobase/alpine
MAINTAINER j0nnymoe

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

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
