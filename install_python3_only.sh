#!/bin/sh

PYTHON3_VERSION=3.7.1

wget https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tgz
tar xfz Python-$PYTHON3_VERSION.tgz
rm -f Python-$PYTHON3_VERSION.tgz
cd Python-$PYTHON3_VERSION/
./configure --prefix /usr/local/lib/python$PYTHON3_VERSION --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib
make -j20
make install
echo "/usr/local/lib/python$PYTHON3_VERSION/lib" > /etc/ld.so.conf.d/python.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/python3 /usr/local/bin/python
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/virtualenv /usr/local/bin/virtualenv
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/jupyter /usr/local/lib/jupyter
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/pip /usr/local/bin/pip
pip install jupyter
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/ipython /usr/local/bin/ipython
