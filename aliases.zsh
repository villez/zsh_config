# general command aliases
alias ..='cd ..'
alias ...='cd ../../'
alias history='fc -l 1'
alias l='ls -laGFh'
alias lld='ls -laGFhd */ | less'
alias llh='ls -laGFhd .* | less'
alias md='mkdir -pv'
alias q='exit'
alias rake='noglob rake'  # allow task[param] argument format
alias rc='~/bin/rbcal'
alias rd='rmdir'
alias rmf='rm -f'
alias rmrf='rm -rf'
alias sr='screen -D -R'
alias topc='top -o cpu'
alias treed='tree -d --charset=utf-16 -C'

# if no params or param a directory -> pipe to less
# use the special environment variable CLICOLOR_FORCE to
# make ls use colors when the output is non-terminal
ll() {
    # if there are parameters
    if [ $# -gt 0 ]; then
	# if a directory given
	if [ -d $1 ]; then
	    CLICOLOR_FORCE=1 l $* | less
	# some params were given, but not a directory
	else
	    l $*
	fi
    # no params given
    else
	CLICOLOR_FORCE=1 l | less
    fi
}

# create new directory and cd into it
take() {
    mkdir -p $1
    cd $1
}

# cd into directory and list it
cdl() {
    cd $1
    ll
}
    

# count files
llc() {
  ls -la $* | wc -l
}

# list only directories from given dir
lldd() {
  cd $1
  ls -laGFhd */
  cd -
}

# Rails related aliases
alias be='bundle exec'
alias rdb='rake db:migrate && rake db:test:prepare'


#
# OS X specific configs

if [[ $PLATFORM_OSX -eq 1 ]]; then
    alias ec='~/bin/emacsclient'
    alias blog_new_post='cd ~/octopress; bundle exec rake new_post; ec source/_posts/`date +%F`-new-post.markdown'
    alias blog_publish='cd ~/octopress; bundle exec rake generate; bundle exec rake deploy'
    alias psqlstart='/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start'
    alias psqlstop='/usr/local/pgsql/bin/pg_ctl stop'
fi
