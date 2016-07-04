apt-get -y install xrdp mate-core mate-desktop-environment mate-notification-daemon

echo '#!/bin/bash' > /etc/xrdp/startwm.sh
echo '' >> /etc/xrdp/startwm.sh
echo 'if [ -r /etc/default/locale ]; then' >> /etc/xrdp/startwm.sh
echo '  . /etc/default/locale' >> /etc/xrdp/startwm.sh
echo '  export LANG LANGUAGE' >> /etc/xrdp/startwm.sh
echo 'fi' >> /etc/xrdp/startwm.sh
echo '' >> /etc/xrdp/startwm.sh
echo 'echo mate-session >~/.xsession' >> /etc/xrdp/startwm.sh
echo '. /etc/X11/Xsession' >> /etc/xrdp/startwm.sh

service xrdp restart
