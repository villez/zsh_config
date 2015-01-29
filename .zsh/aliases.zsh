# A collection of utility aliases and simple functions. Some are
# platform-specific (or customized based on platform), but most are
# common. The main distinction is that functions are used when there's a need
# to refer to the command-line arguments in one way or the other in the
# definition, even if it's just pass-through to another command. 


# general command aliases
alias ..='cd ..'
alias ...='cd ../../'
alias cd..='cd ..'
alias cd...='cd ../../'
alias a+x='chmod a+x'
alias a-x='chmod a-x'
alias du='du -h'
alias du0='du -h -d0'
alias du1='du -h -d1'
alias history='fc -l 1'
alias md='mkdir -pv'
alias q='exit'
alias rc='rbcal'
alias rd='rmdir'
alias rez='source $HOME/.zshrc'
alias rmf='rm -f'
alias rmrf='rm -rf'
alias sr='screen -D -R'
alias tarc='tar cvzf'
alias tart='tar tvzf'
alias tarx='tar xvzf'
alias topc='top -o cpu'
alias treed='tree -d --charset=utf-16 -C'

# handling the different color options between BSD/OS X vs GNU/Linux ls;
# the color configuration is in exports.zsh
if on_osx; then
    alias l='CLICOLOR_FORCE=1 ls -laGFh'
else
    alias l='ls -laFh --color=always'
fi

# directory listing aliases
alias lld='l -d */ | less'  # directories only
alias llh='l -d .* | less'  # hidden files only

# function wrapper to do paging for directory listing, handling
# possible command line file/directory parameters separately
ll() {
    l $* | less
}

# directory listing with file size sorting
lls() {
    l -S $* | less
}

# directory listing with file modification time sorting
llt() {
    l -t $* |less
}

# list only directories from given dir
lldd() {
    cd $1
    lld
    cd -
}

# create new directory and cd into it
take() {
    mkdir -p $1
    cd $1
}

# count files in the directory listing
llc() {
    ls -la $* | wc -l
}

# create a new directory, cd into it and initialize
# an empty git repo
takeg() {
    take $1
    git init
}

# cd into directory and list it
cdl() {
    cd $1
    ll
}

# cd into a given directory under ~ or ~/src/
# note: directory completion for these defined in completion.zsh
cdh() {
    cd ~/$1
}
cds() {
    cd ~/src/$1
}



# Find the path to the first argument using which, then less it.
# 'which' only searches the PATH for executables, so this is
# mainly useful for viewing scripts without typing the full dirname
# Note: be careful with binary files and less options...
lw() {
    local f=$(which $1)
    if [ -e $f ]; then
        less $f
    else
        echo "$1 not found"
    fi
}


# start a Python simple HTTP web server in current directory
shttp() {
    python -m SimpleHTTPServer $*
}


#
# Git related aliases and functions
#

g() {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

alias ga='git add'
alias gaa='git add --all .'
alias gap='git add -p'
alias gb='git branch'
alias gbd='git branch -d'
alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gcl='git clone'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcof='git checkout -f'
alias gl='git ls3'  # ls3 is git log with custom format, defined in .gitconfig
alias glh='git ls3 | head'
alias gm='git merge'
alias gp='git push'
alias gpo='git push -u origin master'
alias gpgh='git push github'
alias gph='git push heroku'
alias gpl='git pull'
alias gr='git remote'
alias gra='git remote add'
alias grr='git remote rm'
alias gru='git remote update'
alias grv='git remote -v'
alias grh='git reset --hard'
alias gus='git reset HEAD --'
alias gx='git reset --hard && git clean -df'



# Rails related aliases & functions

# make a wrapper for commands that should be run either as
#  - binstubbed version (./bin/command)
#  - bundle exec'd version
#  - plain version
# in that priority order

# note: noglob used because of rake, as zsh globbing clashes
# with rake's task[params] command line argument format

binstub_or_bundle_cmds=(spec rspec rails rake guard spring) # add more as becomes relevant

run_binstub_or_bundle_exec() {
    local cmdname=$1
    shift
    if [ -x ./bin/$cmdname ]; then
        noglob bin/$cmdname $@
    elif [ -e ./Gemfile ]; then
        noglob bundle exec $cmdname $@
    else
        noglob $cmdname $@
    fi
}

for command in $binstub_or_bundle_cmds
do
    alias $command="run_binstub_or_bundle_exec $command"
done

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

alias cov='rspec spec/ && open coverage/index.html'

alias rlc='rails console'
alias rlg='rails generate'
alias rls='rails server'
alias rdb='rake db:migrate && rake db:test:prepare'


# npm related aliases
alias ni='npm install'
alias nig='npm install -g'
alias nu='npm update'


#
# OS X specific aliases and functions
#
if on_osx; then
    # alias git to Homebrew version on OS X as the stock version isn't kept
    # up to date by Apple
    alias git="/usr/local/bin/git"  
    
    # configure df to use human readable units and only show certain filesystem types
    alias df='df -P -T hfs,smbfs -H'

    # accessing OS X clipboard from the shell
    alias pbc='pbcopy'
    alias pbp='pbpaste'

    # Homebrew related aliases
    alias bri='brew install'
    alias bru='brew upgrade'
    alias bruu='brew update'

    # Macbook and OS X low level stuff, may change with hardware/OS versions
    alias batterycheck='ioreg -l -w0 | grep Capacity  | cut -d"|" -f3 | tr -s " "'
    alias wifioff='networksetup -setairportpower en0 off'  # en0 is the Wi-Fi device on current MBP
    alias wifion='networksetup -setairportpower en0 on'    # see networksetup -lisetnetworkserviceorder
    alias wifirestart='wifioff; wifion'
    alias zzz='pmset sleepnow'
    
    # Qt Creator
    alias qtc='open ~/Qt5Latest/Qt\ Creator.app'
    
    # PostgreSQL
    alias pg_start='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
    alias pg_stop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
    alias pg_restart='pg_stop; pg_start'
    
    # vlc
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
    
    # Octopress: create a new post with given title, if any, and open it using
    # the "ec" emacsclient wrapper
    bpn() {
        cd ~/octopress
        local POST
        POST="$(noglob bundle exec rake new_post[$1] | cut -d' ' -f 4)"
        ec -n $POST
    }

    alias bnp='bpn'
    alias bpp='cd ~/octopress && bundle exec rake generate && bundle exec rake deploy && git add . && git commit -m "new post `date`" && git push origin master && cd'


    # a couple of Terminal.app aliases using AppleScript
    # open a Terminal.app window much larger than my default
    bigterm() {
        osascript -e 'tell application "Terminal" to do script'
        osascript -e 'tell application "Terminal" to set bounds of the front window to {0, 20, 1000, 830}'
    }

    # open a Terminal.app window smaller than my default
    smallterm() {
        osascript -e 'tell application "Terminal" to do script'
        osascript -e 'tell application "Terminal" to set bounds of the front window to {0, 20, 585, 410}'
    }

    # open a new terminal window and run the given command in it
    # example: $ nw ssh -l foo 192.168.0.100
    nw() {
        osascript -e 'on run argv' -e 'tell application "Terminal" to do script argv' -e 'end run' "$*"
    }

fi

# Linux specific aliases
if on_linux; then
    # configure df to use human readable units and only show certain filesystem types
    alias df='df -H -x tmpfs -x devtmpfs'

    if on_fedora; then
        # PostgreSQL
        alias pg_start='sudo systemctl start postgresql-9.3'
        alias pg_stop='sudo systemctl stop postgresql-9.3'
        alias pg_restart='sudo systemctl restart postgresql-9.3'
        
        # Fedora Systemd services
        alias sc='systemctl'
        alias scstart='sudo systemctl start'
        alias scstop='sudo systemctl stop'
        alias screload='sudo systemctl reload'
        alias screstart='sudo systemctl restart'
        alias scstatus='systemctl status'

        # Yum
        alias yi='sudo yum install'
        alias yu='sudo yum update'

    elif on_ubuntu; then
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
    fi
fi

# PostgreSQL - note OS-specific start/stop/restart aliases defined above
alias pg='psql'
alias pgl='psql --list'
alias pgrestart=pg_restart
alias pgstop=pg_stop
alias pgstart=pg_start
    
