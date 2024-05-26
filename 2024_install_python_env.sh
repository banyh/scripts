sudo apt-get update
sudo apt-get upgrade

#----------------------------
# Fish Shell
#----------------------------
sudo apt-get install fish

#----------------------------
# Miniforge (python environment)
#----------------------------
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh

#----------------------------
# Plotly Dash for simple web service
#----------------------------
conda install -y dash pandas dash-bootstrap-components fastapi uvicorn
