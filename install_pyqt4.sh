# ----------------------------------------------------------------------------------------------
# install SIP
# ----------------------------------------------------------------------------------------------
wget "https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.7/sip-4.19.7.tar.gz"
tar xf sip-4.19.7.tar.gz
cd sip-4.19.7
python configure.py
make -j4
make install  # needs root
python3 configure.py
make -j4
make install  # needs root

# ----------------------------------------------------------------------------------------------
# install QT4
# ----------------------------------------------------------------------------------------------
apt-get install -y qt4-default qt4-qmake gnome-themes-standard
wget "http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.12.1/PyQt4_gpl_x11-4.12.1.tar.gz"
tar xzf PyQt4_gpl_x11-4.12.1.tar.gz
cd PyQt4_gpl_x11-4.12.1
echo yes | python configure-ng.py
make -j4
make install  # needs root
echo yes | python3 configure-ng.py
make -j4
make install  # needs root
