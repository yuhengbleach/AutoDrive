#!/bin/sh

setup_can() {
echo "configure $1 for esr"
    sudo ifconfig $1 down
    sudo ip link set $1 type can bitrate 500000
    sudo ip link set up $1
}
setup_can $1 
