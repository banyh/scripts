#!/bin/sh

# install git
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install git -y
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
apt-get -y install git-lfs
git lfs install

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

# install rmate
curl -Lo /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
ln -sf /usr/local/bin/rmate /usr/local/bin/rsub
chmod a+x /usr/local/bin/rmate

# install mongodb
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y --force-yes mongodb-org
service mongod start

sh install_python.sh
sh install_ffmpeg.sh
sh install_opencv.sh
sh install_boost.sh
sh install_caffe.sh
sh install_stanford_seg_pos.sh
