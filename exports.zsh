# locale settings
export LANG='en_US.UTF-8'
export LC_CTYPE='fi_FI.UTF-8'

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export LESS="-eXFR"

export PAGER='less'
export EDITOR='~/bin/emacsclient'

export LC_COLLATE=C

#
# OS X specific configs below:
#

if [[ $PLATFORM_OSX -eq 1 ]]; then
    PATH="$PATH:$HOME/bin:/usr/local/sbin"; export PATH

    # rbenv
    PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"; export PATH
    eval "$(rbenv init -)"

    # Perlbrew
    source ~/perl5/perlbrew/etc/bashrc

    # SML-NJ
    PATH="/usr/local/Cellar/smlnj/110.75/libexec/bin:$PATH"; export PATH
fi

if [[ $PLATFORM_LINUX -eq 1 ]]; then
    PATH="$PATH:$HOME/bin/"
fi
