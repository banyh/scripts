#!/usr/bin/fish

##################################################
# Following scripts are executed as super user   #
##################################################
sudo su -

# update apt-get before anything
apt-get update

# install misc tools
apt-get -y install htop sshfs

# install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker start

# install some build dependencies
apt-get install -y \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 \
libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-mox3 python-pil python-ply quilt \
tk-dev zlib1g-dev

# install python 2.7.11
wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
tar xfz Python-2.7.11.tgz
rm -f Python-2.7.11.tgz
cd Python-2.7.11/
./configure --prefix /usr/local/lib/python2.7.11 --enable-ipv6
make -j8
make install
cd ..
ln -sf /usr/local/lib/python2.7.11/bin/python /usr/local/bin/python
ln -sf /usr/local/lib/python2.7.11/bin/python /usr/local/bin/python2
hash -d python
curl https://bootstrap.pypa.io/get-pip.py | python
ln -sf /usr/local/lib/python2.7.11/bin/pip /usr/local/bin/pip

# install python 3.5.1
wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz
tar xfz Python-3.5.1.tgz
rm -f Python-3.5.1.tgz
cd Python-3.5.1/
./configure --prefix /usr/local/lib/python3.5.1 --enable-ipv6
make -j8
make install
cd ..
ln -sf /usr/local/lib/python3.5.1/bin/python3 /usr/local/bin/python3
hash -d python3
curl https://bootstrap.pypa.io/get-pip.py | python3
ln -sf /usr/local/lib/python3.5.1/bin/pip3 /usr/local/bin/pip3

# install tensorflow for python 2.7
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL

# install tensorflow for python 3.5
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp35-cp35m-linux_x86_64.whl
pip3 install --upgrade $TF_BINARY_URL

# install Python packages
pip install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs
pip3 install scipy nltk gensim janome konlpy jieba pandas jupyter django virtualenv mkdocs

# install scikit-learn
pip install scikit-learn
pip3 install scikit-learn

# install FISH
apt-add-repository ppa:fish-shell/release-2
apt-get -y update
apt-get -y install fish
apt-get -y upgrade fish

# install open-jdk 8
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get -y install openjdk-8-jdk

##################################################
# Following scripts are executed as normal user  #
##################################################

exit  # exit sudo su -

# simple config for fish
mkdir -p ~/.config/fish
echo "alias ll 'ls -laF'" >> ~/.config/fish/config.fish
echo "alias l 'ls -ACF'" >> ~/.config/fish/config.fish
chsh --shell /usr/bin/fish

# get rmate
mkdir ~/bin
curl -Lo ~/bin/rmate https://raw.githubusercontent.com/textmate/rmate/master/bin/rmate
chmod a+x ~/bin/rmate

# set up jupyter notebook
jupyter notebook --generate-config
echo >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '0.0.0.0'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = u'/home/bany'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> .jupyter/jupyter_notebook_config.py
