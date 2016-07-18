#!/bin/sh

#
# METEOR: a metric for machine translation
#
cd /media
mkdir metric
cd metric
wget http://www.cs.cmu.edu/~alavie/METEOR/download/meteor-1.5.tar.gz
tar xzf meteor-1.5.tar.gz
cd meteor-1.5
ant  # apt-get install ant
echo '#!/bin/sh' > meteor.sh
echo 'java -Xmx2G -jar /media/metric/meteor-1.5/meteor-1.5.jar $1 $2 -l en -norm -q' >> meteor.sh
chmod +x meteor.sh
mv meteor.sh /usr/local/bin


#
# Tensorflow VGG16 and VGG19
#
git clone https://github.com/machrisaa/tensorflow-vgg
cd tensorflow-vgg
wget https://dl.dropboxusercontent.com/u/50333326/vgg16.npy
wget https://dl.dropboxusercontent.com/u/50333326/vgg19.npy
python test_vgg16.py
python test_vgg19.py

