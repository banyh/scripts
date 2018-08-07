#!/bin/sh

pip install scipy nltk gensim pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim pandas jupyter django virtualenv mkdocs

pip install scikit-learn matplotlib scikit-image scikit-video
pip3 install scikit-learn matplotlib scikit-image scikit-video

python -m ipykernel install --user
python3 -m ipykernel install --user

apt-get install -y libxml2-dev libxslt1-dev python-dev

pip install lxml bs4 pymongo pulp gevent crcmod autopep8 flashtext spacy
pip3 install lxml bs4 pymongo pulp gevent crcmod autopep8 flashtext spacy

# --------------------------------------------------
# Machine Learning: lightgbm
# --------------------------------------------------

apt-get install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler

pip install lightgbm --install-option=--gpu --install-option="--opencl-include-dir=/usr/local/cuda/include/" --install-option="--opencl-library=/usr/local/cuda/lib64/libOpenCL.so"
pip3 install lightgbm --install-option=--gpu --install-option="--opencl-include-dir=/usr/local/cuda/include/" --install-option="--opencl-library=/usr/local/cuda/lib64/libOpenCL.so"

# --------------------------------------------------
# Machine Learning: tensorflow
# --------------------------------------------------

pip install tensorflow-gpu keras h5py
pip3 install tensorflow-gpu keras h5py

# --------------------------------------------------
# Machine Learning: pytorch
# --------------------------------------------------

pip install torch torchvision
pip3 install torch torchvision

apt install -y sox libsox-dev libsox-fmt-all
pip install librosa
pip install git+https://github.com/pytorch/audio
pip install git+https://github.com/pytorch/text
pip3 install librosa
pip3 install git+https://github.com/pytorch/audio
pip3 install git+https://github.com/pytorch/text

# Check if CUDA and CUDNN are correctly installed and used by pytorch
python -c "from torch import cuda; print 'CUDA available:', cuda.is_available()"
python -c "import torch; print 'CUDA version:', torch.version.cuda"
python -c "from torch import cuda; print 'CUDA device 0:', cuda.get_device_name(0)"
python -c "from torch.backends import cudnn; print 'CUDNN version:', cudnn.version()"
python3 -c "from torch import cuda; print('CUDA available:', cuda.is_available())"
python3 -c "import torch; print('CUDA version:', torch.version.cuda)"
python3 -c "from torch import cuda; print('CUDA device 0:', cuda.get_device_name(0))"
python3 -c "from torch.backends import cudnn; print('CUDNN version:', cudnn.version())"
