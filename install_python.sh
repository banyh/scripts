#!/bin/sh

# install python 2.7.12
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xfz Python-2.7.12.tgz
rm -f Python-2.7.12.tgz
cd Python-2.7.12/
./configure --prefix /usr/local/lib/python2.7.12 --enable-ipv6 --enable-shared --enable-unicode=ucs4
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
pip install ipython
ln -sf /usr/local/lib/python2.7.12/bin/ipython /usr/local/bin/ipython

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
pip install ipython
ln -sf /usr/local/lib/python3.5.2/bin/ipython3 /usr/local/bin/ipython3

# install tensorflow for python 2.7
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc0-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL

# install tensorflow for python 3.5
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.12.0rc0-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL

# install Python packages
pip install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs

# install scikit-learn
pip install scikit-learn scikit-image matplotlib theano keras sk-video
pip3 install scikit-learn scikit-image matplotlib theano keras sk-video

python -m ipykernel install --user
python3 -m ipykernel install --user
