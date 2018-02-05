#!/bin/sh

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
pip install scipy nltk gensim pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim pandas jupyter django virtualenv mkdocs

pip install scikit-learn matplotlib scikit-image scikit-video
pip3 install scikit-learn matplotlib scikit-image scikit-video

python -m ipykernel install --user
python3 -m ipykernel install --user

apt-get install -y libxml2-dev libxslt1-dev python-dev

pip install lxml bs4 pymongo pulp gevent crcmod autopep8 flashtext spacy
pip3 install lxml bs4 pymongo pulp gevent crcmod autopep8 flashtext spacy

apt-get install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler

pip install tensorflow-gpu keras h5py
pip3 install tensorflow-gpu keras h5py

# pip install -U http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp27-cp27mu-linux_x86_64.whl
# pip install torchvision
# pip3 install -U http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp36-cp36m-linux_x86_64.whl
# pip3 install torchvision

pip install -U http://download.pytorch.org/whl/cu90/torch-0.3.0.post4-cp27-cp27mu-linux_x86_64.whl
pip install torchvision
pip3 install -U http://download.pytorch.org/whl/cu90/torch-0.3.0.post4-cp36-cp36m-linux_x86_64.whl
pip3 install torchvision

# Check if CUDA and CUDNN are correctly installed and used by pytorch
python -c "from torch import cuda; print 'CUDA available:', cuda.is_available()"
python -c "from torch import cuda; print 'CUDA device 0:', cuda.get_device_name(0)"
python -c "from torch.backends import cudnn; print 'CUDNN version:', cudnn.version()"
python3 -c "from torch import cuda; print('CUDA available:', cuda.is_available())"
python3 -c "from torch import cuda; print('CUDA device 0:', cuda.get_device_name(0))"
python3 -c "from torch.backends import cudnn; print('CUDNN version:', cudnn.version())"
