alias ll 'ls -laFh'
alias l 'ls -CF'
alias du 'du -h'
alias df 'df -h -x squashfs -T -x tmpfs'
alias .. 'cd ..'
alias ... 'cd ../..'
alias delh 'echo all | history --delete --prefix locate & echo 1 | history --delete --prefix locate'
alias op gnome-open

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x PATH ~/bin /usr/local/lib/python3.7.1/bin $PATH
set -x LOCATE_PATH /var/lib/mlocate/backup.db:/var/lib/mlocate/qnap.db

# for better powerline display, disable original virtualenv prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
# for python package "better_exceptions"
set -x BETTER_EXCEPTIONS 1

function fish_prompt
    powerline-shell --shell bare $status
end

function staging
  set -xg CLUSTER g8s-staging
  gcloud container clusters get-credentials g8s-staging --zone=asia-east1-a
  set -xg GIMG2VEC gimg2vec.gliavideo.cn
  eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "_ROUTE" "=" $1 ".default.githubhero.com"}')
  eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "=" "35.187.155.48"}')
end
function knative
  set -xg CLUSTER g8s-knative
  set -xg GIMG2VEC gimg2vec.gliavideo.cn
  gcloud container clusters get-credentials g8s-knative --zone=asia-east1-a
  eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "_ROUTE" "=" $1 ".default.gliavideo.cn"}')
  eval (kubectl get svc | grep "ExternalName" | grep -v "admin" | awk '{gsub(/-/, "_"); print "export " toupper($1) "=" "35.234.20.242"}')
end
