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
set -x LOCATE_PATH /var/lib/mlocate/windows.db:/var/lib/mlocate/wdblack.db

function updatedb
    if test -d /media/banyhong/WDBLACK/Courses
        echo "Update files on WDBLACK."
        /usr/bin/updatedb -l 1 -o /var/lib/mlocate/wdblack.db -U /media/banyhong/WDBLACK/
    else
        echo "WDBLACK is not mounted. Skip updatedb."
    end
    if test -d /media/banyhong/Windows/Windows
        echo "Update files on Windows Disk."
        /usr/bin/updatedb -l 1 -o /var/lib/mlocate/windows.db -U /media/banyhong/Windows/
    else
        echo "Windows Disk is not mounted. Skip updatedb."
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

## 掛載Synology Diskstation的NFS4

前置作業
1. `apt-get install nfs-common`
2. 修改`/etc/idmapd.conf`，在`[general]`區段新增一行`Domain = bany`
3. 修改`/etc/fstab`，新增以下兩行
```
192.168.1.150:/volume1/Bany      /diskstation/Bany    nfs  bg,soft,rw,noauto,noexec,nodev,nosuid,timeo=1200 0 2
192.168.1.150:/volume1/Family    /diskstation/Family  nfs  bg,soft,rw,noauto,noexec,nodev,nosuid,timeo=1200 0 2
```

## 掛載QNAP的NFS4

```
mkdir -p /media/Multimedia /media/Home /media/Download
mount -t nfs4 -o vers=4 192.168.1.200:/Multimedia /media/Multimedia
mount -t nfs4 -o vers=4 192.168.1.200:/homes/admin /media/Home
mount -t nfs4 -o vers=4 192.168.1.200:/Download /media/Download
```

## 根據不同的網路決定是否 mount NFS

先安裝`apt-get install autofs`。

修改`/etc/auto.master`，裡面的格式是`mount-point [map-type[,format]:]map [options]`，新增2行：
```
/diskstation    /etc/auto.nfs    --timeout 30
```

新建`/etc/auto.nfs`
```
Bany    -fstype=nfs4,rw,bg,soft,noexec,nodev,nosuid,rsize=32768,wsize=32768    192.168.1.150:/volume1/Bany
Family  -fstype=nfs4,rw,bg,soft,noexec,nodev,nosuid,rsize=32768,wsize=32768    192.168.1.150:/volume1/Family
```

修改`/etc/default/nfs-common`，新增一行
```
NEED_IDMAPD=yes
```

重新啟動autofs，有兩種方式，不確定那一種是對的
1. `systemctl restart autofs`
2. `/etc/init.d/autofs reload`

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
