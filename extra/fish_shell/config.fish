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
