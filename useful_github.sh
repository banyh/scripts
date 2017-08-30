#!/bin/sh

pip install git+ssh://git@github.com/livingbio/pyknp.git

wget https://github.com/bazelbuild/bazel/releases/download/0.4.3/bazel-0.4.3-installer-linux-x86_64.sh
chmod +x bazel-0.4.3-installer-linux-x86_64.sh
./bazel-0.4.3-installer-linux-x86_64.sh --user
rm bazel-0.4.3-installer-linux-x86_64.sh
export PATH="$PATH:$HOME/bin"
apt-get -y install swig unzip
pip install tensorflow protobuf asciitree mock virtualenv

pip install git+ssh://git@github.com/livingbio/syntaxnet_wrapper.git
pip install git+ssh://git@github.com/livingbio/zhconvert.git
pip install git+ssh://git@github.com/livingbio/gliacloud_api_client.git
pip install git+ssh://git@github.com/livingbio/img2vec_service.git

pip install git+ssh://git@github.com/livingbio/word2vec_service.git@jenkins
pip install git+ssh://git@github.com/livingbio/parser_service.git@jenkins

apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty stable"
apt-get update
apt-get install docker-ce
docker run -d -p 8080:8080 gliacloud/stanfordnlpserver