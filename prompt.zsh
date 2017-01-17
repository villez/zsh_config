# setting the prompt

# color definitions, currently only used in setting the prompt

autoload colors; colors

for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK PR_CYAN PR_MAGENTA
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE PR_BOLD_CYAN PR_BOLD_MAGENTA
export PR_BOLD_WHITE PR_BOLD_BLACK

# use a bit different colors based on OS to help quickly distinguish
# visually which machine each shell is running on

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
PROMPT+='$gitcolor$(git_prompt_info)%{$reset_color%}'       # git status (see separate file)
PROMPT+='%% '                                               # trailing %
