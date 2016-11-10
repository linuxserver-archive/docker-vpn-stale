#!/usr/bin/with-contenv bash
DEV=$1
TUN_MTU=$2
LINK_MTU=$3
LOCAL_IP=$4
REMOTE_IP=$5

/usr/bin/fw-start.sh

if [[ $FORCEVPN && -x /config/down.sh ]]; then
    /config/down.sh $1 $2 $3 $4 $5
fi
