#!/bin/bash

apt-get update

# Eigen 
# sudo apt-get install -y libpoco-dev libeigen3-dev

# Open CV
# sudo apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev

# TF
apt-get install -y tf
#apt-get install -y ros-kinetic-tf-conversions

# Nano...
apt-get install -y nano

# Matplotlib-cpp
#apt-get update
apt-get install -y python3-matplotlib python-numpy python-dev python3-dev
apt-get install -y curl zip unzip tar
git clone https://github.com/lava/matplotlib-cpp
cd matplotlib-cpp
mkdir Build
cd Build
cmake ..
make install
cd ..
rm -rf matplotlib-cpp

# ROS1 Bridge
#mkdir -p ros1_bridge_ws/src
#cd ros1_bridge_ws/src
#git clone -b galactic https://github.com/ros2/ros1_bridge.git
#source /opt/ros/noetic/setup.bash
#source /opt/ros/galactic/setup.bash
#colcon build --packages-select ros1_bridge --cmake-force-configure --cmake-args -DBUILD_TESTING=FALSE
#source install/local_setup.bash