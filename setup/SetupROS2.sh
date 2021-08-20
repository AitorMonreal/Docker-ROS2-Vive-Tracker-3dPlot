#!/bin/bash

apt-get update

# ROS2
# Add the ROS2 apt repository
apt install -y curl gnupg lsb-release
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
# Install ROS2
apt update
apt install -y ros-galactic-ros-base
# Environment setup
#echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
#source ~/.bashrc

# Install colcon
sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
apt update
apt install -y python3-colcon-common-extensions


# ROS
#sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#sudo apt-get update
#apt-get install -y ros-kinetic-ros-base
# apt-get install -y ros-desktop-full
#rosdep init
#rosdep update
#echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
# echo "export ROS_MASTER_URI=http://10.10.3.154:11311" >> ~/.bashrc
# echo "export ROS_HOSTNAME=10.10.3.154" >> ~/.bashrc
# echo "export ROS_IP=10.10.3.154" >> ~/.bashrc
#source ~/.bashrc
# apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
# rosdep init
# sudo rosdep update
# apt-get install -y ros-kinetic-catkin python-catkin-tools