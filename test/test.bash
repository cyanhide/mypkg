#!/bin/bash
# SPDX-FileCopyrightText: Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

# 作業ディレクトリ（引数があればそれを使う）
dir="$HOME"
[ -n "$1" ] && dir="$1"

# ワークスペースへ移動
cd "$dir/ros2_ws" || exit 1

# ビルド
colcon build
source install/setup.bash

# launch をバックグラウンドで起動し、ログを保存
timeout 20 ros2 launch mypkg system_monitor.launch.py > /tmp/mypkg.log 2>&1 &

# CPU 出力が現れるまで最大10秒待つ
for i in {1..10}; do
    if grep 'CPU:' /tmp/mypkg.log >/dev/null; then
        echo "Test passed: CPU/Memory output found."
        exit 0
    fi
    sleep 1
done

# 10秒待っても出なかった場合
echo "Test failed: CPU/Memory output not found."
exit 1
