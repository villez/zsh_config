# Functions to parse the git status from the current working directory
# for display in the prompt.
#
# The status is displayed in the form "(master *)" on a separate line from the
# beginning of the prompt to keep enough room for commands without wrapping. "master"
# is the current git branch, and "*" is 0 or more characters displaying the state
# of the repository - if committed and clean, nothing is shown, otherwise a combination
# of characters showing added/modified/untracked files etc. as defined by the variables
# at the beginning of the git_status_in_symbols() function

git_prompt_info() {
    local current_branch git_status
    current_branch=$(git symbolic-ref HEAD 2> /dev/null) || return
    git_status=$(git_status_in_symbols)
    if [[ -n $git_status ]]; then  # if there is a nonempty status string, 
        git_status=" $git_status"  # insert space before it (i.e. between branch name & the symbols)
    fi
    git_status="\n(${current_branch#refs/heads/}$git_status)"
    echo $git_status
}

git_status_in_symbols() {
    local untracked="*"
    local added="+"
    local modified="*"
    local renamed="~"
    local deleted="!"
    local unmerged="?"
    local ahead=">"
    local behind="<"

    local index combined_status

    index=$(git status --porcelain 2> /dev/null)
    combined_status=""

    if (( $(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l) )); then
        combined_status+="$behind"
    fi
    if (( $(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l) )); then
        combined_status+="$ahead"
    fi
    if $(echo "$index" | grep '^UU ' &> /dev/null); then
        combined_status+="$unmerged"
    fi
    if $(echo "$index" | grep -e '^ D ' -e '^AD ' &> /dev/null); then
        combined_status+="$deleted"
    fi
    if $(echo "$index" | grep '^R  ' &> /dev/null); then
        combined_status+="$renamed"
    fi
    if $(echo "$index" | grep -e '^ M ' -e '^AM ' -e '^ T ' &> /dev/null); then
        combined_status+="$modified"
    fi
    if $(echo "$index" | grep -e '^A  ' -e '^M  ' &> /dev/null); then
        combined_status+="$added"
    fi
    if $(echo "$index" | grep '^?? ' &> /dev/null); then
        combined_status+="$untracked"
    fi

    echo $combined_status
}


