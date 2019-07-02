#!/bin/sh
apt-get install -y wget
apt-get install -y build-essential
apt-get install -y git
apt-get install -y libgtk2.0-dev
apt-get install -y pkg-config
apt-get install -y libavcodec-dev
apt-get install -y libavformat-dev
apt-get install -y libswscale-dev
apt-get install -y python-dev
apt-get install -y python-numpy
apt-get install -y libtbb2
apt-get install -y libtbb-dev
apt-get install -y libjpeg-dev
apt-get install -y libpng-dev
apt-get install -y libtiff-dev
apt-get install -y libjasper-dev
apt-get install -y libdc1394-22-dev


# Install cpp headers for libcurl
 apt-get install libcurl4-gnutls-dev

# Download and build a cmake version with SSL support
# We use the system's libcurl to avoid later problems
mdkir -p ~/tmp/cmake
cd !$
wget --no-check-certificate https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz
tar -zxvf cmake-3.9.0.tar.gz
cd cmake-3.9.0
./bootstrap --parallel=$(nproc) --system-curl
make -j $(nproc)

# Uninstall cmake
sudo apt remove cmake

# Install new version from sources
# (we should build a package instead)
sudo make install



cd /home/opencv
wget -o opencv4.1.0.zip https://github.com/opencv/opencv/archive/4.1.0.zip
unzip opencv4.1.0.zip
mkdir /home/opencv/opencv4.1.0/build
wget -o opencv_contrib-4.1.0.tar.gz https://github.com/opencv/opencv_contrib/archive/4.1.0.tar.gz
tar -zxf opencv_contrib-4.1.0.tar.gz
cd /home/opencv/opencv4.1.0/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/opencv4.1.0/ -DOPENCV_EXTRA_MODULES_PATH=/home/opencv/opencv_contrib-4.1.0/modules/ -DWITH_CUDA=ON  -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_opencv_xfeatures2d=ON OPENCV_ENABLE_NONFREE=NO  ..
make -j10
make install


echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
ldconfig


echo "
export PKG_CONFIG_PATH=/home/opencv/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/home/opencv/opencv4.1.0/lib:$LD_LIBRARY_PATH ">> ~/.bashrc
source ~/.bashrc


echo " OpenCV 环境变量："
echo"/etc/ld.so.conf.d/opencv.conf >> /home/opencv/opencv4.1.0/lib "
echo"~/.bashrc >>
export PKG_CONFIG_PATH=/home/opencv/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/home/opencv/opencv4.1.0/lib:$LD_LIBRARY_PATH ">> ~/.bashrc"


echo"opencv版本及库信息："
pkg-config --modversion opencv4
# 4.0.1
pkg-config --libs opencv4
pkg-config --cflags opencv4

