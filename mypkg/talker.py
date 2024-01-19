#SPDX-FileCopyrightText: 2023 Hidenori Koseki
#SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16

class Talker():
    def __init__(self, nh):
        self.pub = nh.create_publisher(Int16,"countup", 10)
        self.n = 0
        nh.create_timer(0.5, self.cb)

    def cb(self):
        msg = Int16()
        msg.data = self.n
        self.pub.publish(msg)        
        self.n += 1

def main():
    rclpy.init()
    node = Node("talker")
    talker = Talker(node)
    rclpy.spin(node)


