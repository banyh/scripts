wget https://dl.winehq.org/wine-builds/Release.key
apt-key add Release.key
apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
apt update
dpkg --add-architecture i386
apt install --install-recommends wine-staging
apt install winetricks

ln -s /opt/wine-staging/bin/wine64 /usr/local/bin/
ln -s /opt/wine-staging/bin/wine /usr/local/bin/
ln -s /opt/wine-staging/bin/winecfg /usr/local/bin/
ln -s /opt/wine-staging/bin/wineserver /usr/local/bin/

#
# 安裝 World of Warcraft
#
# 1. 到WOW官網下載安裝程式 `World-of-Warcraft-Setup.exe`
# 2. 用wine64開啟後，會安裝 Battle.net
#    第一次安裝時，會要求安裝 mono 及 gecko，都選確定。
#    `wine64 World-of-Warcraft-Setup.exe``
# 3. 安裝完成後，會自動跳出 Battle.net 的登入畫面
#    如果沒有自動跳出，也可以手動輸入
#    `cd ~/.wine/drive_c/Program\ Files/Battle.net``
#    `wine64 Battle.net\ Launcher.exe`
# 4. 登入 Battle.net 後選擇魔獸世界並安裝
#    記得要選擇語言 (我選繁體中文字幕及英文語音)
#    安裝完成後按Play可以進入遊戲，或是手動輸入：
#    `wine64 /home/banyhong/.wine/drive_c/Program\ Files\ \(x86\)/World\ of\ Warcraft/Wow-64.exe`
