# -----------------------------------------------------------------------------
# Install Common Softwares
# -----------------------------------------------------------------------------
apt-get install -y htop sshfs libopenblas-dev autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools netbase quilt tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran software-properties-common curl unzip cmake python3-dev ffmpeg git fish apt-transport-https gnupg-agent

# -----------------------------------------------------------------------------
# Install CUDA 11.2
# -----------------------------------------------------------------------------
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
apt-get update
apt-get -y install cuda

# -----------------------------------------------------------------------------
# Install Boshiamy
# -----------------------------------------------------------------------------
apt-get install -y fcitx fcitx-m17n fcitx-table-boshiamy

# -----------------------------------------------------------------------------
# Install Docker-CE
# -----------------------------------------------------------------------------
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable"
apt-get install -y docker-ce docker-ce-cli containerd.io

# -----------------------------------------------------------------------------
# Install Nvidia-docker2
# -----------------------------------------------------------------------------
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt update
apt install -y nvidia-docker2
pkill -SIGHUP dockerd

# -----------------------------------------------------------------------------
# Install User Softwares
# -----------------------------------------------------------------------------
apt install -y mcomix       # MComix看漫畫
apt install -y guvcview     # 設定webcam的亮度、對比、Gamma
apt install -y smplayer     # SMPlayer影片播放
apt install -y kazam        # Kazam桌面錄影
wget "https://go.skype.com/skypeforlinux-64.deb"
dpkg -i skypeforlinux-64.deb    # Skype
wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O code.deb
dpkg -i code.deb                # Visual Studio Code

# -----------------------------------------------------------------------------
# Install Python and lightgbm-gpu
# -----------------------------------------------------------------------------
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

apt install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev libmysqlclient-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler sox libsox-dev libsox-fmt-all

pip install lightgbm --install-option=--gpu --install-option="--opencl-include-dir=/usr/local/cuda/include/" --install-option="--opencl-library=/usr/local/cuda/targets/x86_64-linux/lib/libOpenCL.so"
