wget https://github.com/jgm/pandoc/releases/download/2.0.3/pandoc-2.0.3-1-amd64.deb
dpkg -i pandoc-2.0.3-1-amd64.deb
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvfz install-tl-unx.tar.gz
cd install-tl-20171121/
./install-tl
export PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-linux
cd ..
