#!/bin/bash
rosrun av_sensor_esr can_configure.sh can4
rosrun av_sensor_rsds set_up.sh
sudo route add -net 192.168.0.0 netmask 255.255.255.0 dev eth0
sudo route add default dev eth0
sudo route add -net 192.168.3.0 netmask 255.255.255.0 dev eth0
rosrun av_core cansend.sh
