# color definitions, currently only used in setting the prompt

autoload colors; colors

for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK PR_CYAN PR_MAGENTA
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE PR_BOLD_CYAN PR_BOLD_MAGENTA
export PR_BOLD_WHITE PR_BOLD_BLACK
