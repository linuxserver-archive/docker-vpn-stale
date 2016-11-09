#!/usr/bin/with-contenv bash

if [[ $FORCEVPN ]]; then
    iptables-restore /config/fw.save
fi
