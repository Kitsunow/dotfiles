# Set PATH to array path
typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/bin" "$HOME/.cargo/bin" "$path[@]")
export PATH

# Set environment variables
export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim
export COLOR=--color=always

# Set the editor used for sudoedit / sudo -e
export SUDO_EDITOR=$EDITOR

# Settings for zsh history file
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Check if we can use exa or fall back to ls
if (( $+commands[exa] )); then
    export LS=/usr/bin/exa
else
    export LS=/usr/bin/ls
fi

# We don't need a history in less
export LESSHISTFILE=-

# Color for Manpages (see man termcap):
#       md   Start bold mode
#       me   End all mode like so, us, mb, md and mr
#       so   Start standout mode
#       se   End standout mode
#       us   Start underlining
#       ue   End underlining
export LESS_TERMCAP_md=$'\033'"[${color[yellow]}m"
export LESS_TERMCAP_me=$'\033'"[${color[none]}m"
export LESS_TERMCAP_so=$'\033'"[${color[white]}m"$'\033'"[$color[bg-blue]]"
export LESS_TERMCAP_se=$'\033'"[${color[none]}m"
export LESS_TERMCAP_us=$'\033'"[${color[red]}m"
export LESS_TERMCAP_ue=$'\033'"[${color[none]}m"

# Color for Grep-Matching
export GREP_COLOR="${color[bold]};${color[blue]}"
