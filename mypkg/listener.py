#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String


class Listener(Node):
    def __init__(self):
        super().__init__('listener')
        self.create_subscription(
            String,
            'nabeatsu',
            self.cb,
            10
        )

    def cb(self, msg):
        # 受信した文字列をそのまま表示
        self.get_logger().info(msg.data)


def main():
    rclpy.init()
    node = Listener()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

