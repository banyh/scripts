add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install git -y

git --version
git config --global user.name "banyh"
git config --global user.email banyhong@gliacloud.com

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
apt-get -y install git-lfs
git lfs install
