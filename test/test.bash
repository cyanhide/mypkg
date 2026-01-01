#!/bin/bash
dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws" || exit 1

colcon build
source install/setup.bash

# publisher をバックグラウンドで起動
ros2 run mypkg system_publisher &
PUB_PID=$!

# listener をフォアグラウンドで起動して stdout をリアルタイム監視
found=0
ros2 run mypkg system_listener 2>&1 | while read -r line; do
    echo "$line"
    if [[ "$line" == *CPU:* ]]; then
        found=1
        break
    fi
done

# ノードを kill
kill $PUB_PID 2>/dev/null

if [ $found -eq 1 ]; then
    echo "Test passed: CPU/Memory output found."
    exit 0
else
    echo "Test failed: CPU/Memory output not found."
    exit 1
fi

