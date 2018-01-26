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
# make runtest 並不是必需的，但花20分鐘跑完測試，可以避免之後出現奇怪的問題時，還得花時間debug
#
mkdir build2
cd build2
cmake -DPYTHON_EXECUTABLE=/usr/local/lib/python2.7.13/bin/python \
      -DPYTHON_INCLUDE_DIR=/usr/local/lib/python2.7.13/include/python2.7 \
      -DPYTHON_LIBRARY=/usr/local/lib/python2.7.13/lib/libpython2.7.so ..
make -j8 all
make pycaffe
make install
make -j8 runtest
cp -r install/python/caffe /usr/local/lib/python2.7.13/lib/python2.7/site-packages/
cp install/lib/*.* /usr/local/lib/

cd ..
mkdir build3
cd build3
cmake -DPYTHON_EXECUTABLE=/usr/local/lib/python3.6.2/bin/python3 \
      -DPYTHON_INCLUDE_DIR=/usr/local/lib/python3.6.2/include/python3.6m \
      -DPYTHON_LIBRARY=/usr/local/lib/python3.6.2/lib/libpython3.6m.so ..
find . -type f -exec sed -i -e 's^libboost_python\.so^libboost_python3.so^g' '{}' \;
make -j8 all
make pycaffe
make -j8 runtest
cp -Lr ../python/caffe /usr/local/lib/python3.6.2/lib/python3.6/site-packages/
