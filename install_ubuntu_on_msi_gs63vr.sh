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
apt-get install cuda
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
apt upgrade

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

# ----------------------------------------------------------------------------------------------
# install boost
# ----------------------------------------------------------------------------------------------
wget http://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz
tar xvfz boost_1_63_0.tar.gz
rm -f boost_1_63_0.tar.gz
cd boost_1_63_0/
./bootstrap.sh --with-python=/usr/local/bin/python --with-python-root=/usr/local/lib/python2.7.13
./b2 install threading=multi link=shared
./bootstrap.sh --with-python=/usr/local/bin/python3 --with-python-version=3.6 --with-python-root=/usr/local/lib/python3.6.2
./b2 --enable-unicode=ucs4 install threading=multi link=shared
cd ..

# ----------------------------------------------------------------------------------------------
# install caffe
# ----------------------------------------------------------------------------------------------
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev cmake git gfortran
cmake -DCPU_ONLY=0 -DUSE_OPENCV=0 -DUSE_CUDNN=1 -DBLAS=open \
      -DPYTHON_EXECUTABLE=/usr/local/bin/python \
      -DPYTHON_INCLUDE_DIR=/usr/local/lib/python2.7.13/include/python2.7 \
      -DPYTHON_LIBRARY=/usr/local/lib/python2.7.13/lib/libpython2.7.so \
      -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
      -DCUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.5 \
      -DCUDNN_INCLUDE=/usr/include ..
make all -j8
make install
cp -r install/python/caffe /usr/local/lib/python2.7.13/lib/python2.7/site-packages/
cp install/lib/*.* /usr/local/lib/
cd ..

# ----------------------------------------------------------------------------------------------
# install caffe
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
