# 利用 docker 準備開發環境

## 1. 安裝 docker 及 nvidia-docker2

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable"
apt-get install -y docker-ce docker-ce-cli containerd.io

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt update
apt install -y nvidia-docker2
pkill -SIGHUP dockerd
```

安裝後記得將使用者加入`docker` group，可能需登出再登入才會生效
```
sudo usermod -aG docker $USER
```

## 2. 安裝vscode

```
wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O code.deb
dpkg -i code.deb                # Visual Studio Code
```

## 3. 下載測試用的 docker image

* 假設我們要在container裡面跑的程式碼，放在 `/home/banyhong/hello`
* 這個目錄要同步到container內的 `/workspace`
* 執行後，視窗先不要關掉

```
docker run --runtime=nvidia -v /home/banyhong/pybany:/workspace -it nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04 bash
```

## 4. 設定vscode

* 先安裝 extension "Remote - Containers" 及 "Docker"
* 點擊視窗左下角 `><` 形狀的icon

### 4-1. 選擇 Attach to Running Container...

* 會讓你選擇要連接那一個container，應該會看到執行中的container清單
* 開啟新視窗後，打開`/workspace`資料夾，就可以編輯，並且與host資料夾同步
* 打開terminal可以執行指令
* 需要git操作時，應該在host terminal操作

### 4-2. 選擇 Add Development Container Configuration Files...

* 這個功能可以設定專用的`Dockerfile`，讓docker build, run合成一步

* vscode container 的設定檔名為`devcontainer.json`