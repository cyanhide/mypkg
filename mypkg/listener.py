#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16


def cb(msg):
    global node
    n = msg.data


    if n != 0 and (n % 3 == 0 or '3' in str(n)):
        node.get_logger().info(f" Listen:!!!! {n}!!!!")
    else:
        node.get_logger().info(f"Listen: {n}")


rclpy.init()
node = Node("listener")
sub = node.create_subscription(Int16, "countup", cb, 10)
rclpy.spin(node)
