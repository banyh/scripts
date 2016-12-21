apt-get -y install build-essential cmake git pkg-config
apt-get -y install libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev
apt-get -y install libgtk2.0-dev
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get -y install libatlas-base-dev gfortran

#
# MUST upgrade to cmake 3.x to build opencv
#
add-apt-repository -y ppa:george-edison55/cmake-3.x
apt-get update
apt-get -y install cmake
apt-get -y upgrade

export PYTHON2_EXECUTABLE=/usr/local/lib/python2.7.12/bin/python
export PYTHON2_LIBRARIES=/usr/local/lib/python2.7.12/lib/libpython2.7.so
export PYTHON2_PACKAGES_PATH=/usr/local/lib/python2.7.12/lib/python2.7/site-packages/
export PYTHON2_NUMPY_INCLUDE_DIRS=/usr/local/lib/python2.7.12/lib/python2.7/site-packages/numpy/core/include/
export PYTHON2_INCLUDE_DIR=/usr/local/lib/python2.7.12/include/python2.7/

git clone https://github.com/opencv/opencv
cd opencv
mkdir build
cd build

#
# build opencv for python 2
#
export PYTHON_DEFAULT_EXECUTABLE=/usr/local/lib/python2.7.12/bin/python
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/lib/python2.7.12 \
    -D BUILD_opencv_python2=ON ..

make -j24
make install

unset PYTHON2_EXECUTABLE
unset PYTHON2_LIBRARIES
unset PYTHON2_PACKAGES_PATH
unset PYTHON2_NUMPY_INCLUDE_DIRS
unset PYTHON2_INCLUDE_DIR
set -e PYTHON2_EXECUTABLE
set -e PYTHON2_LIBRARIES
set -e PYTHON2_PACKAGES_PATH
set -e PYTHON2_NUMPY_INCLUDE_DIRS
set -e PYTHON2_INCLUDE_DIR
export PYTHON3_EXECUTABLE=/usr/local/lib/python3.5.2/bin/python3
export PYTHON3_LIBRARIES=/usr/local/lib/python3.5.2/lib/libpython3.5m.so
export PYTHON3_PACKAGES_PATH=/usr/local/lib/python3.5.2/lib/python3.5/site-packages/
export PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.5.2/lib/python3.5/site-packages/numpy/core/include/
export PYTHON3_INCLUDE_DIR=/usr/local/lib/python3.5.2/include/python3.5m/

#
# build opencv for python 3
#
cd ..
mkdir build2
cd build2
export PYTHON_DEFAULT_EXECUTABLE=/usr/local/lib/python3.5.2/bin/python3
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/lib/python3.5.2 \
    -D BUILD_opencv_python3=ON ..
make -j24
make install
cd ../..
ln -s /dev/null /dev/raw1394

python -c "import cv2; print cv2.__version__"
python3 -c "import cv2; print(cv2.__version__)"
