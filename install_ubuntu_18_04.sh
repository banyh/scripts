# ----------------------------------------------------------------------------------------------
# Install nvidia driver
# ----------------------------------------------------------------------------------------------
# 如果有舊的nvidia driver存在，一律移除並重開機；沒有則省略這一步
# dpkg -l | grep nvidia
# apt-get remove --purge "nvidia-*"
# reboot

# CUDA 10.0 網路版 (會同時安裝最新的 nvidia driver)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
apt-get update
apt-get install -y cuda

# 安裝CUDNN 7.0 (如果安裝CUDA 9.x，則唯一能配對的版本是CUDNN 7.0)
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7_7.0.5.15-1%2Bcuda9.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7-dev_7.0.5.15-1%2Bcuda9.0_amd64.deb
dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb

# ----------------------------------------------------------------------------------------------
# Install dependencies
# ----------------------------------------------------------------------------------------------
apt-get install -y htop sshfs libopenblas-dev \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip cmake python-dev python3-dev

wget https://launchpad.net/~fish-shell/+archive/ubuntu/release-2/+files/fish_2.7.1-1~xenial_amd64.deb
wget https://launchpad.net/~fish-shell/+archive/ubuntu/release-2/+files/fish-common_2.7.1-1~xenial_all.deb
dpkg -i fish_2.7.1-1~xenial_amd64.deb fish-common_2.7.1-1~xenial_all.deb
apt -f install -y

# ----------------------------------------------------------------------------------------------
# Install ffmpeg
# ----------------------------------------------------------------------------------------------
add-apt-repository -y ppa:jonathonf/ffmpeg-3
apt update
apt upgrade -y
apt-get -y install ffmpeg

# ----------------------------------------------------------------------------------------------
# Install git
# ----------------------------------------------------------------------------------------------
sh install_git.sh

# ----------------------------------------------------------------------------------------------
# Install python
# ----------------------------------------------------------------------------------------------
sh install_python.sh
sh install_python_packages.sh
sh install_pyqt4.sh
sh install_opencv.sh

# ----------------------------------------------------------------------------------------------
# install boost
# ----------------------------------------------------------------------------------------------
sh install_boost.sh

# ----------------------------------------------------------------------------------------------
# install caffe
# ----------------------------------------------------------------------------------------------
sh install_caffe.sh

# ----------------------------------------------------------------------------------------------
# install docker
# ----------------------------------------------------------------------------------------------
sh install_docker.sh

# ----------------------------------------------------------------------------------------------
# install mongodb
# ----------------------------------------------------------------------------------------------
sh install_mongodb.sh

# ----------------------------------------------------------------------------------------------
# install pandoc
# ----------------------------------------------------------------------------------------------
sh install_pandoc.sh
