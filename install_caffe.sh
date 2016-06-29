###################################################
# All following instructions are executed as root #
###################################################
sudo su -

###################################################
# install ffmpeg - may take 20 minutes
###################################################

wget https://gist.githubusercontent.com/xdamman/e4f713c8cd1a389a5917/raw/7ebe0b7010ad59a61ddccf5c455d226c843584dc/install_ffmpeg_ubuntu.sh
sh install_ffmpeg_ubuntu.sh

###################################################
# install opencv - may take 20 minutes
###################################################

wget https://raw.githubusercontent.com/milq/scripts-ubuntu-debian/master/install-opencv.sh
sh install-opencv.sh

###################################################
# install caffe
###################################################

apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get -y install --no-install-recommends libboost-all-dev
apt-get -y install libatlas-base-dev
apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev

cd ~
git clone https://github.com/BVLC/caffe
