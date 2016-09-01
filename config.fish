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
set -x PATH /usr/local/lib/python2.7.12/bin /usr/local/lib/python3.5.2/bin $PATH



set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '🗲'
set __fish_git_prompt_char_stagedstate '➔'
set __fish_git_prompt_char_untrackedfiles '𝐙'
set __fish_git_prompt_char_stashstate '⚑'
set __fish_git_prompt_char_upstream_ahead '➕'
set __fish_git_prompt_char_upstream_behind '➖'


function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

