#!/bin/sh

BACKUP_DIR=/data/backup
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
fi

case "$1" in
  backup)
    mkdir -p $BACKUP_DIR/vscode
    cp ~/.config/Code/User/settings.json $BACKUP_DIR/vscode
    cp ~/.config/Code/User/keybindings.json $BACKUP_DIR/vscode

    mkdir -p $BACKUP_DIR/桌面
    cp -r ~/桌面/* $BACKUP_DIR/桌面

    mkdir -p $BACKUP_DIR/variety
    cp ~/.config/variety/*.conf $BACKUP_DIR/variety
    ;;
  restore)
    mkdir -p ~/.config/Code/User
    cp $BACKUP_DIR/vscode/settings.json ~/.config/Code/User
    cp $BACKUP_DIR/vscode/keybindings.json ~/.config/Code/User

    mkdir -p $BACKUP_DIR/桌面
    cp -r $BACKUP_DIR/桌面/* ~/桌面

    mkdir -p ~/.config/variety
    cp $BACKUP_DIR/variety/* ~/.config/variety
    ;;
  *)
    echo "Usage: backup_and_restore.sh (backup|restore)"
    exit 1
    ;;
esac
