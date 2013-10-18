# general command aliases
alias ..='cd ..'
alias ...='cd ../../'
alias cd..='cd ..'
alias cd...='cd ../../'
alias history='fc -l 1'
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


# handling the different color options between BSD/OSX vs GNU/Linux ls
# an alternative to this mess would be to use the GNU coreutils ls
# also on OS X
if [[ $PLATFORM_OSX -eq 1 ]]; then
    alias l='CLICOLOR_FORCE=1 ls -laGFh'
elif [[ $PLATFORM_LINUX -eq 1 ]]; then
    alias l='ls -laFh --color=always'
fi
alias lld='l -d */ | less'
alias llh='l -d .* | less'

# if no params given or param a directory -> pipe output to less;
# if a non-directory param given, no paging
ll() {
    # if there are parameters
    if [ $# -gt 0 ]; then
	# if a directory given
	if [ -d $1 ]; then
	    l $* | less
	# some params were given, but not a directory
	else
	    l $*
	fi
    # no params given
    else
	l | less
    fi
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

# cd into directory and list it
cdl() {
    cd $1
    ll
}

# cd into a given directory under ~ or ~/src/
# unfortunately completion doesn't work with this; need to investigate a solution
cdh() {
    cd ~/$1
}
cds() {
    cd ~/src/$1
}

# count files
llc() {
  ls -la $* | wc -l
}

# list only directories from given dir
lldd() {
  cd $1
  lld
  cd -
}

# Rails related aliases
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias rails='bundle exec rails'
alias rdb='be rake db:migrate && be rake db:test:prepare'

# OS X specific aliases
if [[ $PLATFORM_OSX -eq 1 ]]; then
    alias ec='~/bin/emacsclient'
    alias blog_new_post='cd ~/octopress; bundle exec rake new_post; ec -n source/_posts/`date +%F`-new-post.markdown'
    alias blog_publish='cd ~/octopress; bundle exec rake generate; bundle exec rake deploy'
    alias bpn='blog_new_post'
    alias bpp='blog_publish'
    alias sus='pmset sleepnow'
fi
