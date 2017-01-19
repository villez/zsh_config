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

# git completion for aliases
compdef g="git"
compdef _git ga=git-add
compdef _git gb=git-branch
compdef _git gc=git-commit
compdef _git gco=git-checkout
compdef _git gcl=git-clone
compdef _git gm=git-merge
compdef _git gp=git-push
compdef _git gpl=git-pull
compdef _git gr=git-remote
