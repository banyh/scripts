## 如何啟用筆電的 Intel Graphic Driver?

1. 在`/etc/ld.so.conf.d/`中，將所有nvidia driver對應的目錄，集中在`nvidia.conf`中 (下面的390版號需要根據自己的版本修改)
```
/usr/lib/nvidia-390
/usr/lib32/nvidia-390
```

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
# Default-Stop:      0 6
# Short-Description: unload nvidia library
# Description:       unload nvidia library
### END INIT INFO

PRIME=$(prime-select query)
if [ "$PRIME" = "nvidia" ]; then
    exit 0
fi

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
    ;;
  *)
    echo "Usage: /etc/init.d/nvidia (start|stop)"
    exit 1
    ;;
esac
```

4. 執行`update-rc.d nvidia defaults`，應該會自動在`/etc/rc5.d`建立`SXXnvidia`的連結，並在`/etc/rc0.d`、`/etc/rc6.d`建立`KXXnvidia`的連結

5. 測試一下，執行`/etc/init.d/nvidia stop`後，再執行`nvidia-smi`就會出現找不到library的錯誤。執行`/etc/init.d/nvidia start`後，再執行`nvidia-smi`就可以看到正常的GPU狀態。當測試沒問題後就可以重新開機

6. 如果開機後出現問題怎麼辦? 可以按Ctrl+Alt+1進入tty模式，執行`/etc/init.d/nvidia stop`後再`reboot`。重開機後應該可以進入桌面，這時再來檢查為何`rc6.d`的script沒有正常執行。

7. 已知的副作用：在`prime-select intel`開機後，會無法執行system settings(`unity-control-center`)，會出現
```
GLib-CRITICAL **: g_strsplit: assertion 'string != NULL' failedv
```

## 如何使用嘸蝦米?

設定 --> 系統設定 (System Settings) --> 語言支援（Language Support）中，下面的鍵盤輸入法系統 (Keyboard input method system) 選擇`fcitx`，然後安裝嘸蝦米
```
sudo apt install fcitx-table-boshiamy
```
安裝後，在fcitx的設定中新增嘸蝦米輸入法，然後下載以下檔案
```
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
修改root擁有的`.config/fish/config.fish`
```
set -x LOCATE_PATH /var/lib/mlocate/backup.db:/var/lib/mlocate/synology.db

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
一般使用者執行時，要用`sudo -i updatedb`，而root執行時只需`updatedb`。

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

## 設定開機後自動執行jupyter notebook

輸入`crontab -e`後，新增一行
```
@reboot nohup /usr/local/lib/python2.7.13/bin/jupyter notebook --notebook-dir="/data" > /dev/null &
```

## 修改jupyter notebook的字型及版面

```
mkdir -p ~/.jupyter/custom
echo ".CodeMirror { font-size: 18px; }" > ~/.jupyter/custom/custom.css
echo ".container { width: 90%; }" >> ~/.jupyter/custom/custom.css
echo ".output_text { font-size: 18px; }"  >> ~/.jupyter/custom/custom.css
```
