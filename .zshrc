# The entry zsh configuration file. Does not contain any actual settings itself,
# but is rather used to load all the different


# Helper functions to check which platform we're on
# Used for some conditional configurations both in this file and others - although
# trying to minimize platform-specific parts as much as feasible
on_osx() { [[ $(uname) = 'Darwin' ]] }
on_linux() { [[ $(uname) = 'Linux' ]] }

#
# OS environment specific settings and aliases
#
if on_osx; then
    source ~/.zsh/osx.zsh
elif on_linux; then
    source ~/.zsh/linux.zsh
fi

#
# General setting exports for standard Unix and tooling environment variables
#
source ~/.zsh/exports.zsh

#
# Setting zsh-specific options
#
source ~/.zsh/setopt.zsh

#
# helper functions for Git status in prompt, and the actual prompt
# configuration which uses it
#
source ~/.zsh/git_prompt.zsh
source ~/.zsh/prompt.zsh

#
# Configuring zsh completions and module for supporting searching the history
#
source ~/.zsh/completion.zsh
source ~/.zsh/history-substring-search.zsh

#
# Custom keybindings
#
source ~/.zsh/keybindings.zsh

#
# General aliases; tool-specific aliases being moved to tool-specific modules
# (Git, Ruby etc.)
#
source ~/.zsh/aliases.zsh

#
# stuff related to setting terminal window and/or tab titles
#
source ~/.zsh/zsh_hooks.zsh

#
# aliases and configurations etc. for specific toolsets
#
source ~/.zsh/git.zsh
source ~/.zsh/ruby_and_rails.zsh
source ~/.zsh/node.zsh

#
# private stuff, not included in the public repo; additional file existence check
# as the private parts might not be there in every machine this configuration is used on
#
if [ -f ~/.zsh/private/private.zsh ]; then
    source ~/.zsh/private/private.zsh
fi
