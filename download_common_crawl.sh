wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-15/wet.paths.gz -O CC-MAIN-2014-15.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-23/wet.paths.gz -O CC-MAIN-2014-23.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-35/wet.paths.gz -O CC-MAIN-2014-35.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-41/wet.paths.gz -O CC-MAIN-2014-41.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-42/wet.paths.gz -O CC-MAIN-2014-42.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-49/wet.paths.gz -O CC-MAIN-2014-49.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2014-52/wet.paths.gz -O CC-MAIN-2014-52.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-06/wet.paths.gz -O CC-MAIN-2015-06.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-11/wet.paths.gz -O CC-MAIN-2015-11.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-14/wet.paths.gz -O CC-MAIN-2015-14.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-18/wet.paths.gz -O CC-MAIN-2015-18.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-22/wet.paths.gz -O CC-MAIN-2015-22.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-27/wet.paths.gz -O CC-MAIN-2015-27.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-32/wet.paths.gz -O CC-MAIN-2015-32.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-35/wet.paths.gz -O CC-MAIN-2015-35.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-40/wet.paths.gz -O CC-MAIN-2015-40.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2015-48/wet.paths.gz -O CC-MAIN-2015-48.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2016-07/wet.paths.gz -O CC-MAIN-2016-07.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2016-18/wet.paths.gz -O CC-MAIN-2016-18.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2016-22/wet.paths.gz -O CC-MAIN-2016-22.gz
wget https://commoncrawl.s3.amazonaws.com/crawl-data/CC-MAIN-2016-26/wet.paths.gz -O CC-MAIN-2016-26.gz
gunzip *.gz
sed -i 's/crawl-data/https:\/\/commoncrawl.s3.amazonaws.com\/crawl-data/g' CC*

wget -i CC-MAIN-2014-15
wget -i CC-MAIN-2014-23
wget -i CC-MAIN-2014-35
wget -i CC-MAIN-2014-41
wget -i CC-MAIN-2014-42
wget -i CC-MAIN-2014-49
wget -i CC-MAIN-2014-52
wget -i CC-MAIN-2015-06
wget -i CC-MAIN-2015-11
wget -i CC-MAIN-2015-14
wget -i CC-MAIN-2015-18
wget -i CC-MAIN-2015-22
wget -i CC-MAIN-2015-27
wget -i CC-MAIN-2015-32
wget -i CC-MAIN-2015-35
wget -i CC-MAIN-2015-40
wget -i CC-MAIN-2015-48
wget -i CC-MAIN-2016-07
wget -i CC-MAIN-2016-18
wget -i CC-MAIN-2016-22
wget -i CC-MAIN-2016-26
gunzip *.gz
