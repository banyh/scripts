## 如何啟用筆電的 Intel Graphic Driver?

### 問題描述

一般的筆電都有兩個顯卡，一個是GPU，另一個是在chipset內的Intel Graphic。當安裝完Nvidia driver後，可以切換桌面顯示用要Nvidia或Intel，但在 Ubuntu 16.04.3 (Linux 4.13.0) 中，切換成Intel會導致開機黑畫面，或是停留在login畫面無法進入。

### 解決方法

造成錯誤的原因是nvidia-prime的驅動程式有問題，只要偵測到`/usr/lib/nvidia-390`內的library，就無法進入桌面。

### 具體步驟

1. 首先要安裝完 Nvidia driver，並重開機，重開機後進入桌面，可以用`nvidia-smi`觀察GPU使用情況，應該會發現Xorg及compiz都會用到GPU
2. 修改 `/etc/default/grub`，將`GRUB_CMDLINE_LINUX_DEFAULT`改成以下內容，這個修改是為了避免開機黑畫面。
```
GRUB_CMDLINE_LINUX_DEFAULT='pcie_port_pm=off acpi_backlight=none acpi_osi=Linux acpi_osi=! acpi_osi="Windows 2009"'
```
3. 新增`/etc/init.d/nvidia`，內容如下
```
#!/bin/sh
### BEGIN INIT INFO
# Provides:          nvidia 
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     5
# Default-Stop:      6
# Short-Description: load/unload nvidia library
# Description:       load/unload nvidia library
### END INIT INFO

case "$1" in
  start)
    sleep 10
    cd /etc/ld.so.conf.d
    mv nvidia.conf.bak nvidia.conf
    ldconfig
    nvidia-smi
    ;;
  stop)
    cd /etc/ld.so.conf.d
    mv nvidia.conf nvidia.conf.bak
    ldconfig
esac
```
4. 執行`update-rc.d nvidia defaults`，應該會自動在`/etc/rc5.d`建立`SXXnvidia`的連結，並在`/etc/rc6.d`建立`KXXnvidia`的連結
5. 測試一下，執行`/etc/init.d/nvidia stop`後，再執行`nvidia-smi`就會出現找不到library的錯誤。執行`/etc/init.d/nvidia start`後，再執行`nvidia-smi`就可以看到正常的GPU狀態。當測試沒問題後就可以重新開機
6. 如果開機後出現問題怎麼辦? 可以按Ctrl+Alt+1進入tty模式，執行`/etc/init.d/nvidia stop`後再`reboot`。重開機後應該可以進入桌面，這時再來檢查為何`rc6.d`的script沒有正常執行。

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

## Beyond Compare 4 破解

```
sudo sed -i "s/keexjEP3t4Mue23hrnuPtY4TdcsqNiJL-5174TsUdLmJSIXKfG2NGPwBL6vnRPddT7tH29qpkneX63DO9ECSPE9rzY1zhThHERg8lHM9IBFT+rVuiY823aQJuqzxCKIE1bcDqM4wgW01FH6oCBP1G4ub01xmb4BGSUG6ZrjxWHJyNLyIlGvOhoY2HAYzEtzYGwxFZn2JZ66o4RONkXjX0DF9EzsdUef3UAS+JQ+fCYReLawdjEe6tXCv88GKaaPKWxCeaUL9PejICQgRQOLGOZtZQkLgAelrOtehxz5ANOOqCaJgy2mJLQVLM5SJ9Dli909c5ybvEhVmIC0dc9dWH+/N9KmiLVlKMU7RJqnE+WXEEPI1SgglmfmLc1yVH7dqBb9ehOoKG9UE+HAE1YvH1XX2XVGeEqYUY-Tsk7YBTz0WpSpoYyPgx6Iki5KLtQ5G-aKP9eysnkuOAkrvHU8bLbGtZteGwJarev03PhfCioJL4OSqsmQGEvDbHFEbNl1qJtdwEriR+VNZts9vNNLk7UGfeNwIiqpxjk4Mn09nmSd8FhM4ifvcaIbNCRoMPGl6KU12iseSe+w+1kFsLhX+OhQM8WXcWV10cGqBzQE9OqOLUcg9n0krrR3KrohstS9smTwEx9olyLYppvC0p5i7dAx2deWvM1ZxKNs0BvcXGukR+/g" /usr/lib/beyondcompare/BCompare
```
輸入下列的key
```
--- BEGIN LICENSE KEY ---
GXN1eh9FbDiX1ACdd7XKMV7hL7x0ClBJLUJ-zFfKofjaj2yxE53xauIfkqZ8FoLpcZ0Ux6McTyNmODDSvSIHLYhg1QkTxjCeSCk6ARz0ABJcnUmd3dZYJNWFyJun14rmGByRnVPL49QH+Rs0kjRGKCB-cb8IT4Gf0Ue9WMQ1A6t31MO9jmjoYUeoUmbeAQSofvuK8GN1rLRv7WXfUJ0uyvYlGLqzq1ZoJAJDyo0Kdr4ThF-IXcv2cxVyWVW1SaMq8GFosDEGThnY7C-SgNXW30jqAOgiRjKKRX9RuNeDMFqgP2cuf0NMvyMrMScnM1ZyiAaJJtzbxqN5hZOMClUTE+++
--- END LICENSE KEY -----
```
