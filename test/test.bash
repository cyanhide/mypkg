#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws || exit 1

# ビルド
colcon build
source install/setup.bash

# system_monitor.launch.py を 20秒間起動してログを /tmp/mypkg.log に保存
timeout 20 ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &

# 少し待ってからログを確認
sleep 2

# CPU/メモリ情報が出力されているか確認
grep 'CPU:' /tmp/mypkg.log >/dev/null
if [ $? -eq 0 ]; then
    echo "Test passed: CPU/Memory output found."
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

