#!/bin/sh

PYTHON3_VERSION=3.8.7

wget https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tgz
tar xfz Python-$PYTHON3_VERSION.tgz
rm -f Python-$PYTHON3_VERSION.tgz
cd Python-$PYTHON3_VERSION/
./configure --prefix /usr/local/python$PYTHON3_VERSION --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib
make -j
make install
echo "/usr/local/python$PYTHON3_VERSION/lib" > /etc/ld.so.conf.d/python.conf
ldconfig
hash -d python

# add /usr/local/python$PYTHON3_VERSION/bin/ to PATH
