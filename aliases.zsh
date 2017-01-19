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
alias vc='vscal'

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

# create a new directory, cd into it and initialize
# an empty git repo
takeg() {
    take $1
    git init
}

# Display the number of files/directories within the given directory/directories.
# The -A and -1 ls options mean: include dotfiles except the . and .. directories, and
# produce 1-column output => the number of lines is the number of entries, can
# be counted easily with wc -l
# If several directories are given as parameters, the result is the sum of the entries
# in all of them.
llc() {
    ls -A1 $* | wc -l
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

# custom completion definitions for the cdh() and cds() functions
compdef "_directories -W ~ -/" cdh
compdef "_directories -W ~/src -/" cds


# A convenience function to display a given command's contents, if possible,
# without having to remember whether it's an alias, a shell function,
# a shell script etc.
lw() {
    cmdtype=$(whence -w $1)
    if [[ $cmdtype =~ 'builtin' ]]; then
        type $1
    elif [[ $cmdtype =~ 'function' ]]; then
        type $1
        echo
        type -f $1 | less
    elif [[ $cmdtype =~ 'alias' ]]; then
         type -f $1 | less
    elif [[ $cmdtype =~ 'command' ]]; then
        # checking the executable file's type using the "file" command
        # to avoid trying to output binaries
        filetype=$(file -L $(whence -c $1))
        if [[ $filetype =~ 'text executable' ]] ||
               [[ $filetype =~ 'ASCII' ]] ||
               [[ $filetype =~ 'UTF-8' ]]; then
            {
                echo "$(tput bold)script: $(whence $1)$(tput sgr0)\n";
                cat $(whence $1);
            } | less
        else
            echo "unrecognized/binary file: $(whence $1)"
        fi
    else
        echo "$1 not found"
    fi
}

compdef "_files -W ~/bin/ -/" lw


# start a Python simple HTTP web server in current directory
shttp() {
    python -m SimpleHTTPServer $*
}



# PostgreSQL - note OS-specific start/stop/restart aliases defined in the
# osx.zsh and linux.zsh files
alias pg='psql'
alias pgl='psql --list'
alias pgrestart=pg_restart
alias pgstop=pg_stop
alias pgstart=pg_start
