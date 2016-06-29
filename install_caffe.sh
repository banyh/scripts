apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get -y install --no-install-recommends libboost-all-dev
apt-get -y install libatlas-base-dev
apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev
pip install scikit-image

git clone https://github.com/BVLC/caffe
cd caffe

echo 'CPU_ONLY := 1' > Makefile.config
echo 'USE_OPENCV := 0' >> Makefile.config
echo 'BLAS := atlas' >> Makefile.config
echo 'PYTHON_INCLUDE := /usr/local/lib/python2.7.11/include/python2.7 /usr/local/lib/python2.7.11/lib/python2.7/site-packages/numpy/core/include' >> Makefile.config
echo 'PYTHON_LIB := /usr/local/lib/python2.7.11/lib' >> Makefile.config
echo 'INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include' >> Makefile.config
echo 'LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib' >> Makefile.config
echo 'BUILD_DIR := build' >> Makefile.config
echo 'DISTRIBUTE_DIR := distribute' >> Makefile.config
echo 'TEST_GPUID := 0' >> Makefile.config
echo 'Q ?= @' >> Makefile.config

mkdir build
cd build
cmake ..
make -j8 all
make install
make -j8 runtest

cp -r install/python/caffe /usr/local/lib/python2.7.11/lib/python2.7/site-packages/
cp install/lib/*.* /usr/local/lib/
