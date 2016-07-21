## Setup up TensorFlow and Caffe environment on Ubuntu 14.04 with a GPU

### Checkout this repository

```shell-script
wget https://github.com/banyh/scripts/archive/master.zip
apt-get install unzip
unzip master.zip
cd scripts-master
chmod +x *.sh
```


### Install ffmpeg, git, Nvidia driver, then reboot

```shell-script
./new_machine_1.sh
```


### Install python, opencv, caffe, tensorflow

```shell-script
./new_machine_2.sh
```


## Validate the environment

### Validate OpenCV version

Following instructions should output two `3.1.0`.

```shell-script
python -c "import cv2; print cv2.__version__"
python3 -c "import cv2; print(cv2.__version__)"
```


### Validate Caffe

If you have enough time, go to Caffe build directory and type:

```shell-script
cd caffe/build
make -j16 runtest
```


### Validate TensorFlow

Run following instructions:

```shell-script
wget https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/models/image/mnist/convolutional.py
python convolutional.py
```

You should see following messages on K80 GPU:

```
successfully opened CUDA library libcublas.so locally
successfully opened CUDA library libcudnn.so locally
successfully opened CUDA library libcufft.so locally
successfully opened CUDA library libcuda.so locally
successfully opened CUDA library libcurand.so locally

Found device 0 with properties:
name: Tesla K80
major: 3 minor: 7 memoryClockRate (GHz) 0.8235
pciBusID 0000:83:00.0
Total memory: 11.25GiB
Free memory: 11.13GiB

Found device 1 with properties:
name: Tesla K80
major: 3 minor: 7 memoryClockRate (GHz) 0.8235
pciBusID 0000:84:00.0
Total memory: 11.25GiB
Free memory: 11.13GiB

Creating TensorFlow device (/gpu:0) -> (device: 0, name: Tesla K80, pci bus id: 0000:83:00.0)
Creating TensorFlow device (/gpu:1) -> (device: 1, name: Tesla K80, pci bus id: 0000:84:00.0)
```


### Validate Stanford pos-tagger and segmenter

You should see `service.endp.PosServicePublisher` and `service.endp.SegServicePublisher` are runned by `java`.

```shell-script
ps x | grep java
```

