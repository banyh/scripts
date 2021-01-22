# ------------------------------------------------------------------------------
# Install winehq (executed as root)
# ------------------------------------------------------------------------------
dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
apt-key add winehq.key
add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
apt update
apt install -y --install-recommends winehq-stable winetricks winbind

# ------------------------------------------------------------------------------
# Create Wine prefix and install libraries
# ------------------------------------------------------------------------------
WINEPREFIX=~/.wine-office WINEARCH=win32 wineboot -i
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks corefonts
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks cjkfonts
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks msxml6
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks gdiplus
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks dotnet20
# 確定IE可以正常上網
WINEPREFIX=~/.wine-office WINEARCH=win32 wine iexplore appdb.winehq.org
WINEPREFIX=~/.wine-office WINEARCH=win32 winetricks settings win7

# ------------------------------------------------------------------------------
# Mount image and install Office 2016
# ------------------------------------------------------------------------------
wget http://210.240.172.201/download/SW_DVD5_Office_Professional_Plus_2016_W32_ChnTrad_MLF_X20-41352.ISO
# mount the ISO file
cd /media/banyhong/16.0.4266.1001/
WINEPREFIX=~/.wine-office WINEARCH=win32 wine setup.exe
