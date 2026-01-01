#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class SystemListener(Node):
    def __init__(self):
        super().__init__('system_listener')
        self.subscription = self.create_subscription(
            String,
            'system_status',
            self.listener_callback,
            10
        )

    def listener_callback(self, msg):
        self.get_logger().info(msg.data)

def main():
    rclpy.init()
    node = SystemListener()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

