# locale settings
export LANG='en_US.UTF-8'
export LC_CTYPE='fi_FI.UTF-8'

# configuring colors for ls; different format for BSD/OSX and GNU/Linux versions
# the two versions are currently not 1:1 in all details but match for the most
# important cases - directories, executables, symlinks and the like
export CLICOLOR=1
if [[ $PLATFORM_OSX -eq 1 ]]; then
    export LSCOLORS="exfxcxdxcxegedabagexex"
elif [[ $PLATFORM_LINUX -eq 1 ]]; then
    export LS_COLORS='rs=0:di=00;34:ln=00;35:mh=00:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=00;34:st=37;44:ex=00;32:'
fi

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export LESS="-eXFR"

export PAGER='less'
export EDITOR='~/bin/emacsclient'

export LC_COLLATE=C


# setting up the path
# common: add ~/bin

export PATH="$PATH:$HOME/bin"

# rbenv path + initialization
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"


# OS X specific additions
if [[ $PLATFORM_OSX -eq 1 ]]; then
    export PATH="$PATH:/usr/local/sbin"

    # Perlbrew
    source ~/perl5/perlbrew/etc/bashrc
fi
