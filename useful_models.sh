#!/bin/sh

#
# vGG Net pretrained model
# http://www.robots.ox.ac.uk/%7Evgg/research/very_deep/
#
cd /media
mkdir caffe
cd caffe
wget http://www.robots.ox.ac.uk/~vgg/software/very_deep/caffe/VGG_ILSVRC_16_layers.caffemodel
wget https://gist.githubusercontent.com/ksimonyan/211839e770f7b538e2d8/raw/0067c9b32f60362c74f4c445a080beed06b07eb3/VGG_ILSVRC_16_layers_deploy.prototxt
wget http://www.robots.ox.ac.uk/~vgg/software/very_deep/caffe/VGG_ILSVRC_19_layers.caffemodel
wget https://gist.githubusercontent.com/ksimonyan/3785162f95cd2d5fee77/raw/f02f8769e64494bcd3d7e97d5d747ac275825721/VGG_ILSVRC_19_layers_deploy.prototxt

#
# Caffe reference model
#
wget http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel
wget https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_reference_caffenet/deploy.prototxt
wget https://github.com/BVLC/caffe/raw/master/python/caffe/imagenet/ilsvrc_2012_mean.npy
cd ..

#
# word vectors from word2vec and GloVe
#
mkdir wordvec
cd wordvec
wget https://gliacloud.blob.core.windows.net/nlp/GoogleNews-vectors-negative300.bin.gz
gunzip GoogleNews-vectors-negative300.bin.gz
wget https://gliacloud.blob.core.windows.net/nlp/jawiki.tar.gz
wget https://gliacloud.blob.core.windows.net/nlp/zhwiki_stanford.tar.gz
tar xzf zhwiki_stanford.tar.gz
rm zhwiki_stanford.tar.gz
tar xzf jawiki.tar.gz
rm jawiki.tar.gz

wget http://nlp.stanford.edu/data/glove.6B.zip
wget http://nlp.stanford.edu/data/glove.42B.300d.zip
wget http://nlp.stanford.edu/data/glove.840B.300d.zip
apt-get -y install unzip
unzip glove.6B.zip
unzip glove.42B.300d.zip
unzip glove.840B.300d.zip
rm -f *.zip
cd ..
