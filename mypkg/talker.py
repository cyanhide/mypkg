#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String


class Talker(Node):
    def __init__(self):
        super().__init__('talker')
        self.pub = self.create_publisher(String, 'nabeatsu', 10)
        self.n = 0
        self.create_timer(0.5, self.cb)

    def cb(self):
        if self.n != 0 and (self.n % 3 == 0 or '3' in str(self.n)):
            text = f"!!!! {self.n} !!!!"
        else:
            text = str(self.n)

        msg = String()
        msg.data = text
        self.pub.publish(msg)

        self.n += 1


def main():
    rclpy.init()
    node = Talker()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

