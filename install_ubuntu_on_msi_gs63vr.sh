# ----------------------------------------------------------------------------------------------
# Install nvidia driver
# ----------------------------------------------------------------------------------------------

# 如果有舊的nvidia driver存在，一律移除並重開機；沒有則省格這一步
dpkg -l | grep nvidia
apt-get purge nvidia*
reboot

# 安裝最新的nvidia driver
add-apt-repository -y ppa:graphics-drivers/ppa
apt-get update
apt-get install -y nvidia-384

# 下載CUDA 8.0
# wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
# dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
# apt-get update
# apt-get install -y cuda
# wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb
# dpkg -i cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

# 下載CUDA 9.0
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
apt-get update
apt-get install -y cuda
dpkg -i cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb
apt -y autoremove

# 安裝CUDNN 7.0 (如果安裝CUDA 9.0，則唯一能配對的版本是CUDNN 7.0)
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7_7.0.5.15-1%2Bcuda9.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_16.04/libcudnn7-dev_7.0.5.15-1%2Bcuda9.0_amd64.deb

dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb

# ----------------------------------------------------------------------------------------------
# Install dependencies
# ----------------------------------------------------------------------------------------------
apt-get install -y htop sshfs libopenblas-dev fish \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip

# ----------------------------------------------------------------------------------------------
# Install ffmpeg
# ----------------------------------------------------------------------------------------------
add-apt-repository -y ppa:jonathonf/ffmpeg-3
apt update
apt upgrade -y
apt-get -y install ffmpeg

# ----------------------------------------------------------------------------------------------
# Install python
# ----------------------------------------------------------------------------------------------
sh install_python.sh

# ----------------------------------------------------------------------------------------------
# install boost
# ----------------------------------------------------------------------------------------------
sh install_boost.sh

# ----------------------------------------------------------------------------------------------
# install caffe
# ----------------------------------------------------------------------------------------------
sh install_caffe.sh

# ----------------------------------------------------------------------------------------------
# install pandoc
# ----------------------------------------------------------------------------------------------
wget https://github.com/jgm/pandoc/releases/download/2.0.3/pandoc-2.0.3-1-amd64.deb
dpkg -i pandoc-2.0.3-1-amd64.deb
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvfz install-tl-unx.tar.gz
cd $(ls -d install-tl-2*)
./install-tl
export PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-linux
cd ..

# ----------------------------------------------------------------------------------------------
# install docker
# ----------------------------------------------------------------------------------------------
apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

# ----------------------------------------------------------------------------------------------
# install mongodb
# ----------------------------------------------------------------------------------------------
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y --force-yes mongodb-org
service mongod start
