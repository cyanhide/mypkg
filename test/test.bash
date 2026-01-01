#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws || exit 1

colcon build
source install/setup.bash

# system_monitor.launch.py をフォアグラウンドで起動してログに書き込む
ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &
PID=$!

# ログが書き込まれるまで最大20秒待機
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

