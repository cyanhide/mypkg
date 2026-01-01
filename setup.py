from glob import glob
from setuptools import setup
import os

package_name = 'mypkg'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages', ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name), glob('launch/*.launch.py'))
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Hidenori Koseki',
    maintainer_email='s22c1044zk@s.chibakoudai.jp',
    description='CPU/Memory monitoring ROS2 package',
    license='BSD-3-Clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'system_publisher = mypkg.system_publisher:main',
            'system_listener  = mypkg.system_listener:main',
        ],
    },
)

