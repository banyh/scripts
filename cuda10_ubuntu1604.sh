# CUDA 10.0 網路版 (會同時安裝最新的 nvidia driver 390)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
dpkg -i cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
apt-get update
apt-get install -y cuda

# 安裝CUDNN 7.0 (如果安裝CUDA 9.x，則唯一能配對的版本是CUDNN 7.0)
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7_7.0.5.15-1%2Bcuda9.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7-dev_7.0.5.15-1%2Bcuda9.0_amd64.deb
dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb
