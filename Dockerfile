# Container for building a 'hello world' application
FROM ubuntu:20.04

# Project Name
ENV PROJECT_NAME vive_tracker_ubuntu20

# Prevent dialogs when installing packages
ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# set locale
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL C

# Create alias for the working directory
ENV WORKING_DIRECTORY /home/root/${PROJECT_NAME}

# Set working directory to ${WORKING_DIRECTORY}
WORKDIR ${WORKING_DIRECTORY}

# Copy the current directory contents into the container at ${WORKING_DIRECTORY}
#COPY . ${WORKING_DIRECTORY}

# Install SetupEnvironment.sh dependencies
COPY ./setup/SetupEnvironment.sh ${WORKING_DIRECTORY}/setup/SetupEnvironment.sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ./setup/SetupEnvironment.sh

# Install ROS2
COPY ./setup/SetupROS2.sh ${WORKING_DIRECTORY}/setup/SetupROS2.sh
RUN ./setup/SetupROS2.sh

# Install ROS1
COPY ./setup/SetupROS1.sh ${WORKING_DIRECTORY}/setup/SetupROS1.sh
RUN ./setup/SetupROS1.sh

# Install SetupDependencies.sh dependencies
COPY ./setup/SetupDependencies.sh ${WORKING_DIRECTORY}/setup/SetupDependencies.sh
RUN ./setup/SetupDependencies.sh

COPY ./dev_ws ${WORKING_DIRECTORY}/dev_ws

# Build the app
#RUN source /opt/ros/galactic/setup.bash \
    #&& cd dev_ws \
	#&& colcon build \
	#&& . install/setup.bash \
	#&& mkdir -p ros1_bridge_ws/src && cd ros1_bridge_ws/src && git clone -b galactic https://github.com/ros2/ros1_bridge.git

#RUN mkdir -p catkin_ws/src \
	#&& cd catkin_ws \
	#&& . /opt/ros/noetic/setup.bash \
	#&& catkin build \
	#&& cd ../dev_ws \
	#&& . /opt/ros/galactic/setup.bash \
	#&& colcon build \
	#&& cd .. \
	#&& mkdir -p ros1_bridge_ws/src \
	#&& cd ros1_bridge_ws/src \
	#&& git clone -b galactic https://github.com/ros2/ros1_bridge.git \
	#&& cd .. \
	#&& . ../catkin_ws/devel/setup.bash \
	#&& . ../dev_ws/install/setup.bash

	#&& . /opt/ros/noetic/setup.bash \
	#&& . /opt/ros/galactic/setup.bash \
	#&& colcon build --packages-select ros1_bridge --cmake-force-configure --cmake-args -DBUILD_TESTING=FALSE \
	#&& source install/local_setup.bash \
	#&& ros2 run ros1_bridge dynamic_bridge --print-pairs

RUN mkdir -p catkin_ws/src \
	&& cd catkin_ws \
	&& . /opt/ros/noetic/setup.bash \
		#&& catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ros/noetic \
	&& catkin build \
	&& cd ../dev_ws \
	&& . /opt/ros/galactic/setup.bash \
		#&& colcon build --merge-install --install-base /opt/ros/galactic \
	&& colcon build \
	&& cd .. \
	&& mkdir -p ros1_bridge_ws/src \
	&& cd ros1_bridge_ws/src \
	&& git clone -b galactic https://github.com/ros2/ros1_bridge.git \
	&& cd .. \
	&& . ../catkin_ws/devel/setup.bash \
	&& . ../dev_ws/install/setup.bash \
		#&& . /opt/ros/noetic/setup.bash \
		#&& . /opt/ros/galactic/setup.bash \
		#&& colcon build --packages-select ros1_bridge --cmake-force-configure --cmake-args -DBUILD_TESTING=FALSE \
	&& MAKEFLAGS="-j8" colcon build --merge-install --packages-select ros1_bridge --cmake-force-configure --install-base /opt/ros/galactic \
		#&& source install/local_setup.bash \
	&& ros2 run ros1_bridge dynamic_bridge --print-pairs

# Set up the environment
#ENV LD_LIBRARY_PATH=/opt/ros/galactic/lib:/opt/ros/noetic/lib
ENV LD_LIBRARY_PATH="/home/root/vive_tracker_ubuntu20/catkin_ws/devel/lib:/opt/ros/noetic/lib:/opt/ros/galactic/opt/yaml_cpp_vendor/lib:/opt/ros/galactic/lib/x86_64-linux-gnu:/opt/ros/galactic/lib"
#ENV AMENT_PREFIX_PATH=/opt/ros/galactic
ENV AMENT_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install/vive_tracker_analysis:/opt/ros/galactic"
ENV ROS_ETC_DIR=/opt/ros/noetic/etc/ros
#ENV COLCON_PREFIX_PATH=/opt/ros/galactic
ENV COLCON_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install"
ENV ROS_ROOT=/opt/ros/noetic/share/ros
ENV ROS_MASTER_URI=http://11.11.3.155:11311
ENV ROS_VERSION=2
ENV ROS_LOCALHOST_ONLY=0
ENV ROS_PYTHON_VERSION=3
ENV PYTHONPATH=/opt/ros/galactic/lib/python3.8/site-packages:/opt/ros/noetic/lib/python3/dist-packages
ENV ROS_PACKAGE_PATH=/opt/ros/noetic/share
	#ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/galactic/bin:/opt/ros/noetic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#ENV PKG_CONFIG_PATH=/opt/ros/noetic/lib/pkgconfig
ENV PKG_CONFIG_PATH="/home/root/vive_tracker_ubuntu20/catkin_ws/devel/lib/pkgconfig:/opt/ros/noetic/lib/pkgconfig"
#ENV CMAKE_PREFIX_PATH=/opt/ros/galactic:/opt/ros/noetic
ENV CMAKE_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install/vive_tracker_analysis:/home/root/vive_tracker_ubuntu20/catkin_ws/devel:/opt/ros/noetic"

ENV CYCLONEDDS_URI='<CycloneDDS><Domain><General><NetworkInterfaceAddress>enp5s0</NetworkInterfaceAddress></General></Domain></CycloneDDS>'
ENV ROS_IP="11.11.3.155"

RUN ros2 run ros1_bridge dynamic_bridge --print-pairs

#CMD ["bash", "-c", "ros2 run ros1_bridge dynamic_bridge --bridge-all-pairs"]

# The command that is run when the container is run (i.e. the executable for the app)
# CMD ${WORKING_DIRECTORY}/Build/Apps/HelloWorld
# ros2 run vive_tracker_analysis subscriber
# 
# export CYCLONEDDS_URI='<CycloneDDS><Domain><General><NetworkInterfaceAddress>enp5s0</NetworkInterfaceAddress></General></Domain></CycloneDDS>'


#declare -x AMENT_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install/vive_tracker_analysis:/opt/ros/galactic"
#declare -x CMAKE_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install/vive_tracker_analysis:/home/root/vive_tracker_ubuntu20/catkin_ws/devel:/opt/ros/noetic"
#declare -x COLCON_PREFIX_PATH="/home/root/vive_tracker_ubuntu20/dev_ws/install"
		#declare -x HOME="/root"
		#declare -x HOSTNAME="createc-ox-workstation"
		#declare -x LANG="en_GB.UTF-8"
		#declare -x LANGUAGE="en_GB:en"
		#declare -x LC_ALL="C"
#declare -x LD_LIBRARY_PATH="/home/root/vive_tracker_ubuntu20/catkin_ws/devel/lib:/opt/ros/noetic/lib:/opt/ros/galactic/opt/yaml_cpp_vendor/lib:/opt/ros/galactic/lib/x86_64-linux-gnu:/opt/ros/galactic/lib"
		#declare -x LESSCLOSE="/usr/bin/lesspipe %s %s"
		#declare -x LESSOPEN="| /usr/bin/lesspipe %s"
		#declare -x LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
		#declare -x OLDPWD="/home/root/vive_tracker_ubuntu20/ros1_bridge_ws/src"
	#declare -x PATH="/opt/ros/noetic/bin:/opt/ros/galactic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#declare -x PKG_CONFIG_PATH="/home/root/vive_tracker_ubuntu20/catkin_ws/devel/lib/pkgconfig:/opt/ros/noetic/lib/pkgconfig"
		#declare -x PROJECT_NAME="vive_tracker_ubuntu20"
		#declare -x PWD="/home/root/vive_tracker_ubuntu20/ros1_bridge_ws"
	#declare -x PYTHONPATH="/opt/ros/noetic/lib/python3/dist-packages:/opt/ros/galactic/lib/python3.8/site-packages"
		#declare -x ROSLISP_PACKAGE_DIRECTORIES=""
		#declare -x ROS_DISTRO="galactic"
	#declare -x ROS_ETC_DIR="/opt/ros/noetic/etc/ros"
	#declare -x ROS_LOCALHOST_ONLY="0"
	#declare -x ROS_MASTER_URI="http://localhost:11311"
	#declare -x ROS_PACKAGE_PATH="/opt/ros/noetic/share"
	#declare -x ROS_PYTHON_VERSION="3"
	#declare -x ROS_ROOT="/opt/ros/noetic/share/ros"
	#declare -x ROS_VERSION="2"
		#declare -x SHLVL="1"
		#declare -x TERM="xterm"
		#declare -x WORKING_DIRECTORY="/home/root/vive_tracker_ubuntu20"