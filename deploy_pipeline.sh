#! /bin/sh

set -e # enable error checking -> while return on first error
set -o errexit

INSTALL_PREFIX=`pwd`/ros4hri-dev

if [ -d "$INSTALL_PREFIX" ]; then
    rm -rf $INSTALL_PREFIX
fi

mkdir -p $INSTALL_PREFIX

if [ -d "tmp-dev" ]; then
    rm -rf tmp-dev
fi

mkdir -p tmp-dev && cd tmp-dev

### 1. Clone & compile nodes
for PKG_NAME in hri_msgs face_detection face_recognition skeleton_tracker;
do

echo "%%%%%%%%%%%%%%%%%%%%%%% INSTALLING $PKG_NAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

git clone https://github.com/ros4hri/$PKG_NAME.git
cd $PKG_NAME && mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX ..
make
make install
source $INSTALL_PREFIX/setup.sh
cd ../..
done

### 2. Test pipeline

echo "%%%%%%%%%%%%%%%%%%%%%%% TESTING PIPELINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
