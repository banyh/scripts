wget http://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz
tar xvfz boost_1_61_0.tar.gz
rm -f boost_1_61_0.tar.gz

cd boost_1_61_0
./bootstrap.sh --with-python=python --with-python-root=/usr/local/lib/python2.7.12
./b2 install threading=multi link=shared

./bootstrap.sh --with-python=python3 --with-python-root=/usr/local/lib/python3.5.2
./b2 install threading=multi link=shared
cd ..
