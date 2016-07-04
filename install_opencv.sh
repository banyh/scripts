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

wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/3.0.0/opencv-3.0.0.zip
unzip opencv-3.0.0.zip
rm opencv-3.0.0.zip

export PYTHON2_EXECUTABLE=/usr/local/lib/python2.7.11/bin/python
export PYTHON2_LIBRARIES=/usr/local/lib/python2.7.11/lib/libpython2.7.so
export PYTHON2_PACKAGES_PATH=/usr/local/lib/python2.7.11/lib/python2.7/site-packages/
export PYTHON2_NUMPY_INCLUDE_DIRS=/usr/local/lib/python2.7.11/lib/python2.7/site-packages/numpy/core/include/
export PYTHON2_INCLUDE_DIR=/usr/local/lib/python2.7.11/include/python2.7/

export PYTHON3_EXECUTABLE=/usr/local/lib/python3.5.1/bin/python3
export PYTHON3_LIBRARIES=/usr/local/lib/python3.5.1/lib/libpython3.5m.so
export PYTHON3_PACKAGES_PATH=/usr/local/lib/python3.5.1/lib/python3.5/site-packages/
export PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.5.1/lib/python3.5/site-packages/numpy/core/include/
export PYTHON3_INCLUDE_DIR=/usr/local/lib/python3.5.1/include/python3.5m/

cd opencv-3.0.0
mkdir build
cd build

#
# build opencv for python 2
#
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/lib/python2.7.11 \
    -D BUILD_opencv_python2=ON ..

make -j16
make install

#
# build opencv for python 3
#
cd ..
mkdir build2
cd build2
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/lib/python3.5.1 \
    -D BUILD_opencv_python3=ON ..
make -j16
make install

python -c "import cv2; print cv2.__version__"
python3 -c "import cv2; print(cv2.__version__)"
