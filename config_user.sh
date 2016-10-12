# simple config for fish
mkdir -p ~/.config/fish
cp config.fish ~/.config/fish/
source ~/.config/fish/config.fish

mkdir ~/bin
cd ~/bin
git clone https://github.com/banyh/powerline-shell
cd powerline-shell
./install.py
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
