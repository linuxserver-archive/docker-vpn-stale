#!/usr/bin/with-contenv bash

if [[ $FORCEVPN ]]; then
    ipt="/sbin/iptables"
    ## Failsafe - die if /sbin/iptables not found
    [ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."; exit 1; }

    #Start by restoring the rules saved at startup
    iptables-restore /config/fw.save

    #Allow icmp output and allow responses from outside
    $ipt -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
    $ipt -A OUTPUT -o lo -j ACCEPT
    $ipt -A OUTPUT -m state --state ESTABLISHED -j ACCEPT

    #Open up the ports specified by the user
    if [[ $VPNPORTS ]]; then
        for PORT in $(echo $VPNPORTS | sed "s/,/ /g")
        do
            $ipt -A OUTPUT -p tcp --dport $PORT -j ACCEPT
            $ipt -A OUTPUT -p udp --dport $PORT -j ACCEPT
        done
    fi

    #Open up output to the default gateway
    GW=`route -n | awk '{if($4=="UG")print $2}'`
    $ipt -A OUTPUT -d $GW -j ACCEPT

    #Finally drop any outbound traffic not matching above rules
    $ipt -A OUTPUT -j DROP
fi

