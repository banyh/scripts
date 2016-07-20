wget http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
tar xvfz boost_1_59_0.tar.gz
rm -f boost_1_59_0.tar.gz

cd boost_1_59_0
./bootstrap.sh
./b2 install
cd ..
