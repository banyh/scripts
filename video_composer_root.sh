#!/bin/sh

#
# update apt-get before anything
#
apt-get update

#
# install python dependencies
#
apt-get install -y \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl


#
# install ffmpeg
#
add-apt-repository -y ppa:mc3man/trusty-media
apt-get update
apt-get -y dist-upgrade
apt-get -y install ffmpeg


#
# install python 2.7.11
#
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
export PATH=/usr/local/lib/python2.7.11/bin:$PATH
pip install virtualenv


#
# install git 2.9.0
#
apt-get -y install build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
wget https://github.com/git/git/archive/v2.9.0.zip
unzip v2.9.0.zip
rm v2.9.0.zip
cd git-2.9.0
make prefix=/usr/local -j20 all
make prefix=/usr/local install
cd ..
rm -rf git-2.9.0


#
# install dependencies for pygame
#
apt-get -y install libxml2-dev libxslt1-dev libjpeg-dev libpng-dev xvfb mercurial \
libav-tools libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev libsmpeg-dev \
libsdl1.2-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev \
libtiff5-dev libx11-6 libx11-dev fluid-soundfont-gm xfonts-base xorg \
xfonts-100dpi xfonts-75dpi xfonts-cyrillic fontconfig fonts-freefont-ttf


#
# install gstreamer
#
add-apt-repository -y ppa:gstreamer-developers/ppa
apt-get update
apt-get -y install gstreamer1.0*


#
# install dependencies for kivy
#
apt-get -y install python-setuptools python-opengl alsa-utils pulseaudio \
python-gst0.10 python-enchant python-dev libmtdev1 python-cffi libffi-dev \
libgl1-mesa-dev-lts-quantal libgles2-mesa-dev-lts-quantal

