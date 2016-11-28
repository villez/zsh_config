# reference: http://zsh.sourceforge.net/Doc/Release/Options.html

# prevent stdout redirection from accidentally overwriting an existing file
setopt no_clobber

# quiet!
setopt no_beep

# filename generation
setopt extended_glob

# changing directories
setopt no_autocd
setopt no_auto_pushd
setopt pushd_ignore_dups
setopt auto_name_dirs
setopt no_cdable_vars
setopt auto_param_slash

# history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_no_store
setopt hist_verify
setopt hist_ignore_dups
setopt share_history

# completion
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt no_menu_complete
setopt list_packed

# spelling correction for commands
setopt correct
setopt no_correctall

# prompt: enable parameter expansion, command substitution, and
# arithmetic expansion
setopt prompt_subst
