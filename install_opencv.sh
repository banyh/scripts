apt-get -y install build-essential cmake git pkg-config
apt-get -y install libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev
apt-get -y install libgtk2.0-dev
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get -y install libatlas-base-dev gfortran

pip install opencv-python
pip3 install opencv-python

python -c "import cv2; print cv2.__version__"
python3 -c "import cv2; print(cv2.__version__)"
