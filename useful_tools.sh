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


