#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws || exit 1


colcon build
source install/setup.bash


ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &
PID=$!


timeout=20
count=0
found=0

while [ $count -lt $timeout ]; do
    if grep -q 'CPU:' /tmp/mypkg.log; then
        found=1
        break
    fi
    sleep 1
    count=$((count + 1))
done


kill $PID 2>/dev/null


if [ $found -eq 1 ]; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

