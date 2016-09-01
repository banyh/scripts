#!/bin/sh

#
# CUDA Toolkit 7.5-18
# Includes: CUDNN 4.0.7, Driver 352.63
#
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
apt-get -y update
apt-get -y install cuda

#
# GRID K520 driver 367.44
#
apt-get -y install linux-generic
apt-get -y purge nvidia*  # remove old nvidia drivers
reboot
###
service lightdm stop
service gdm stop
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.44/NVIDIA-Linux-x86_64-367.44.run
sh ./NVIDIA-Linux-x86_64-367.44.run
reboot

#
# Tesla driver 352.93
#
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/nvidia-352_352.93-0ubuntu1_amd64.deb
#dpkg -i nvidia-352_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/libcuda1-352_352.93-0ubuntu1_amd64.deb
#dpkg -i libcuda1-352_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/libxnvctrl0_352.93-0ubuntu1_amd64.deb
#dpkg -i libxnvctrl0_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/libxnvctrl-dev_352.93-0ubuntu1_amd64.deb
#dpkg -i libxnvctrl-dev_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/nvidia-352-uvm_352.93-0ubuntu1_amd64.deb
#dpkg -i nvidia-352-uvm_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/nvidia-352-dev_352.93-0ubuntu1_amd64.deb
#dpkg -i nvidia-352-dev_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/nvidia-modprobe_352.93-0ubuntu1_amd64.deb
#dpkg -i nvidia-modprobe_352.93-0ubuntu1_amd64.deb
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/nvidia-settings_352.93-0ubuntu1_amd64.deb
#dpkg -i nvidia-settings_352.93-0ubuntu1_amd64.deb
#reboot
