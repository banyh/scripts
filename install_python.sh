#!/bin/sh

PYTHON2_VERSION=2.7.15
PYTHON3_VERSION=3.6.6

wget https://www.python.org/ftp/python/$PYTHON2_VERSION/Python-$PYTHON2_VERSION.tgz
tar xfz Python-$PYTHON2_VERSION.tgz
rm -f Python-$PYTHON2_VERSION.tgz
cd Python-$PYTHON2_VERSION/
./configure --prefix /usr/local/lib/python$PYTHON2_VERSION --enable-ipv6 --enable-shared --enable-unicode=ucs4 --enable-loadable-sqlite-extensions --with-zlib
make -j20
make install
echo "/usr/local/lib/python$PYTHON2_VERSION/lib" > /etc/ld.so.conf.d/python2.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python$PYTHON2_VERSION/bin/python /usr/local/bin/python
ln -sf /usr/local/lib/python$PYTHON2_VERSION/bin/python /usr/local/bin/python2
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python$PYTHON2_VERSION/bin/pip /usr/local/bin/pip
pip install jupyter
ln -sf /usr/local/lib/python$PYTHON2_VERSION/bin/ipython /usr/local/bin/ipython

wget https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tgz
tar xfz Python-$PYTHON3_VERSION.tgz
rm -f Python-$PYTHON3_VERSION.tgz
cd Python-$PYTHON3_VERSION/
./configure --prefix /usr/local/lib/python$PYTHON3_VERSION --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib
make -j20
make install
echo "/usr/local/lib/python$PYTHON3_VERSION/lib" > /etc/ld.so.conf.d/python3.conf
ldconfig
cd ..
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/python3 /usr/local/bin/python3
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/virtualenv /usr/local/bin/virtualenv
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/jupyter /usr/local/lib/python$PYTHON3_VERSION/bin/jupyter3
hash -d python3
curl https://bootstrap.pypa.io/get-pip.py | python3
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/pip3 /usr/local/bin/pip3
pip3 install jupyter
ln -sf /usr/local/lib/python$PYTHON3_VERSION/bin/ipython3 /usr/local/bin/ipython3
