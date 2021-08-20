#!/bin/bash

apt-get update

apt-get install -y sudo \
	git \
	make \
	gcc \
	g++ \
	wget \
	build-essential \
	software-properties-common \
	dialog \
	apt-utils \
	libssl-dev

# Configure CMake
wget http://www.cmake.org/files/v3.21/cmake-3.21.1.tar.gz
tar -xvzf cmake-3.21.1.tar.gz
cd cmake-3.21.1/
./configure
make -j4
make install
cd ..
rm -rf cmake*
