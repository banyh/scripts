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
    ;;
  restore)
    mkdir -p ~/.config/Code/User
    cp $BACKUP_DIR/vscode/settings.json ~/.config/Code/User
    cp $BACKUP_DIR/vscode/keybindings.json ~/.config/Code/User
    ;;
  *)
    echo "Usage: backup_and_restore.sh (backup|restore)"
    exit 1
    ;;
esac
