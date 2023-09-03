#!/bin/bash

echo "rMk --------------------"

IP=$(arp -a | grep "20:50:e7:d8:b4:8e" | awk -F'[()]' '{print $2}')
if [ -z "$IP" ]
then
        echo -e "    ip not found"
        exit 1
fi
echo -e "    found @${IP}"

ping -c 1 $IP > /dev/null
if [ $? -eq 0 ]
then
        echo -e "    unreachable (ping)"
        exit 1
fi
echo -e "    reachable (ping)"

STR="192\.168\."

file="/home/$USER/.ssh/config"
sed -i -e "s/.*${STR}.*/Hostname ${IP}/I" $file && echo -e "    $file Ok"

file="/home/$USER/.config/rmview/rmview.json"
sed -i -e "s/.*${STR}.*/\t\"address\" \: \"${IP}\",/I" $file && echo -e "    $file Ok"

file="/home/$USER/.config/remy/config.json"
sed -i -e "s/.*${STR}.*/\t\t\"host\" \: \"${IP}\",/I" $file && echo -e "    $file Ok"

echo "------------------------"
