#!/bin/bash

CURRENT_PATH=`dirname $(readlink -f $0)`

catkin_make --source ${CURRENT_PATH}
