# check which platform we're on; used for some conditional
# configurations - although trying to minimize those

if [[ $(uname) = 'Linux' ]]; then
    export PLATFORM_LINUX=1
elif [[ $(uname) = 'Darwin' ]]; then
    export PLATFORM_OSX=1
fi

export ZDOTDIR='~/.zsh'
export ZALIAS=$ZDOTDIR/aliases.zsh

# locale settings
export LANG='en_US.UTF-8'
export LC_CTYPE='fi_FI.UTF-8'
export LC_COLLATE=C

# configuring colors for ls; different format for BSD/OSX and GNU/Linux versions
# the two configs here are currently not 1:1 in all details but match well enough
# for the most important cases - normal files, directories, executables, symlinks
if [[ $PLATFORM_OSX -eq 1 ]]; then
    export CLICOLOR=1
    export LSCOLORS="exfxcxdxcxegedabagexex"
fi

# the GNU version; even though BSD/OS X ls uses the LSCOLORS version above,
# export this one on OS X as well so we can reuse this for coloring zsh completions
export LS_COLORS='rs=0:di=00;34:ln=00;35:mh=00:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=00;34:st=37;44:ex=00;32:'


# tools

export PAGER='less'
export EDITOR='~/bin/ec'  # an emacsclient wrapper script

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export LESS="-eXFR"


# setting up the path

# add ~/bin
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
