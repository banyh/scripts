alias ll 'ls -laFh'
alias l 'ls -CF'
alias du 'du -h'
alias df 'df -h'
alias .. 'cd ..'
alias ... 'cd ../..'
alias vs 'rsub -p 52689'
alias sub 'rsub -p 52698'

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x PATH ~/bin /usr/local/lib/python2.7.12/bin /usr/local/lib/python3.5.2/bin $PATH

git config --global user.name "banyh"
git config --global user.email banyhong@gliacloud.com

# for better powerline display, disable original virtualenv prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

function fish_prompt
  ~/bin/powerline-shell/powerline-shell.py --shell bare --cwd-max-depth 4 --mode patched
end
