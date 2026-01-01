#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

set -e

# このスクリプトの場所を基準にする
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# src/mypkg/test/test.bash → src/mypkg → src → ros2_ws
WS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Using workspace: $WS_DIR"
cd "$WS_DIR"

# ビルド
colcon build
source install/setup.bash

# launch 実行（バックグラウンド）
timeout 20 ros2 launch mypkg system_monitor.launch.py &
LAUNCH_PID=$!

# ノード起動待ち（最大10秒）
for i in {1..10}; do
    if ros2 node list | grep -q system_; then
        echo "Test passed: ROS2 nodes are running."
        kill $LAUNCH_PID 2>/dev/null || true
        exit 0
    fi
    sleep 1
done

echo "Test failed: ROS2 nodes did not start."
ros2 node list || true
exit 1
