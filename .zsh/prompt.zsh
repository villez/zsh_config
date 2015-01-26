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
PROMPT+='$gitcolor$(git_prompt_info)%{$reset_color%}'       # git status
PROMPT+='%% '                                               # trailing %
