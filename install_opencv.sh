cd ~
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.0.0

cd ~
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.0.0

cd ~/opencv
wget https://raw.githubusercontent.com/Itseez/opencv/f88e9a748a37e5df00912524e590fb295e7dab70/modules/videoio/src/cap_ffmpeg_impl.hpp
cp -f cap_ffmpeg_impl.hpp modules/videoio/src/cap_ffmpeg_impl.hpp

mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

make -j8
make install
ldconfig
cp /usr/lib/python2.7/dist-packages/cv2.so /usr/local/lib/python2.7.11/lib/python2.7/site-packages/cv2.so
cp /usr/lib/python2.7/dist-packages/cv.py /usr/local/lib/python2.7.11/lib/python2.7/site-packages/cv.py
ln /dev/null /dev/raw1394
