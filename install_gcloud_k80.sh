wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64-deb -O cuda_8.0.deb
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb -O cuda_8.0_update.deb

dpkg -i cuda_8.0.deb
dpkg -i cuda_8.0_update.deb
apt-get update
apt-get -y install cuda
apt-get install linux-headers-$(uname -r) -y

# ----------- 出現 libEGL not a symbolic link 的解法(不確定是否必要) ------------
mv /usr/lib/nvidia-384/libEGL.so.1 /usr/lib/nvidia-384/libEGL.so.1.org
mv /usr/lib32/nvidia-384/libEGL.so.1 /usr/lib32/nvidia-384/libEGL.so.1.org
ln -s /usr/lib/nvidia-384/libEGL.so.384.90 /usr/lib/nvidia-384/libEGL.so.1
ln -s /usr/lib32/nvidia-384/libEGL.so.384.90 /usr/lib32/nvidia-384/libEGL.so.1
# -------------------------------------------------------------------------------

wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn5_5.1.10-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn5-dev_5.1.10-1%2Bcuda8.0_amd64.deb
wget https://storage.googleapis.com/gliacloud-package/cudnn_ubuntu_14.04/libcudnn6-dev_6.0.21-1%2Bcuda8.0_amd64.deb

dpkg -i libcudnn5_5.1.10-1+cuda8.0_amd64.deb
dpkg -i libcudnn6_6.0.21-1+cuda8.0_amd64.deb
dpkg -i libcudnn5-dev_5.1.10-1+cuda8.0_amd64.deb
dpkg -i libcudnn6-dev_6.0.21-1+cuda8.0_amd64.deb

#
# Install caffe
#

apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev python-dev
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev cmake git gfortran

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
hash -r
pip install scikit-image protobuf
pip uninstall -y matplotlib
apt-get install python-matplotlib

git clone https://github.com/BVLC/caffe
cd caffe
mkdir build
cd build
# with GPU and CUDA
cmake -DCPU_ONLY=0 -DUSE_OPENCV=0 -DUSE_CUDNN=1 -DBLAS=open \
      -DPYTHON_EXECUTABLE=/usr/bin/python \
      -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
      -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
      -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
      -DCUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.5 \
      -DCUDNN_INCLUDE=/usr/include \
      ..
make -j4
make install
cp -r install/python/caffe /usr/lib/python2.7/dist-packages
cp lib/*.* /usr/local/lib/
ldconfig


#
# 安裝 img2vec_service，需要有新版的 setuptools 才能正確安裝
#
pip install git+ssh://git@github.com/livingbio/img2vec_service.git#egg=img2vec_service
pip install -U Pillow bottle raven requests six ipython

python -c "from img2vec_service import image_class; print image_class(['reflex_camera.jpg', 'daisy.jpg', 'jellyfish.jpg'])"
# 正確輸出為 3x5 的 string array，第一行為 'n04069434 reflex camera' 'n11939491 daisy' 'n01910747 jellyfish'
# 在ipython中輸入 %timeit image_class(['reflex_camera.jpg', 'daisy.jpg', 'jellyfish.jpg']) 結果為1.8~1.9秒

export IMG2VEC_DEVICE=gpu
export IMG2VEC_BATCH_SIZE=10
export IMG2VEC_MODEL=resnet
# 在ipython中輸入 %timeit image_class(['reflex_camera.jpg', 'daisy.jpg', 'jellyfish.jpg']) 結果為210ms
