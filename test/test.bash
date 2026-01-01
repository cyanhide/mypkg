#!/bin/bash
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

# ビルドと環境セット
colcon build
source install/setup.bash

# system_monitor.launch.py をバックグラウンドで起動
# tee で即座にログファイルに書き込む
ros2 launch mypkg system_monitor.launch.py 2>&1 | tee /tmp/mypkg.log &
PID=$!

# 最大30秒まで CPU/Memory 出力を待つ
found=0
for i in $(seq 1 30); do
    if grep -q 'CPU:' /tmp/mypkg.log; then
        found=1
        break
    fi
    sleep 1
done

# 起動した launch プロセスを終了
kill $PID 2>/dev/null

if [ $found -eq 1 ]; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

