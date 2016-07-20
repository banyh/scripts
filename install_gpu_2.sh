#!/bin/sh

nvidia-smi -pm 1

#
# CUDNN 4.0
#
wget https://gliacloud.blob.core.windows.net/nlp/cudnn-7.0-linux-x64-v4.0-prod.tgz
tar xvzf cudnn-7.0-linux-x64-v4.0-prod.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn.so.4.0.7 /usr/local/cuda/lib64
ln -sf /usr/local/cuda/lib64/libcudnn.so.4.0.7 /usr/local/cuda/lib64/libcudnn.so.4
ln -sf /usr/local/cuda/lib64/libcudnn.so.4 /usr/local/cuda/lib64/libcudnn.so
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
echo '/usr/local/cuda-7.5/targets/x86_64-linux/lib' > /etc/ld.so.conf.d/cuda.conf
ldconfig


#
# OpenGL
#
apt-get -y install libgl1-mesa-dev libglu1-mesa-dev
