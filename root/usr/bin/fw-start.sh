#!/bin/bash

if [[ $FORCEVPN ]]; then
    echo "Stopping firewall and restarting it with blocked output"
    ipt="/sbin/iptables"
    ## Failsafe - die if /sbin/iptables not found
    [ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."; exit 1; }
    iptables-restore /config/fw.save
    $ipt -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
    $ipt -A OUTPUT -o lo -j ACCEPT
    $ipt -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
    echo "Finished initializing iptables"
    echo "Now check if any ports should be opened"
    if [[ $VPNPORTS ]]; then
        for PORT in $(echo $VPNPORTS | sed "s/,/ /g")
        do
            $ipt -A OUTPUT -p tcp --dport $PORT -j ACCEPT
            $ipt -A OUTPUT -p udp --dport $PORT -j ACCEPT
            echo "Open port $PORT for outgoing traffic"
        done
    fi
fi

