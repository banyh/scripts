apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get -y install --no-install-recommends libboost-all-dev
apt-get -y install libatlas-base-dev doxygen
apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev
pip install scikit-image

git clone https://github.com/BVLC/caffe
cd caffe

mkdir build
cd build
cmake -DOpenCV_DIR=/usr/local/lib/python2.7.11/share/OpenCV \
      -DUSE_OPENCV=1 \
      -DPYTHON_EXECUTABLE=/usr/bin/python \
      -DPYTHON_LIB=/usr/lib/x86_64-linux-gnu \
      -DPYTHON_INCLUDE='/usr/include/python2.7 /usr/include/python2.7/numpy' \
      -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
      ..
make -j16 all
make install

cp -r install/python/caffe /usr/local/lib/python2.7.11/lib/python2.7/site-packages/
cp install/lib/*.* /usr/local/lib/

make -j16 runtest  # optional
