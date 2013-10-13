ZSH_THEME_GIT_PROMPT_PREFIX="$PR_BOLD_YELLOW
("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="*"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
ZSH_THEME_GIT_PROMPT_AHEAD=">"
ZSH_THEME_GIT_PROMPT_BEHIND="<"

my_git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    GIT_STATUS=$(git_prompt_status)
    [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi

  local ahead behind remote
  local -a gitstatus

  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  if [[ -n ${remote} ]] ; then
      ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
      (( $ahead )) && STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"

      behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
      (( $behind )) && STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  echo $STATUS
}


if [[ $PLATFORM_OSX -eq 1 ]]; then
    PROMPT='[$PR_BOLD_GREEN%n@%m:%{$reset_color%}'           # user@host (green)
    PROMPT+='$PR_BOLD_BLUE${PWD/#$HOME/~}%{$reset_color%}]'  # working directory (blue)
    PROMPT+='$(my_git_prompt_info)'                          # git status on next line (yellow)
    PROMPT+='%% '                                            # trailing %
fi

if [[ $PLATFORM_LINUX -eq 1 ]]; then
    PROMPT='[$PR_BOLD_CYAN%n@%m:%{$reset_color%}'           # user@host (green)
    PROMPT+='$PR_BOLD_MAGENTA${PWD/#$HOME/~}%{$reset_color%}]'  # working directory (blue)
    PROMPT+='$(my_git_prompt_info)'                          # git status on next line (yellow)
    PROMPT+='%% '                                            # trailing %
fi
