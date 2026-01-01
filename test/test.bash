#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

set -e

# ワークスペース
WS_DIR="$HOME/ros2_ws"

cd "$WS_DIR"

# ビルド
colcon build
source install/setup.bash

# ログ初期化
LOG=/tmp/mypkg.log
rm -f "$LOG"

# launch 実行（バックグラウンド）
timeout 20 ros2 launch mypkg system_monitor.launch.py > "$LOG" 2>&1 &
LAUNCH_PID=$!

# ノード起動待ち（最大10秒）
for i in {1..10}; do
    # ノード一覧を取得
    if ros2 node list | grep -q system_; then
        echo "Test passed: ROS2 nodes are running."
        kill $LAUNCH_PID 2>/dev/null || true
        exit 0
    fi
    sleep 1
done

echo "Test failed: ROS2 nodes did not start."
echo "==== /tmp/mypkg.log ===="
cat "$LOG"
exit 1
