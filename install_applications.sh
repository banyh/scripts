#!/bin/bash

# Skype
wget "https://go.skype.com/skypeforlinux-64.deb"
dpkg -i skypeforlinux-64.deb

# Dropbox
wget "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb" -O dropbox_2015.10.28_amd64.deb
dpkg -i dropbox_2015.10.28_amd64.deb

# Slack
wget "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.0-beta25a7a50e-amd64.deb"
dpkg -i slack-desktop-3.2.0-beta25a7a50e-amd64.deb

# Visual Studio Code
wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O code.deb
dpkg -i code.deb

# BBS軟體
apt install -y gemanx

# Shutter抓圖軟體
apt install -y shutter

# Kazam桌面錄影
apt install -y kazam

# Homebank記帳
apt install -y homebank

# SMPlayer影片播放
apt install -y smplayer

# Variety桌面自動更換
apt install -y variety

# 設定webcam的亮度、對比、Gamma
apt install -y guvcview

# XnView看圖軟體
wget "http://download.xnview.com/XnViewMP-linux-x64.deb"
dpkg -i XnViewMP-linux-x64.deb

# Foxit PDF Reader
wget "https://www.foxitsoftware.com/downloads/latest.php?product=Foxit-Reader&platform=Linux-64-bit&version=2.4.1.0609&package_type=run&language=English" -O FoxitReader_2.4.1_Setup.run.tar.gz
gzip -d 'FoxitReader_2.4.1_Setup.run.tar.gz'
tar xvf 'FoxitReader_2.4.1_Setup.run.tar'
./'FoxitReader.enu.setup.2.4.1.0609(r08f07f8).x64.run'

# Beyond Compare檔案比較
wget "https://www.scootersoftware.com/bcompare-4.2.4.22795_amd64.deb"
dpkg -i bcompare-4.2.4.22795_amd64.deb
sed -i "s/keexjEP3t4Mue23hrnuPtY4TdcsqNiJL-5174TsUdLmJSIXKfG2NGPwBL6vnRPddT7tH29qpkneX63DO9ECSPE9rzY1zhThHERg8lHM9IBFT+rVuiY823aQJuqzxCKIE1bcDqM4wgW01FH6oCBP1G4ub01xmb4BGSUG6ZrjxWHJyNLyIlGvOhoY2HAYzEtzYGwxFZn2JZ66o4RONkXjX0DF9EzsdUef3UAS+JQ+fCYReLawdjEe6tXCv88GKaaPKWxCeaUL9PejICQgRQOLGOZtZQkLgAelrOtehxz5ANOOqCaJgy2mJLQVLM5SJ9Dli909c5ybvEhVmIC0dc9dWH+/N9KmiLVlKMU7RJqnE+WXEEPI1SgglmfmLc1yVH7dqBb9ehOoKG9UE+HAE1YvH1XX2XVGeEqYUY-Tsk7YBTz0WpSpoYyPgx6Iki5KLtQ5G-aKP9eysnkuOAkrvHU8bLbGtZteGwJarev03PhfCioJL4OSqsmQGEvDbHFEbNl1qJtdwEriR+VNZts9vNNLk7UGfeNwIiqpxjk4Mn09nmSd8FhM4ifvcaIbNCRoMPGl6KU12iseSe+w+1kFsLhX+OhQM8WXcWV10cGqBzQE9OqOLUcg9n0krrR3KrohstS9smTwEx9olyLYppvC0p5i7dAx2deWvM1ZxKNs0BvcXGukR+/g" /usr/lib/beyondcompare/BCompare

# Gnome介面設定
apt install -y compizconfig-settings-manager  # 設定桌面各種行為
apt install -y compiz-plugins-extra           # 額外的桌面特效
apt install -y unity-tweak-tool               # 調整unity的外觀及行為
apt install -y gnome-tweak-tool               # 調整gnome的外觀及行為
apt install -y gnome-panel                    # 新增app捷徑

# Nemo檔案管理
add-apt-repository -y ppa:webupd8team/nemo3
apt-get update
apt install -y nemo

# MComix看漫畫
apt install -y mcomix
