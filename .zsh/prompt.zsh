GIT_PROMPT_UNTRACKED="*"
GIT_PROMPT_ADDED="+"
GIT_PROMPT_MODIFIED="*"
GIT_PROMPT_RENAMED="~"
GIT_PROMPT_DELETED="!"
GIT_PROMPT_UNMERGED="?"
GIT_PROMPT_AHEAD=">"
GIT_PROMPT_BEHIND="<"

my_git_prompt_info() {
    current_branch=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "\n(${current_branch#refs/heads/}$GIT_STATUS)"
}

git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$GIT_PROMPT_UNMERGED$STATUS"
  fi

  local ahead behind remote
  local -a gitstatus

  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  if [[ -n ${remote} ]] ; then
      ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
      (( $ahead )) && STATUS="$GIT_PROMPT_AHEAD$STATUS"

      behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
      (( $behind )) && STATUS="$GIT_PROMPT_BEHIND$STATUS"
  fi
  echo $STATUS
}


# setting the prompt with coloring
# use a bit different colors based on OS to give a quick
# visual indication which machine each terminal is connected to

if on_osx; then
    usercolor=$PR_BOLD_GREEN
    dircolor=$PR_BOLD_BLUE
    gitcolor=$PR_BOLD_YELLOW
else
    usercolor=$PR_BOLD_CYAN
    dircolor=$PR_BOLD_MAGENTA
    gitcolor=$PR_BOLD_YELLOW
fi

PROMPT='[$usercolor%n@%m:%{$reset_color%}'                  # user@host
PROMPT+='$dircolor${PWD/#$HOME/~}%{$reset_color%}]'         # working directory
PROMPT+='$gitcolor$(my_git_prompt_info)%{$reset_color%}'    # git status
PROMPT+='%% '                                               # trailing %
