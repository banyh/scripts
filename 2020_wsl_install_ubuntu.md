# WSL Ubuntu端可能需要作的事

## 設定sudo權限

執行`sudo visudo`，並新增一行
```
banyhong  ALL=(ALL) NOPASSWD:ALL
```

## 更新系統

```
apt update
apt -y upgrade
```

## 安裝VScode(只需要安裝在windows端)

先按此步驟安裝Windows端: https://docs.microsoft.com/zh-tw/windows/wsl/tutorials/wsl-vscode

然後在wsl任何目錄中，輸入`code .`，就會自動安裝需要的程式

## 安裝雜七雜八的工具

```
apt-get install -y htop sshfs libopenblas-dev git fish \
autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib \
libbluetooth-dev libbz2-dev libexpat1-dev libgdbm-dev libgpm2 \
libncursesw5-dev libreadline-dev python-dev-is-python2 python3-dev \
libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools \
netbase python-crypto python-pil python-ply quilt \
tk-dev zlib1g-dev libblas-dev liblapack-dev gfortran \
software-properties-common curl unzip cmake
```

## 安裝Python (miniconda)

建議以一般使用者的身份安裝，預設安裝目錄為`~/miniconda3/`
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
ln -s ~/miniconda3/bin ~/bin
rm Miniconda3-latest-Linux-x86_64.sh
```

## 使用者設定

先執行`chsh`將預設shell設定為`/usr/bin/fish`，然後執行下列指令來設定fish
```
mkdir -p ~/.config/fish
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/fish_shell/config.fish -O ~/.config/fish/config.fish
source ~/.config/fish/config.fish
conda init fish  # 將conda初始化加入config.fish中
```

設定powerline-shell
```
pip install powerline-shell
mkdir ~/.config/powerline-shell
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/powerline-shell/config.json -O ~/.config/powerline-shell/config.json
```

設定git
```
git config --global user.name "banyh"
git config --global user.email banyhong@gliacloud.com
```

## 設定ssh

1. 新增`~/.ssh/id_rsa`及`~/.ssh/id_rsa.pub`
2. `chmod 400 ~/.ssh/id_rsa`
3. 新增`~/.ssh/config`，將常用的host加進去
