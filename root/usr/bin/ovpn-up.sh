#!/bin/sh
DEV=$1
TUN_MTU=$2
LINK_MTU=$3
LOCAL_IP=$4
REMOTE_IP=$5

/usr/bin/fw-stop.sh
