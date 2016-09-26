git clone https://github.com/benjibc/caffe-rpi --recursive
cd caffe-rpi

apt-get install -y gfortran
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get install -y --no-install-recommends libboost-all-dev
apt-get install -y libopenblas-dev
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

pip install --upgrade pip
pip install --upgrade numpy
pip install scipy
pip install scikit-image
pip install protobuf
pip install glog
pip install h5py

make -j4 pycaffe
cp -r python/caffe /usr/local/lib/python2.7/dist-packages/
cp build/lib/*.* /usr/local/lib/
ldconfig

# make test is optional
make -j4 test
make runtest
