#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws"

# ビルド
colcon build

# ROS2 環境を source
source /opt/ros/foxy/setup.bash
source install/setup.bash

# Launchを実行してログをファイルに保存（最大20秒でタイムアウト）
timeout 20 ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1

# ログに CPU 出力があるかチェック
if grep -q 'CPU:' /tmp/mypkg.log; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    cat /tmp/mypkg.log
    exit 1
fi

