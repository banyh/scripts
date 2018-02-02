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

# 下載CUDA
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
apt-get update
apt-get install -y cuda
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

# 安裝CUDNN
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn5_5.1.10-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn5-dev_5.1.10-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn6-dev_6.0.21-1%2Bcuda8.0_amd64.deb

dpkg -i libcudnn5_5.1.10-1+cuda8.0_amd64.deb
dpkg -i libcudnn6_6.0.21-1+cuda8.0_amd64.deb
dpkg -i libcudnn5-dev_5.1.10-1+cuda8.0_amd64.deb
dpkg -i libcudnn6-dev_6.0.21-1+cuda8.0_amd64.deb

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
PYTHON2_VERSION=2.7.13
wget https://www.python.org/ftp/python/${PYTHON2_VERSION}/Python-${PYTHON2_VERSION}.tgz
tar xfz Python-${PYTHON2_VERSION}.tgz
rm -f Python-${PYTHON2_VERSION}.tgz
cd Python-${PYTHON2_VERSION}/
./configure --prefix /usr/local/lib/python${PYTHON2_VERSION} --enable-ipv6 --enable-shared --enable-unicode=ucs4 --enable-loadable-sqlite-extensions --with-zlib
make -j20
make install
echo "/usr/local/lib/python${PYTHON2_VERSION}/lib" > /etc/ld.so.conf.d/python2.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python${PYTHON2_VERSION}/bin/python /usr/local/bin/python
ln -sf /usr/local/lib/python${PYTHON2_VERSION}/bin/python /usr/local/bin/python2
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python${PYTHON2_VERSION}/bin/pip /usr/local/bin/pip
pip install ipython
ln -sf /usr/local/lib/python${PYTHON2_VERSION}/bin/ipython /usr/local/bin/ipython

PYTHON3_VERSION=3.6.2
wget https://www.python.org/ftp/python/${PYTHON3_VERSION}/Python-${PYTHON3_VERSION}.tgz
tar xfz Python-${PYTHON3_VERSION}.tgz
rm -f Python-${PYTHON3_VERSION}.tgz
cd Python-${PYTHON3_VERSION}/
./configure --prefix /usr/local/lib/python${PYTHON3_VERSION} --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib
make -j20
make install
echo "/usr/local/lib/python${PYTHON3_VERSION}/lib" > /etc/ld.so.conf.d/python3.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python${PYTHON3_VERSION}/bin/python3 /usr/local/bin/python3
hash -d python3
curl https://bootstrap.pypa.io/get-pip.py | python3
ln -sf /usr/local/lib/python${PYTHON3_VERSION}/bin/pip3 /usr/local/bin/pip3
pip install ipython
ln -sf /usr/local/lib/python${PYTHON3_VERSION}/bin/ipython3 /usr/local/bin/ipython3

# ----------------------------------------------------------------------------------------------
# install Python packages
# ----------------------------------------------------------------------------------------------
pip install scipy nltk gensim pandas jupyter django==1.11.9 virtualenv mkdocs
pip3 install scipy nltk gensim pandas jupyter django virtualenv mkdocs

pip install scikit-learn matplotlib scikit-image
pip3 install scikit-learn matplotlib scikit-image

python -m ipykernel install --user
python3 -m ipykernel install --user

apt-get install -y libxml2-dev libxslt1-dev python-dev
pip install lxml bs4 pymongo pulp
pip3 install lxml bs4 pymongo pulp

apt-get install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
pip install tensorflow-gpu
pip3 install tensorflow-gpu
pip install http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp27-cp27mu-linux_x86_64.whl
pip install torchvision
pip3 install http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp36-cp36m-linux_x86_64.whl
pip3 install torchvision

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
