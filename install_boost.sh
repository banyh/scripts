wget http://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz
tar xvfz boost_1_63_0.tar.gz
rm -f boost_1_63_0.tar.gz

cd boost_1_63_0
export CPLUS_INCLUDE_PATH=/usr/local/lib/python2.7.13/include/python2.7
./bootstrap.sh --with-python=python --with-python-root=/usr/local/lib/python2.7.13
./b2 stage threading=multi link=shared
./b2 install threading=multi link=shared

export CPLUS_INCLUDE_PATH=/usr/local/lib/python3.6.2/include/python3.6m
./b2 --clean
./bootstrap.sh --with-python=python3 --with-python-root=/usr/local/lib/python3.6.2
./b2 stage threading=multi link=shared
cp stage/lib/libboost_python3* /usr/local/lib/
cp stage/lib/libboost_numpy3.so* /usr/local/lib
cd ..
