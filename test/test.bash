#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir="$HOME"
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

colcon build
source install/setup.bash

timeout 20 ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &

sleep 2

grep 'CPU:' /tmp/mypkg.log >/dev/null
if [ $? -eq 0 ]; then
    echo "Test passed: CPU/Memory output found."
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi
