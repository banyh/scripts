# simple config for fish
mkdir -p ~/.config/fish
cd ~/.config/fish
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/config.fish
source ~/.config/fish/config.fish
cd ~

mkdir ~/bin
cd ~/bin
git clone https://github.com/banyh/powerline-shell
cd powerline-shell
./install.py
chmod +x installr.py
./installr.py
cd ~

# set up jupyter notebook
jupyter notebook --generate-config
echo >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = u'/home/banyhong'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.password = 'sha1:fa8dd313f6aa:d85a90aab33b45161ec45fc92e35a41ce2690f78'" >> ~/.jupyter/jupyter_notebook_config.py

# set user name and email for git
git config --global user.name "banyh"
git config --global user.email banyhong@gliacloud.com

# set themes
mkdir ~/.themes
mkdir ~/.icons
cd ~/.themes
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/themes.tar.bz2
tar xjf themes.tar.bz2
rm *.bz2
cd ~/.icons
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/cursors.tar.bz2
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/icons_papirus.tar.bz2
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/icons_ubo.tar.bz2
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/icons_faenza.tar.bz2
wget https://raw.githubusercontent.com/banyh/scripts/master/extra/icons_obsidian.tar.bz2
tar xjf cursors.tar.bz2
tar xjf icons_papirus.tar.bz2
tar xjf icons_ubo.tar.bz2
tar xjf icons_faenza.tar.bz2
tar xjf icons_obsidian.tar.bz2
rm *.bz2
