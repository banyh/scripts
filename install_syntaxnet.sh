#!/bin/sh
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
echo 'Bob brought the pizza to Alice.' | bash parse.sh /media/tensorflow/parsey_universal/English
echo '球 從 天上 掉 下來' | bash parse.sh /media/tensorflow/parsey_universal/Chinese
echo '球從天上掉下來' | bash tokenize_zh.sh
