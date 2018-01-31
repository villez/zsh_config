# general configuration exports such as PATH and default options for
# other utility prorams

# history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# locale settings
export LANG='en_US.UTF-8'
export LC_CTYPE='fi_FI.UTF-8'
export LC_COLLATE=C


# the GNU version of color configuration for ls; even though BSD/OS X ls uses the LSCOLORS
# version (defined in osx.zsh), this is included for both platforms so it can be
# reused for coloring zsh completions
export LS_COLORS='rs=0:di=00;34:ln=00;35:mh=00:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=00;34:st=37;44:ex=00;32:'

# tool configuration
export EDITOR='~/bin/ec'  # an emacsclient wrapper script
export PAGER='less'
export LESS="-eXFR"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# setting up the path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin"

# add Chef Development Kit to path
if [ -d "/opt/chefdk/bin" ]; then
    export PATH="/opt/chefdk/bin:$PATH"
fi

# add Rust toolchain to path
export PATH="$HOME/.cargo/bin:$PATH"
