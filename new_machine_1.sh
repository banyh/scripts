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
software-properties-common curl

sh install_ffmpeg.sh
sh install_git.sh
sh install_gpu.sh
