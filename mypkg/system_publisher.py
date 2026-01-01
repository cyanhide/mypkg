#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 Hidenori Koseki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class SystemPublisher(Node):
    def __init__(self):
        super().__init__('system_publisher')
        self.publisher_ = self.create_publisher(String, 'system_status', 10)
        self.timer = self.create_timer(1.0, self.timer_callback)
        self.prev_idle = 0
        self.prev_total = 0

    def get_cpu_usage(self):
        with open('/proc/stat', 'r') as f:
            cpu = f.readline().split()
        idle = int(cpu[4])
        total = sum(map(int, cpu[1:]))
        diff_idle = idle - self.prev_idle
        diff_total = total - self.prev_total
        self.prev_idle = idle
        self.prev_total = total
        return (1.0 - diff_idle / diff_total) * 100.0 if diff_total else 0.0

    def get_memory_usage(self):
        meminfo = {}
        with open('/proc/meminfo', 'r') as f:
            for line in f:
                key, value = line.split(':')
                meminfo[key] = int(value.strip().split()[0])
        total = meminfo['MemTotal']
        available = meminfo['MemAvailable']
        return ((total - available) / total) * 100.0

    def timer_callback(self):
        cpu = self.get_cpu_usage()
        mem = self.get_memory_usage()
        msg = String()
        msg.data = f"CPU: {cpu:.1f}%, MEM: {mem:.1f}%"
        self.publisher_.publish(msg)

def main():
    rclpy.init()
    node = SystemPublisher()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

