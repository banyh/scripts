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

如果是Ubuntu 18.04，預設沒有安裝fcitx，需要安裝fcitx並且**重開機**才會生效。
```
sudo apt install -y fcitx fcitx-config-common fcitx-ui-qimpanel
```

設定 --> 系統設定 (System Settings) --> 語言支援（Language Support）中，下面的鍵盤輸入法系統 (Keyboard input method system) 選擇`fcitx`，然後安裝嘸蝦米
```
sudo apt install -y fcitx-table-boshiamy
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
echo ".container { width: 90% !important; }" >> ~/.jupyter/custom/custom.css
echo ".output_text { font-size: 18px; }"  >> ~/.jupyter/custom/custom.css
echo ".terminal-app .terminal { font-family: Inconsolata for powerline; font-size: 22px; }" >> ~/.jupyter/custom/custom.css
```

## 掛載Diskstation的NFS4

前置作業
1. `apt-get install nfs-common`
2. 修改`/etc/idmapd.conf`，在`[general]`區段新增一行`Domain = bany`
3. 修改`/etc/fstab`，新增以下兩行
```
192.168.1.150:/volume1/Bany              /diskstation/Bany   nfs    bg,soft,rw,noexec,nodev,nosuid,timeo=1200 0 2
192.168.1.150:/volume1/Family            /diskstation/Family nfs    bg,soft,rw,noexec,nodev,nosuid,timeo=1200 0 2
```

## 讓HDMI可以輸出聲音

資料來源: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1377653/comments/19

1. 新增檔案`/etc/systemd/system/fix-hdmi-audio.service`，其內容如下：

```
[Unit]
Description=nVidia HDMI Audio Fixer
Before=systemd-logind.service display-manager.service
After=module-init-tools.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/fix-hdmi-audio.sh

[Install]
WantedBy=multi-user.target
```

2. 新增檔案`/usr/local/bin/fix-hdmi-audio.sh`，其內容如下：

```
#!/bin/sh
setpci -s 01:00.0 0x488.l=0x2000000:0x2000000
rmmod nvidia-uvm nvidia-drm nvidia-modeset nvidia
sh -c 'echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove'
sh -c 'echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan'
modprobe nvidia nvidia-modeset nvidia-drm nvidia-uvm
```

3. 設定為可執行: `chmod +x /usr/local/bin/fix-hdmi-audio.sh`

4. 啟動service: `systemctl enable fix-hdmi-audio.service`

5. 安裝pulseaudio音量控制: `apt install pavucontrol`，執行PulseAudio Volume Control，
    這時在Configuration的頁面，只會看到`內部音效`

6. 重開機後，插上HDMI後播放音樂，然後打開PulseAudio Volume Control。
    在Configuration的頁面，應該可以看到`內部音效`及`HDA NVidia`，而且`HDA NVidia`已經設為`Digital Stereo (HDMI) Output`。
    在Playback的頁面，音樂播放器的右邊可以看到一個按鈕，可以選擇`內部音效`或是`HDA NVidia`，選擇`HDA NVidia`後聲音就會從HDMI出來。

## 讓ssh不要自動斷線

修改`/etc/ssh/sshd_config`，新增下面兩行
```
ClientAliveInterval 30
ClientAliveCountMax 6
```

表示每隔30秒，ssh service會發送heartbeat給client，如果連續6次(180秒)都沒有回應，才會斷線。

## 安裝Python Gtk Package

```
apt install libgirepository1.0-dev gobject-introspection
pip install pygobject
pip3 install pygobject
```

範例：利用Gtk截圖
```
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gdk

# full screenshot
window = Gdk.get_default_root_window()
pb = Gdk.pixbuf_get_from_window(window, *window.get_geometry())
pb.savev("full.png", "png", (), ())

# screenshots for all windows
window = Gdk.get_default_root_window()
screen = window.get_screen()
typ = window.get_type_hint()
for i, w in enumerate(screen.get_window_stack()):
    pb = Gdk.pixbuf_get_from_window(w, *w.get_geometry())
    pb.savev("{}.png".format(i), "png", (), ())

# screenshot active window
screen = Gdk.get_default_root_window().get_screen()
w = screen.get_active_window()
pb = Gdk.pixbuf_get_from_window(w, *w.get_geometry())
pb.savev("active.png", "png", (), ())
```

## 避免影片播放時tearing的方法(未實證)

修改`/etc/X11/xorg.conf`，在nvidia device的地方，加入
```
    Option         "TripleBuffer" "True"
```
並在最後加入
```
Section "Extensions"
    Option "Composite" "Disable"
EndSection
```
