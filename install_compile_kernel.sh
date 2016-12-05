#!/bin/sh

# update apt-get before anything
apt-get update

# install some build dependencies
apt-get install -y htop sshfs \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip linux-source \
linux-generic linux-headers-generic linux-image-extra-virtual

# recompile kernel
cd /usr/src/linux-source-3.13.0
bunzip2 linux-source-3.13.0.tar.bz2
tar xf linux-source-3.13.0.tar
rm linux-source-3.13.0.tar
cd linux-source-3.13.0/
mv * ..
cd ..
make oldconfig < /dev/null
make -j8 all
make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-3.13.0-200-gpu
cp /boot/System.map-3.13.0-100-generic /boot/System.map-3.13.0-200-gpu
cp .config /boot/config-3.13.0-200-gpu
update-grub
reboot
