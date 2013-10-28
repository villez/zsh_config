# quiet!
setopt no_beep

# filename generation
setopt extended_glob

# history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_no_store
setopt hist_verify

# completion
setopt always_to_end
setopt auto_menu
setopt complete_in_word
unsetopt menu_complete

# spelling correction for commands
setopt correct

# prompt: enable parameter expansion, command substitution, and
# arithmetic expansion
setopt prompt_subst
