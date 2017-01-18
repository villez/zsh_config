#
# OS X specific aliases and functions
#

# configuring colors for ls; note: the BSD/OSX and GNU/Linux versions of ls use
# a different configuration mechanism; the GNU version is in exports.zsh as it is
# also used for zsh completions on OS X
export CLICOLOR=1
export LSCOLORS="exfxcxdxcxegedabagexex"


# open a file or URL (given as parameter) with Chrome
alias chrome='open -a "Google Chrome"'

# alias git to Homebrew version on OS X instead of the Apple-provided version
# which isn't kept as up to date
# prefer doing this instead of putting /usr/local/bin ahead of /usr/bin in the path
alias git="/usr/local/bin/git"

# configure df to use human readable units and only show certain filesystem types
alias df='df -P -T hfs,smbfs -H'

# accessing OS X clipboard from the shell
alias pbc='pbcopy'
alias pbp='pbpaste'

# quick look preview a file from the command line
alias ql='qlmanage -p 2>/dev/null'

# Homebrew related aliases
alias bri='brew install'
alias bru='brew upgrade'
alias bruu='brew update'
alias brc='brew cleanup -s'

# Macbook and OS X low level stuff, may change with hardware/OS versions
alias batterycheck='ioreg -l -w0 | grep Capacity  | cut -d"|" -f3 | tr -s " "'
alias wifioff='networksetup -setairportpower en0 off'  # en0 is the Wi-Fi device on current MBP
alias wifion='networksetup -setairportpower en0 on'    # see networksetup -lisetnetworkserviceorder
alias wifirestart='wifioff; wifion'
alias zzz='pmset sleepnow'

# PostgreSQL
alias pg_start='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
alias pg_stop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
alias pg_restart='pg_stop; pg_start'

# vlc
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# Octopress: create a new post with given title, if any, and open it using
# the "ec" emacsclient wrapper
bpn() {
    cd ~/octopress
    local POST
    POST="$(noglob bundle exec rake new_post[$1] | cut -d' ' -f 4)"
    ec -n $POST
}

alias bnp='bpn'
alias bpp='cd ~/octopress && bundle exec rake generate && bundle exec rake deploy && git add . && git commit -m "new post `date`" && git push origin master && cd'


# a couple of Terminal.app aliases using AppleScript
# open a Terminal.app window much larger than my default
bigterm() {
    osascript -e 'tell application "Terminal" to do script'
    osascript -e 'tell application "Terminal" to set bounds of the front window to {0, 20, 1000, 830}'
}

# open a Terminal.app window smaller than my default
smallterm() {
    osascript -e 'tell application "Terminal" to do script'
    osascript -e 'tell application "Terminal" to set bounds of the front window to {0, 20, 585, 410}'
}

# open a new terminal window and run the given command in it
# example: $ nw ssh -l foo 192.168.0.100
nw() {
    osascript -e 'on run argv' -e 'tell application "Terminal" to do script argv' -e 'end run' "$*"
}
