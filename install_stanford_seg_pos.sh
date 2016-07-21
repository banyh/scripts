# before installing, you must make sure java is version 8
# use 'update-alternatives --config java' to select correct version

cd ~
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

wget http://nlp.stanford.edu/software/stanford-postagger-full-2015-12-09.zip
unzip stanford-postagger-full-2015-12-09.zip
rm -f stanford-postagger-full-2015-12-09.zip
git clone https://github.com/banyh/StanfordPostagServer
cp StanfordPostagServer/* stanford-postagger-full-2015-12-09/
rm -rf StanfordPostagServer
cd stanford-postagger-full-2015-12-09
sh install.sh
sh make.sh
nohup sh run.sh &
cd ..

wget http://nlp.stanford.edu/software/stanford-segmenter-2015-12-09.zip
unzip stanford-segmenter-2015-12-09.zip
rm -f stanford-segmenter-2015-12-09.zip
git clone https://github.com/banyh/StanfordSegmenterServer
cp StanfordSegmenterServer/* stanford-segmenter-2015-12-09/
rm -rf StanfordSegmenterServer
cd stanford-segmenter-2015-12-09
sh install.sh
sh make.sh
nohup sh run.sh &
cd ..

ps x | grep java
