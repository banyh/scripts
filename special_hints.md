## 如何啟用筆電的 Intel Graphic Driver?

修改 `/etc/default/grub`，將`GRUB_CMDLINE_LINUX_DEFAULT`改成
```
GRUB_CMDLINE_LINUX_DEFAULT='pcie_port_pm=off acpi_backlight=none acpi_osi=Linux acpi_osi=! acpi_osi="Windows 2009"'
```
先安裝一次Nvidia driver(動作A)，重開機後，設定主要顯示設備為 Intel Graphic
```
prime-select intel
```
再次重開機後，移除Nvidia driver再重新安裝(動作B)，並新增`/etc/ld.so.conf.d/nvidia.conf`內容如下：
```
/usr/lib/nvidia-384
/usr/lib32/nvidia-384
```

註：動作A可以改成安裝不同版本的 Nvidia driver，動作B可以改成安裝官方版本的 Nvidia driver。


## 如何使用嘸蝦米?

設定 --> 系統設定 (System Settings) --> 語言支援（Language Support）中，下面的鍵盤輸入法系統 (Keyboard input method system) 選擇`fcitx`。
然後安裝嘸蝦米
```
sudo apt install fcitx-table-boshiamy
cd .config/fcitx/table
wget https://github.com/banyh/scripts/raw/master/extra/boshiamy.conf
wget https://github.com/banyh/scripts/raw/master/extra/boshiamy.mb
```

## 設定`updatedb`，將不同的設備放在不同的db中

`/etc/updatedb.conf`
```
PRUNE_BIND_MOUNTS="yes"
PRUNENAMES=".git .bzr .hg .svn @eaDir"
PRUNEPATHS="/tmp /var/spool /media /home/.ecryptfs /var/lib/schroot"
PRUNEFS="NFS nfs nfs4 rpc_pipefs afs binfmt_misc proc smbfs autofs iso9660 ncpfs coda devpts ftpfs devfs mfs shfs sysfs cifs lustre tmpfs usbfs udf fuse.glusterfs fuse.sshfs curlftpfs ecryptfs fusesmb devtmpfs"
```
`config.fish`
```
function updatedb
    if test -d /diskstation/Bany/Course
        echo "Update files on Synology DiskStation."
        /usr/bin/updatedb -l 1 -o /var/lib/mlocate/synology.db -U /diskstation/ --prunefs ntfs
    else
        echo "Synology DiskStation is not mounted. Skip updatedb."
    end
    if test -d /media/banyhong/BACKUP/Project
        echo "Update files on Seagate External Disk."
        /usr/bin/updatedb -l 1 -o /var/lib/mlocate/backup.db -U /media/banyhong/BACKUP/
    else
        echo "Seagate External Disk is not mounted. Skip updatedb."
    end
    echo "Update files on Ubuntu file system."
    /usr/bin/updatedb
end
```
最後設定 `set -x LOCATE_PATH /var/lib/mlocate/backup.db:/var/lib/mlocate/synology.db`

