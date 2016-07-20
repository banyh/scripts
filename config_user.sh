# simple config for fish
mkdir -p ~/.config/fish
echo "alias ll 'ls -laFh'" > ~/.config/fish/config.fish
echo "alias l 'ls -CF'" >> ~/.config/fish/config.fish
echo "alias .. 'cd ..'" >> ~/.config/fish/config.fish
echo "alias ... 'cd ../..'" >> ~/.config/fish/config.fish
echo "" >> ~/.config/fish/config.fish
echo 'set -x PATH /usr/local/lib/python2.7.11/bin /usr/local/lib/python3.5.1/bin $PATH' >> ~/.config/fish/config.fish
chsh --shell /usr/bin/fish
source ~/.config/fish/config.fish

# set up jupyter notebook
jupyter notebook --generate-config
echo >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '0.0.0.0'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = u'/home/banyhong'" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> .jupyter/jupyter_notebook_config.py
