#! /usr/bin/sh

INSTALL_PREFIX=$HOME/ros4hri-dev

mkdir -P $INSTALL_PREFIX

cd ros4hri

### 1. Clone & compile nodes
for PKG_NAME in hri_msgs face_detection face_recognition skeleton_tracker;
do

echo "%%%%%%%%%%%%%%%%%%%%%%% INSTALLING $PKG_NAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

arr=(${PKG_NAME//_/ })
printf -v PKG_CAMELCASE %s "${arr[@]^}"

git clone https://github.com/ros4hri/$PKG_NAME.git
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$ROS_DEV -DFastRTPS_INCLUDE_DIR=/opt/ros/bouncy/include/fastrtps -DFastRTPS_LIBRARY_RELEASE=/opt/ros/bouncy/lib/fastrtps ..
make
make install

cd ../..
done
