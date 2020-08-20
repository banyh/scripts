###############################################################################
# Alias
###############################################################################

alias ll 'ls -laFh'
alias l 'ls -CF'
alias du 'du -h'
alias df 'df -h -x squashfs -T -x tmpfs'
alias .. 'cd ..'
alias ... 'cd ../..'
alias delh 'echo all | history --delete --prefix locate & echo 1 | history --delete --prefix locate'

###############################################################################
# Environment Variables
# 註: 要正確使用 conda + powerline-shell，有一個重點，就是將conda的 base binary
#     連結到 home folder，例如: `ln -s /opt/miniconda3/bin ~/bin`
#     然後將 ~/bin 放在PATH最後面，這樣切換不同的環境，仍然可以保證 powerline-shell 存在
###############################################################################

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x PATH $PATH ~/bin
set -x LOCATE_PATH /var/lib/mlocate/backup.db:/var/lib/mlocate/qnap.db

###############################################################################
# Functions
###############################################################################

function fish_prompt
  # 用途: 開啟powerline-shell的功能，需要先用pip install powerline-shell安裝
  powerline-shell --shell bare $status
end

function virtualenv
  # 用途: 使用conda產生gliacloud project所需的環境，其中mysqlclient及uwsgi的安裝比較特別
  # 使用方式: virtualenv [name]
  conda create -n "$argv[1]" python -y
  conda activate "$argv[1]"
  conda env config vars set PIP_EXTRA_INDEX_URL=https://gliacloud:cookiebank@pypi-dot-living-bio.appspot.com/pypi
  conda activate "$argv[1]"
  conda install -c bioconda mysqlclient -y
  conda install -c conda-forge uwsgi -y
  conda install ipython -y
  pip install genv
  conda env config vars set GOOGLE_APPLICATION_CREDENTIALS=(python -c "import genv; print(genv.__file__.replace('__init__.py', 'gapp/unlimited.json'))")
  conda activate "$argv[1]"

  if test -d client and test -f setup.py
    pip install -e .
  end
  if test -f requirements.txt
    pip install -r requirements.txt
  end
end

function staging
  # 用途: 使k8s切換到staging cluster
  set -xg CLUSTER g8s-staging
  set -xg GIMG2VEC gimg2vec.gliavideo.cn
  set -xg GBERT gbert.gliavideo.cn

  gcloud container clusters get-credentials g8s-staging --zone=asia-east1-a
  # eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "_ROUTE" "=" $1 ".default.githubhero.com"}')
  # eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "=" "35.187.155.48"}')
end

function knative
  # 用途: 使k8s切換到production cluster
  set -xg CLUSTER g8s-knative
  set -xg GIMG2VEC gimg2vec.gliavideo.cn
  set -xg GBERT gbert.gliavideo.cn

  gcloud container clusters get-credentials g8s-knative --zone=asia-east1-a
  # eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "_ROUTE" "=" $1 ".default.gliavideo.cn"}')
  # eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "=" "35.234.20.242"}')
end
