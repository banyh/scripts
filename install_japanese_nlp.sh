#
# Install Juman library
#
wget "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2&name=juman-7.01.tar.bz2" -O juman-7.01.tar.bz2
bunzip2 juman-7.01.tar.bz2
tar xvf juman-7.01.tar
rm juman-7.01.tar
cd juman-7.01
./configure
make -j24
sudo make install
sudo apt-get install libjuman4
cd ..
echo "今日は晴れです。" | juman

#
# Install KNP
#
sudo apt-get install TinyCDB
wget "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.16.tar.bz2&name=knp-4.16.tar.bz2" -O knp-4.16.tar.bz2
bunzip2 knp-4.16.tar.bz2
tar xvf knp-4.16.tar
rm knp-4.16.tar
cd knp-4.16
./configure
make -j24
sudo make install
cd ..
echo "今日は晴れです。" | juman | knp

#
# Install pyknp
#
wget "http://nlp.ist.i.kyoto-u.ac.jp/DLcounter/lime.cgi?down=http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/pyknp-0.22.tar.gz&name=pyknp-0.22.tar.gz" -O pyknp-0.22.tar.gz
tar xvfz pyknp-0.22.tar.gz
rm pyknp-0.22.tar.gz
cd pyknp-0.22
python setup.py install
cd ..

#
# Start Juman server on localhost
#
juman -S -N 12345
python -c "from pyknp import Juman; juman = Juman(server='localhost', port=12345); print len(juman.analysis(u'これはペンです。'))"

#
# Start KNP server on localhost
#
knp -S -N 12344
python -c "from pyknp import KNP; knp = KNP(server='localhost', port=12344); print len(knp.parse(u'これはペンです。'))"
