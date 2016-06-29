cd ~
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.0.0

cd ~
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.0.0

cd ~/opencv
#
# Edit: opencv/modules/videoio/src/cap_ffmpeg_impl.hpp
# replace "AVCodecID" with "CV_CODEC_ID" in line 1490:
#     from "AVCodecID c_id = c->codec_id;"
#     to   "CV_CODEC_ID c_id = c->codec_id;"
#
sed -Ei 's/AVCodecID c_id/CV_CODEC_ID c_id/' modules/videoio/src/cap_ffmpeg_impl.hpp

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
ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so
