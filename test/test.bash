#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir="$HOME"
[ -n "$1" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

colcon build
source install/setup.bash

timeout 20 ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &

for i in {1..15}; do
    if grep 'CPU:' /tmp/mypkg.log >/dev/null; then
        echo "Test passed: CPU output found."
        exit 0
    fi
    sleep 1
done

echo "Test failed: CPU output not found."
echo "==== LOG ===="
cat /tmp/mypkg.log
exit 1
