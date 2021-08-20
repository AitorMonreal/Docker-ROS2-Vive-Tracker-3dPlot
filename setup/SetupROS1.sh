#!/bin/bash

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

apt update
apt install -y ros-noetic-ros-base
#source /opt/ros/noetic/setup.bash

# Install catkin
apt update
apt install -y python3-catkin-tools