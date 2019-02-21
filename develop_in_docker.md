# 利用 docker 準備開發環境

## 1. 安裝 docker 及 nvidia-docker2

```
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get install -y docker-ce


# Install nvidia-docker2 and reload the Docker daemon configuration
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt update
apt install -y nvidia-docker2
pkill -SIGHUP dockerd
```

## 2. 啟動 docker container

選擇的版本是 CUDA 10.0 + CuDNN 7 on Ubuntu 16.04

```
docker run --runtime=nvidia -v /data/project_glia/studio:/workspace -it nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 bash
```

## 3. 編輯程式碼

* 用 vscode 打開 `/data/project_glia/studio` (我們同步的資料夾)，修改檔案
* 在 docker 的互動終端上執行或測試


# 利用遠端工作站的 docker 開發環境

## 1. 安裝 docker 及 nvidia-docker2

步驟同上

## 2. 啟動 docker container

選擇的版本是 CUDA 10.0 + CuDNN 7 on Ubuntu 16.04

```
docker run --runtime=nvidia -p 8022:22 -v /home/banyhong/studio:/workspace -it nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 bash
```

注意，上面有一個 port mapping 及一個 directory mapping：

* host 8022 --> container 22
* host `/home/banyhong/studio` --> container `/workspace`

啟動後，安裝 openssh-server (以下動作在 container 執行)
```
apt update
apt install -y openssh-server
```

設定 openssh
```
echo 'root:passwd' | chpasswd
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
service ssh restart
# * Restarting OpenBSD Secure Shell server sshd   [ OK ]
```

這時候在就能登入遠端的 container 了
```
ssh root@remote_host -p 8022
# 輸入剛剛設定的密碼 passwd
```

## 3. 設定 vscode

* 安裝 sftp (開發者: liximomo)
* 按 Ctrl+Shift+P 執行 SFTP Config 命令，會產生新的 sftp.json

修改 sftp.json 如下：
```
{
    "name": "My Server",
    "host": "localhost",
    "protocol": "sftp",
    "port": 8022,
    "username": "root",
    "password": "passwd",
    "remotePath": "/workspace",
    "uploadOnSave": true
}
```

* 在檔案總管中，按右鍵，選擇 Download folder，會花一點時間下載
    * 如果第一次只有下載目錄結構，但裡面都是空的，可以在子目錄上再按右鍵，選 Download folder

## 4. 編輯程式碼

* 在 host 上修改後，可以按右鍵，選擇 Sync both directions 來同步檔案
    * 可以只選擇部分想同步的檔案
    * 可以單向同步 local->remote 或 remote->local
* 同步完成後，在遠端的 docker container 內執行程式，以便利用遠端機器的GPU
