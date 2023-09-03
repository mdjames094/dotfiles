#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR/remarkable/pipes-and-rust

./install.sh

/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=brave --file-forwarding com.brave.Browser --incognito 192.168.1.14:400 >/dev/null 2>&1 &

