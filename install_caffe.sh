##
## Prerequisite
## 1. cmake >= 3.2
## 2. opencv
## 3. libboost corresponds to your python. ex: python 2.7.11 use libboost 1.59.0
##

apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
apt-get -y install libatlas-base-dev doxygen cmake
apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev
#apt-get -y install --no-install-recommends libboost-all-dev
#apt-get -y install libopencv-dev
pip install scikit-image

git clone https://github.com/BVLC/caffe
cd caffe

#
# Install Caffe for Python2
#
mkdir build
cd build
cmake -DOpenCV_DIR=/usr/local/lib/python2.7.12/share/OpenCV \
      -DUSE_OPENCV=1 \
      -DPYTHON_EXECUTABLE=/usr/local/lib/python2.7.12/bin/python \
      -DPYTHON_INCLUDE_DIR=/usr/local/lib/python2.7.12/include/python2.7 \
      -DPYTHON_LIBRARY=/usr/local/lib/python2.7.12/lib/libpython2.7.so \
      ..
make -j24 all
make install

cp -r install/python/caffe /usr/local/lib/python2.7.12/lib/python2.7/site-packages/
cp install/lib/*.* /usr/local/lib/
# make -j16 runtest  # optional
cd ../..
