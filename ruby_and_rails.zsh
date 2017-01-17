# rbenv path + initialization
if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
    eval "$(rbenv init -)"
fi

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
