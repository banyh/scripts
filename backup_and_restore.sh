#!/bin/sh

BACKUP_DIR=/data/backup
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
fi

case "$1" in
  backup)
    mkdir -p $BACKUP_DIR/etc
    cp /etc/updatedb.conf $BACKUP_DIR/etc
    cp /etc/idmapd.conf $BACKUP_DIR/etc
    cp /etc/ssh/sshd_config $BACKUP_DIR/etc
    cp /etc/ld.so.conf.d/nvidia.conf $BACKUP_DIR/etc
    cp /etc/default/grub $BACKUP_DIR/etc
    cp /etc/init.d/nvidia $BACKUP_DIR/etc
    cp /etc/fstab $BACKUP_DIR/etc

    mkdir -p $BACKUP_DIR/vscode
    cp ~/.config/Code/User/settings.json $BACKUP_DIR/vscode
    cp ~/.config/Code/User/keybindings.json $BACKUP_DIR/vscode

    mkdir -p $BACKUP_DIR/桌面
    cp -r ~/桌面/* $BACKUP_DIR/桌面

    mkdir -p $BACKUP_DIR/variety
    cp ~/.config/variety/*.conf $BACKUP_DIR/variety

    mongodump --db=raw_text --collection=zh_wiki --gzip --archive=$BACKUP_DIR/zh_wiki
    mongodump --db=raw_text --collection=zh_news --gzip --archive=$BACKUP_DIR/zh_news
    mongodump --db=twse_daily --gzip --archive=$BACKUP_DIR/twse_daily
    mongodump --db=imgsent --gzip --archive=$BACKUP_DIR/imgsent
    ;;
  restore)
    mkdir -p ~/.config/Code/User
    cp $BACKUP_DIR/vscode/settings.json ~/.config/Code/User
    cp $BACKUP_DIR/vscode/keybindings.json ~/.config/Code/User

    mkdir -p $BACKUP_DIR/桌面
    cp -r $BACKUP_DIR/桌面/* ~/桌面

    mkdir -p ~/.config/variety
    cp $BACKUP_DIR/variety/* ~/.config/variety

    mongorestore --db=raw_text --gzip --archive=$BACKUP_DIR/zh_wiki
    mongorestore --db=raw_text --gzip --archive=$BACKUP_DIR/zh_news
    mongorestore --db=twse_daily --gzip --archive=$BACKUP_DIR/twse_daily
    mongorestore --db=imgsent --gzip --archive=$BACKUP_DIR/imgsent
    ;;
  *)
    echo "Usage: backup_and_restore.sh (backup|restore)"
    exit 1
    ;;
esac
