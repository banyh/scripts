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

### 4-1. 短時間內需要在docker container中debug

* 點擊視窗左下角 `><` 形狀的icon，選擇 Attach to Running Container...
* 會讓你選擇要連接那一個container，應該會看到執行中的container清單
* 開啟新視窗後，打開`/workspace`資料夾，就可以編輯，並且與host資料夾同步
* 打開terminal可以執行指令
* 需要git操作時，應該在host terminal操作

### 4-2. 需要長期在Docker中開發

* 假設project folder在`/home/banyhong/hello`
* 先用vscode編輯`/home/banyhong/hello/.devcontainer/.devcontainer.json`，內容如下

    ```
    {
        "name": "CUDA-11-0",
        "build": {"dockerfile": "../Dockerfile"},
        "forwardPorts": [8000],
        "runArgs": ["--runtime=nvidia"],
    }
    ```

    * 其中`forwardPorts`只有開發web app才會用到
    * 其中`--runtime=nvidia`只有開發CUDA app才會用到

* 然後編輯`/home/banyhong/hello/Dockerfile`，建立開發需要的環境

    ```
    FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04
    ENV DEBIAN_FRONTEND=noninteractive
    RUN apt-get update && apt-get install -y wget
    RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
        chmod +x Miniconda3-latest-Linux-x86_64.sh && \
        bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
    ENV PATH=$HOME/miniconda/bin:$PATH
    ```

* 未來需要開發時，點擊視窗左下角 `><` 形狀的icon，選擇 Reopen in Container...
    * 會自動build docker image
    * 然後將project所在目錄，對映到container中的`/workspace/hello`
