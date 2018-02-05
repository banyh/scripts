## 如何啟用筆電的 Intel Graphic Driver?

修改 `/etc/default/grub`，將`GRUB_CMDLINE_LINUX_DEFAULT`改成
```
GRUB_CMDLINE_LINUX_DEFAULT='pcie_port_pm=off acpi_backlight=none acpi_osi=Linux acpi_osi=! acpi_osi="Windows 2009"'
```
重開機後，下載[網友修改過的prime-select](https://askubuntu.com/questions/879856/nvidia-prime-cant-switch-to-intel)
```
cd /usr/bin
mv prime-select prime-select.backup
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/prime-select
```
執行`prime-select intel`選擇 Intel Graphic Driver，然後確定EGL/GL driver都是指向mesa
```
update-alternatives --display x86_64-linux-gnu_egl_conf  # 第3行應該會顯示"目前連結指向 /usr/lib/x86_64-linux-gnu/mesa-egl/ld.so.conf"
update-alternatives --display x86_64-linux-gnu_gl_conf   # 第3行應該會顯示"目前連結指向 /usr/lib/x86_64-linux-gnu/mesa/ld.so.conf"
```

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
