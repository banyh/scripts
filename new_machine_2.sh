#!/bin/sh

sh install_gpu_2.sh

sh install_python.sh

# install cmake 3.x
add-apt-repository -y ppa:george-edison55/cmake-3.x
apt-get update
apt-get -y install cmake
apt-get -y upgrade

# install FISH
apt-add-repository -y ppa:fish-shell/release-2
apt-get -y update
apt-get -y install fish
apt-get -y upgrade fish

# install open-jdk 8
add-apt-repository -y ppa:openjdk-r/ppa
apt-get -y update
apt-get -y install openjdk-8-jdk

curl -Lo /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
ln -sf /usr/local/bin/rmate /usr/local/bin/rsub
chmod a+x /usr/local/bin/rmate

sh install_opencv.sh
sh install_boost.sh
sh install_caffe.sh
sh install_stanford_seg_pos.sh
