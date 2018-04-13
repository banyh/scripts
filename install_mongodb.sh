apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
apt update
apt install -y mongodb-org

# 範例: 修改db的位置
# sed -i -- 's/  dbPath.*/  dbPath: \/srv\/mongodb/' /etc/mongod.conf
# 範例: 修改db的格式，改成推薦的wiredTiger
sed -i -- 's/#  engine.*/  engine: wiredTiger/' /etc/mongod.conf

service mongod start
systemctl enable mongod.service  # 設定為開機自動執行

# permanently set /sys/kernel/mm/transparent_hugepage/enabled to "never"
# permanently set /sys/kernel/mm/transparent_hugepage/defrag to "never"
apt -y install sysfsutils
echo "kernel/mm/transparent_hugepage/enabled = never" >> /etc/sysfs.conf
echo "kernel/mm/transparent_hugepage/defrag = never" >> /etc/sysfs.conf
