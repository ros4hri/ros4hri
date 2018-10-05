#! /usr/bin/sh

set -e # enable error checking -> while return on first error
set -o errexit

INSTALL_PREFIX=$HOME/ros4hri-dev

mkdir -p $INSTALL_PREFIX

cd ros4hri

### 1. Clone & compile nodes
for PKG_NAME in hri_msgs face_detection face_recognition skeleton_tracker;
do

echo "%%%%%%%%%%%%%%%%%%%%%%% INSTALLING $PKG_NAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

git clone https://github.com/ros4hri/$PKG_NAME.git
cd $PKG_NAME && mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DFastRTPS_INCLUDE_DIR=/opt/ros/bouncy/include/fastrtps -DFastRTPS_LIBRARY_RELEASE=/opt/ros/bouncy/lib/fastrtps ..
make
make install

cd ../..
done

### 2. Test pipeline

echo "%%%%%%%%%%%%%%%%%%%%%%% TESTING PIPELINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
