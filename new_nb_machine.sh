#!/bin/sh

# update apt-get before anything
apt-get update

# install some build dependencies
apt-get install -y htop sshfs \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip

# 安裝fcitx與嘸蝦米table
add-apt-repository ppa:fcitx-team/nightly
apt-get update
apt-get install fcitx fcitx-m17n
apt-get install fcitx-table-boshiamy

sh install_ffmpeg.sh

sh install_git.sh

wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
sh cuda_8.0.44_linux.run
#http://us.download.nvidia.com/XFree86/Linux-x86_64/367.57/NVIDIA-Linux-x86_64-367.57.run

nvidia-smi -pm 1

# CUDNN 4.0
wget https://gliacloud.blob.core.windows.net/nlp/cudnn-7.0-linux-x64-v4.0-prod.tgz
tar xvzf cudnn-7.0-linux-x64-v4.0-prod.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn.so.4.0.7 /usr/local/cuda/lib64
ln -sf /usr/local/cuda/lib64/libcudnn.so.4.0.7 /usr/local/cuda/lib64/libcudnn.so.4
ln -sf /usr/local/cuda/lib64/libcudnn.so.4 /usr/local/cuda/lib64/libcudnn.so
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
echo '/usr/local/cuda-7.5/targets/x86_64-linux/lib' > /etc/ld.so.conf.d/cuda.conf
ldconfig

# CUDNN 5.0 for CUDA 7.5
wget https://gliacloud.blob.core.windows.net/nlp/libcudnn5_5.1.3-1+cuda7.5_amd64.deb
dpkg -i libcudnn5_5.1.3-1+cuda7.5_amd64.deb

# CUDNN 5.0 for CUDA 8.0
wget https://gliacloud.blob.core.windows.net/nlp/libcudnn5_5.1.5-1+cuda8.0_amd64.deb
dpkg -i libcudnn5_5.1.5-1+cuda8.0_amd64.deb

# OpenGL
apt-get -y install libgl1-mesa-dev libglu1-mesa-dev

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
