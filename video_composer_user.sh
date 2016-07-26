#!/bin/sh

#
# download ssh key: private key ~/.ssh/id_rsa and public key ~/.ssh/id_rsa.pub
#
cd ~/.ssh
wget somewhere_host_my_key/id_rsa
wget somewhere_host_my_key/id_rsa.pub
wget somewhere_host_my_key/known_hosts
chmod 400 id_rsa
cd ..


#
# clone video composer
#
export PATH=/usr/local/lib/python2.7.11/bin:$PATH
git clone git@github.com:livingbio/video-compose-demo.git
cd video-compose-demo
virtualenv venv
source venv/bin/activate
cp src/gliastudio_demo_site/settings/local.sample.env src/gliastudio_demo_site/settings/local.env
cd ..


#
# install pygame
#
hg clone https://bitbucket.org/pygame/pygame
cd pygame
python setup.py build
sudo python setup.py install  # must install a copy to system library
python setup.py install  # install to virtual environment library
cd ..


#
# install requirements for video composer
#
cd video-compose-demo
pip install --upgrade Cython==0.23
pip install kivy
pip install crypto mox3 ply cffi
pip install -r requirements.txt


#
#
#
cd src
python recordscreen.py
