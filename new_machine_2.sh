#!/bin/sh

sh install_gpu_2.sh

# install cmake 3.x
add-apt-repository -y ppa:george-edison55/cmake-3.x
apt-get update
apt-get -y install cmake
apt-get -y upgrade

# install python 2.7.11
wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
tar xfz Python-2.7.11.tgz
rm -f Python-2.7.11.tgz
cd Python-2.7.11/
./configure --prefix /usr/local/lib/python2.7.11 --enable-ipv6 --enable-shared
make -j20
make install
echo "/usr/local/lib/python2.7.11/lib" > /etc/ld.so.conf.d/python2.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python2.7.11/bin/python /usr/local/bin/python
ln -sf /usr/local/lib/python2.7.11/bin/python /usr/local/bin/python2
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python2.7.11/bin/pip /usr/local/bin/pip

# install python 3.5.1
wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz
tar xfz Python-3.5.1.tgz
rm -f Python-3.5.1.tgz
cd Python-3.5.1/
./configure --prefix /usr/local/lib/python3.5.1 --enable-ipv6 --enable-shared
make -j20
make install
echo "/usr/local/lib/python3.5.1/lib" > /etc/ld.so.conf.d/python3.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python3.5.1/bin/python3 /usr/local/bin/python3
hash -d python3
curl https://bootstrap.pypa.io/get-pip.py | python3
ln -sf /usr/local/lib/python3.5.1/bin/pip3 /usr/local/bin/pip3

# install tensorflow for python 2.7
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL

# install tensorflow for python 3.5
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL

# install Python packages
pip install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs

# install scikit-learn
pip install scikit-learn scikit-image matplotlib theano keras sk-video
pip3 install scikit-learn scikit-image matplotlib theano keras sk-video

python -m ipykernel install --user
python3 -m ipykernel install --user

# install FISH
apt-add-repository -y ppa:fish-shell/release-2
apt-get -y update
apt-get -y install fish
apt-get -y upgrade fish

# install open-jdk 8
add-apt-repository -y ppa:openjdk-r/ppa
apt-get -y update
apt-get -y install openjdk-8-jdk

curl -Lo /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
ln -sf /usr/local/bin/rmate /usr/local/bin/rsub
chmod a+x /usr/local/bin/rmate

sh install_opencv.sh
sh install_boost.sh
sh install_caffe.sh
sh install_stanford_seg_pos.sh

useradd -d /home/banyhong -m -s /usr/bin/fish banyhong
sudo adduser banyhong sudo
echo 'banyhong ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
passwd banyhong  # must set the password manually
