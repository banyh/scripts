if [ -f /swapfile ]
then
    echo 'Swap file exists. Skip creating the swap file.'
else
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
fi

apt-get install -y htop sshfs \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip

sh install_ffmpeg.sh
sh install_git.sh

# install cmake 3.x
add-apt-repository -y ppa:george-edison55/cmake-3.x
apt-get update
apt-get -y install cmake
apt-get -y upgrade

# install python 2.7.12
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xfz Python-2.7.12.tgz
rm -f Python-2.7.12.tgz
cd Python-2.7.12/
./configure --prefix /usr/local/lib/python2.7.12 --enable-ipv6 --enable-shared
make -j20
make install
echo "/usr/local/lib/python2.7.12/lib" > /etc/ld.so.conf.d/python2.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python2.7.12/bin/python /usr/local/bin/python
ln -sf /usr/local/lib/python2.7.12/bin/python /usr/local/bin/python2
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python2.7.12/bin/pip /usr/local/bin/pip

# install python 3.5.2
wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
tar xfz Python-3.5.2.tgz
rm -f Python-3.5.2.tgz
cd Python-3.5.2/
./configure --prefix /usr/local/lib/python3.5.2 --enable-ipv6 --enable-shared
make -j20
make install
echo "/usr/local/lib/python3.5.2/lib" > /etc/ld.so.conf.d/python3.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python3.5.2/bin/python3 /usr/local/bin/python3
hash -d python3
curl https://bootstrap.pypa.io/get-pip.py | python3
ln -sf /usr/local/lib/python3.5.2/bin/pip3 /usr/local/bin/pip3

# install tensorflow for python 2.7
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL

# install tensorflow for python 3.5
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL

# install Python packages
pip install scipy nltk gensim pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim pandas jupyter django virtualenv mkdocs

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

chsh -s /usr/bin/fish ubuntu
mkdir -p /home/ubuntu/.config/fish
cp config.fish /home/ubuntu/.config/fish/
chown ubuntu:ubuntu /home/ubuntu/.config/fish/config.fish

reboot
