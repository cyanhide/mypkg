#!/bin/bash
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

# ビルドと環境セット
colcon build
source /opt/ros/foxy/setup.bash   # システム ROS2
source install/setup.bash          # ワークスペース ROS2

# publisher をバックグラウンドで起動
ros2 run mypkg system_publisher &
PUB_PID=$!

# listener をフォアグラウンドで stdout を監視
found=0
ros2 run mypkg system_listener 2>&1 | while read -r line; do
    echo "$line"
    if [[ "$line" == *CPU:* ]]; then
        found=1
        break
    fi
done

# publisher ノードを終了
kill $PUB_PID 2>/dev/null

# 判定
if [ $found -eq 1 ]; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

