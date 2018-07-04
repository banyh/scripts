wget http://sourceforge.net/projects/boost/files/boost/1.65.1/boost_1_65_1.tar.gz
tar xvfz boost_1_65_1.tar.gz
rm -f boost_1_65_1.tar.gz

PYTHON2_VERSION=2.7.15
PYTHON3_VERSION=3.6.6

cd boost_1_65_1
export CPLUS_INCLUDE_PATH=/usr/local/lib/python$PYTHON2_VERSION/include/python2.7
./bootstrap.sh --with-python=python --with-python-root=/usr/local/lib/python$PYTHON2_VERSION
./b2 stage threading=multi link=shared
./b2 install threading=multi link=shared

export CPLUS_INCLUDE_PATH=/usr/local/lib/python$PYTHON3_VERSION/include/python3.6m
./b2 --clean
./bootstrap.sh --with-python=python3 --with-python-root=/usr/local/lib/python$PYTHON3_VERSION
./b2 stage threading=multi link=shared
cp stage/lib/libboost_python3* /usr/local/lib/
cp stage/lib/libboost_numpy3.so* /usr/local/lib
cd ..
