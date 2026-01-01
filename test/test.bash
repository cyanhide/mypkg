#!/bin/bash
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

# ビルドと環境セット
colcon build
source install/setup.bash

# system_publisher をバックグラウンドで起動
ros2 run mypkg system_publisher &
PUB_PID=$!

# system_listener をバックグラウンドで起動し、ログファイルに書き込む
ros2 run mypkg system_listener 2>&1 | tee /tmp/mypkg.log &
LIST_PID=$!

# 最大30秒まで CPU/Memory 出力を待つ
found=0
for i in $(seq 1 30); do
    if grep -q 'CPU:' /tmp/mypkg.log; then
        found=1
        break
    fi
    sleep 1
done

# 起動したノードを終了
kill $PUB_PID $LIST_PID 2>/dev/null

if [ $found -eq 1 ]; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

