# before installing, you must make sure java is version 8
# use 'update-alternatives --config java' to select correct version

cd ~
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

git clone https://github.com/banyh/StanfordPostagServer
cd StanfordPostagServer
sh install.sh
cd ..

git clone https://github.com/banyh/StanfordSegmenterServer
cd StanfordSegmenterServer
sh install.sh
cd ..

git clone https://github.com/banyh/StanfordParserServer
cd StanfordParserServer
sh install.sh
cd ..
