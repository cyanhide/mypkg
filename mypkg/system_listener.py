#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import psutil

class SystemListener(Node):
    def __init__(self):
        super().__init__('system_listener')
        # Publisher から送られるメッセージを購読
        self.subscription = self.create_subscription(
            String,
            'system_status',
            self.listener_callback,
            10
        )
        self.subscription  # unused variable suppression

    def listener_callback(self, msg):
        # CPU 使用率とメモリ使用率を出力
        cpu = psutil.cpu_percent()
        mem = psutil.virtual_memory().percent
        # flush=True でログを即座にファイルに書き込む
        print(f"CPU: {cpu:.1f}%, MEM: {mem:.1f}%", flush=True)
        # ROS のログとしても出力（任意）
        self.get_logger().info(f"CPU: {cpu:.1f}%, MEM: {mem:.1f}%")

def main(args=None):
    rclpy.init(args=args)
    node = SystemListener()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()

