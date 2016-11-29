#!/bin/sh

#
# driver version: Linux-x86_64 367.48
# toolkit location: /usr/local/cuda-8.0 --> /usr/local/cuda
#
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
chmod +x cuda_8.0.44_linux-run
./cuda_8.0.44_linux-run --driver --toolkit --silent --kernel-source-path="/usr/src/linux-source-3.13.0"
echo "/usr/local/cuda-8.0/lib64" >> /etc/ld.so.conf.d/cuda.conf
ldconfig

#
# CUDNN 5.1.5
#
wget https://gliacloud.blob.core.windows.net/nlp/libcudnn5_5.1.5-1+cuda8.0_amd64.deb
dpkg -i libcudnn5_5.1.5-1+cuda8.0_amd64.deb
ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.5.1.5 /usr/lib/x86_64-linux-gnu/libcudnn.so
ldconfig

# needed to reboot again? I'm not sure
reboot
