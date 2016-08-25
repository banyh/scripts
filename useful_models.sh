#!/bin/sh

#
# vGG Net pretrained models
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
# Tensorflow VGG16 and VGG19
#
cd /media
mkdir tensorflow
git clone https://github.com/machrisaa/tensorflow-vgg
mv tensorflow-vgg vgg
cd vgg
wget https://dl.dropboxusercontent.com/u/50333326/vgg16.npy
wget https://dl.dropboxusercontent.com/u/50333326/vgg19.npy
python test_vgg16.py
python test_vgg19.py

#
# Caffe reference model
#
cd /media/caffe
wget http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel
wget https://raw.githubusercontent.com/BVLC/caffe/master/models/bvlc_reference_caffenet/deploy.prototxt
wget https://github.com/BVLC/caffe/raw/master/python/caffe/imagenet/ilsvrc_2012_mean.npy

#
# ResNet pretrained models
#
cd /media/caffe
wget https://gliacloud.blob.core.windows.net/nlp/ResNet.tgz
tar xzf ResNet.tgz
rm ResNet.tgz

#
# Tensorflow ResNet
#
cd /media/tensorflow
wget https://gliacloud.blob.core.windows.net/nlp/tensorflow-resnet.tgz
tar xvfz tensorflow-resnet.tgz
rm tensorflow-resnet.tgz
mv tensorflow-resnet resnet
cd resnet
python forward.py

#
# word vectors from word2vec
#
mkdir wordvec
cd wordvec
wget https://gliacloud.blob.core.windows.net/nlp/GoogleNews-vectors-negative300.bin.gz
gunzip GoogleNews-vectors-negative300.bin.gz
wget https://gliacloud.blob.core.windows.net/nlp/jawiki.tar.gz
tar xzf jawiki.tar.gz
rm jawiki.tar.gz
wget https://gliacloud.blob.core.windows.net/nlp/zhwiki_stanford.tar.gz
tar xzf zhwiki_stanford.tar.gz
rm zhwiki_stanford.tar.gz
wget https://gliacloud.blob.core.windows.net/nlp/twwiki_stan_dict.tgz
tar xzf twwiki_stan_dict.tgz
rm twwiki_stan_dict.tgz

#
# word vectors from fasttext
#
wget https://gliacloud.blob.core.windows.net/nlp/twwiki_fasttext.tgz
tar xzf twwiki_fasttext.tgz
rm twwiki_fasttext.tgz
wget https://gliacloud.blob.core.windows.net/nlp/enwiki_fasttext.tgz
tar xzf enwiki_fasttext.tgz
rm enwiki_fasttext.tgz
wget https://gliacloud.blob.core.windows.net/nlp/jawiki_fasttext.tgz
tar xzf jawiki_fasttext.tgz
rm jawiki_fasttext.tgz
cd ..

#
# Parsey's Cousins: A collection of pretrained syntactic models
#
cd /media
mkdir parsey_universal
cd parsey_universal
wget http://download.tensorflow.org/models/parsey_universal/Ancient_Greek-PROIEL.zip
wget http://download.tensorflow.org/models/parsey_universal/Ancient_Greek.zip
wget http://download.tensorflow.org/models/parsey_universal/Arabic.zip
wget http://download.tensorflow.org/models/parsey_universal/Basque.zip
wget http://download.tensorflow.org/models/parsey_universal/Bulgarian.zip
wget http://download.tensorflow.org/models/parsey_universal/Catalan.zip
wget http://download.tensorflow.org/models/parsey_universal/Chinese.zip
wget http://download.tensorflow.org/models/parsey_universal/Croatian.zip
wget http://download.tensorflow.org/models/parsey_universal/Czech-CAC.zip
wget http://download.tensorflow.org/models/parsey_universal/Czech-CLTT.zip
wget http://download.tensorflow.org/models/parsey_universal/Czech.zip
wget http://download.tensorflow.org/models/parsey_universal/Danish.zip
wget http://download.tensorflow.org/models/parsey_universal/Dutch-LassySmall.zip
wget http://download.tensorflow.org/models/parsey_universal/Dutch.zip
wget http://download.tensorflow.org/models/parsey_universal/English-LinES.zip
wget http://download.tensorflow.org/models/parsey_universal/English.zip
wget http://download.tensorflow.org/models/parsey_universal/Estonian.zip
wget http://download.tensorflow.org/models/parsey_universal/Finnish-FTB.zip
wget http://download.tensorflow.org/models/parsey_universal/Finnish.zip
wget http://download.tensorflow.org/models/parsey_universal/French.zip
wget http://download.tensorflow.org/models/parsey_universal/Galician.zip
wget http://download.tensorflow.org/models/parsey_universal/German.zip
wget http://download.tensorflow.org/models/parsey_universal/Gothic.zip
wget http://download.tensorflow.org/models/parsey_universal/Greek.zip
wget http://download.tensorflow.org/models/parsey_universal/Hebrew.zip
wget http://download.tensorflow.org/models/parsey_universal/Hindi.zip
wget http://download.tensorflow.org/models/parsey_universal/Hungarian.zip
wget http://download.tensorflow.org/models/parsey_universal/Indonesian.zip
wget http://download.tensorflow.org/models/parsey_universal/Irish.zip
wget http://download.tensorflow.org/models/parsey_universal/Italian.zip
wget http://download.tensorflow.org/models/parsey_universal/Kazakh.zip
wget http://download.tensorflow.org/models/parsey_universal/Latin-ITTB.zip
wget http://download.tensorflow.org/models/parsey_universal/Latin-PROIEL.zip
wget http://download.tensorflow.org/models/parsey_universal/Latin.zip
wget http://download.tensorflow.org/models/parsey_universal/Latvian.zip
wget http://download.tensorflow.org/models/parsey_universal/Norwegian.zip
wget http://download.tensorflow.org/models/parsey_universal/Old_Church_Slavonic.zip
wget http://download.tensorflow.org/models/parsey_universal/Persian.zip
wget http://download.tensorflow.org/models/parsey_universal/Polish.zip
wget http://download.tensorflow.org/models/parsey_universal/Portuguese-BR.zip
wget http://download.tensorflow.org/models/parsey_universal/Portuguese.zip
wget http://download.tensorflow.org/models/parsey_universal/Romanian.zip
wget http://download.tensorflow.org/models/parsey_universal/Russian-SynTagRus.zip
wget http://download.tensorflow.org/models/parsey_universal/Russian.zip
wget http://download.tensorflow.org/models/parsey_universal/Slovenian-SST.zip
wget http://download.tensorflow.org/models/parsey_universal/Slovenian.zip
wget http://download.tensorflow.org/models/parsey_universal/Spanish-AnCora.zip
wget http://download.tensorflow.org/models/parsey_universal/Spanish.zip
wget http://download.tensorflow.org/models/parsey_universal/Swedish-LinES.zip
wget http://download.tensorflow.org/models/parsey_universal/Swedish.zip
wget http://download.tensorflow.org/models/parsey_universal/Tamil.zip
wget http://download.tensorflow.org/models/parsey_universal/Turkish.zip
for f in *.zip; unzip $f; end for  # this is FISH syntax
for dir in *; cd $dir; chmod 644 *; cd ..; end for
chmod 755 *
rm *.zip

#
# SyntaxNet (installed as a normal user)
#
cd ~
wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel-0.2.2b-installer-linux-x86_64.sh
chmod +x bazel-0.2.2b-installer-linux-x86_64.sh
./bazel-0.2.2b-installer-linux-x86_64.sh --user
rm bazel-0.2.2b-installer-linux-x86_64.sh
set PATH $PATH ~/bin
sudo apt-get -y install swig
sudo pip install -U protobuf==3.0.0b2
sudo pip install asciitree
###
git clone --recursive https://github.com/tensorflow/models.git
cd models/syntaxnet/tensorflow
./configure
cd ..
bazel test syntaxnet/... util/utf8/...
cp syntaxnet/models/parsey_universal/*.sh .
echo 'Bob brought the pizza to Alice.' | bash parse.sh /media/parsey_universal/English
echo '球 從 天上 掉 下來' | bash parse.sh /media/parsey_universal/Chinese
echo '球從天上掉下來' | bash tokenize_zh.sh
