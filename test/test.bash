#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws || exit 1

colcon build
source install/setup.bash

# launch をバックグラウンドで起動
ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &
PID=$!

# 最大20秒までログに "CPU:" が出るまで待つ
for i in $(seq 1 20); do
    if grep -q 'CPU:' /tmp/mypkg.log; then
        echo "Test passed: CPU/Memory output found."
        kill $PID
        exit 0
    fi
    sleep 1
done

kill $PID 2>/dev/null
echo "Test failed: CPU/Memory output not found."
exit 1


