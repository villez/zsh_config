# Linux specific aliases
# Note: currently based on Ubuntu; earlier had separate set of configs for
# Fedora/Redaht, but not using them at the moment so removed those.

# configure df to use human readable units and only show certain filesystem types
alias df='df -H -x tmpfs -x devtmpfs'

# PostgreSQL
alias pg_start='sudo service postgresql start'
alias pg_stop='sudo service postgresql stop'
alias pg_restart='sudo service postgresql restart'

# Ubuntu init.d services
scstart() { sudo service $1 start }
scstop() { sudo service $1 stop }
screload() { sudo service $1 reload }
screstart() { sudo service $1 restart }
scstatus() { service $1 status }

# apt-get
alias ai='sudo apt-get install'
alias au='sudo apt-get update && sudo apt-get upgrade'
alias auu='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'

# Package information
alias pkg-all='dpkg --get-selections|grep -v deinstall|cut -f1'
alias pkg-for-file='dpkg -S'
alias pkg-info='dpkg -p'
alias pkg-list-files='dpkg -L'
