#!/bin/sh

pip install scipy nltk gensim pandas jupyter django virtualenv mkdocs scikit-learn matplotlib scikit-image scikit-video

python -m ipykernel install --user

apt-get install -y libxml2-dev libxslt1-dev python-dev

pip install lxml bs4 pymongo pulp gevent crcmod autopep8 flashtext spacy

# --------------------------------------------------
# Machine Learning: lightgbm
# --------------------------------------------------

apt-get install -y --no-install-recommends libboost-all-dev libopenblas-dev liblapack-dev
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler

pip install lightgbm --install-option=--gpu --install-option="--opencl-include-dir=/usr/local/cuda/include/" --install-option="--opencl-library=/usr/local/cuda/lib64/libOpenCL.so"

# --------------------------------------------------
# Machine Learning: tensorflow
# --------------------------------------------------

# Only nightly version support Python 3.7
pip install tf-nightly-gpu

# --------------------------------------------------
# Machine Learning: pytorch
# --------------------------------------------------

# CUDA 10.0 and Python 3.7
pip install https://download.pytorch.org/whl/cu100/torch-1.0.0-cp37-cp37m-linux_x86_64.whl
pip install torchvision

apt install -y sox libsox-dev libsox-fmt-all
pip install librosa
pip install git+https://github.com/pytorch/audio
pip install git+https://github.com/pytorch/text

# Check if CUDA and CUDNN are correctly installed and used by pytorch
python -c "from torch import cuda; print('CUDA available:', cuda.is_available())"
python -c "import torch; print('CUDA version:', torch.version.cuda)"
python -c "from torch import cuda; print('CUDA device 0:', cuda.get_device_name(0))"
python -c "from torch.backends import cudnn; print('CUDNN version:', cudnn.version())"
