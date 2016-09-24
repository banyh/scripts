git clone https://github.com/benjibc/caffe-rpi --recursive
cd caffe-rpi

pip install numpy scikit-image

apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get install -y --no-install-recommends libboost-all-dev
apt-get install -y libopenblas-dev
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

make -j4 pycaffe
cp -r python/caffe /usr/local/lib/python2.7/dist-packages/
cp build/lib/*.* /usr/local/lib/
ldconfig

# make test is optional
make -j4 test
make runtest
