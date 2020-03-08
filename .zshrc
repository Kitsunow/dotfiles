# Init Prompt and completion
autoload -Uz compinit promptinit up-line-or-beginning-search down-line-or-beginning-search
compinit
promptinit
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Set GPG_TTY
export GPG_TTY=$(tty)

# Set environment variables
export BROWSER=firefox
export EDITOR=nvim
export VISUAL=nvim
export TERM=terminator

# Set the editor used for sudoedit / sudo -e
export SUDO_EDITOR=$EDITOR
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable BEEEEP
setopt NO_BEEP

# Use TAB to select a completion option from the completion menu
zstyle ':completion:*' menu select
setopt completealiases
setopt COMPLETE_IN_WORD

# Additional dirs for PATH
PATH+=":$HOME/skripte:$HOME/.cargo/bin"

# Settings for history
# Save commands in history file without duplicates
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HISTIGNOREALLDUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Share history with other zsh processes
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Allow extended globbing (like rm -- ^*.zip)
setopt extended_glob

# Enable Colors
autoload -U colors && colors

# Vi-like keybindings
#bindkey -v
bindkey -e
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Use Powerline9k prompt
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(context public_ip time newline status root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(context time newline status root_indicator)
# rprompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# 'dir' settings
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_first_and_last"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# color settings for powerlevel9k
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"
POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="249"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="249"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="046"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="166"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="226"
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_PUBLIC_IP_BACKGROUND="black"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="178"

# old prompt (less fancy, though solid)
#PROMPT="%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[white]$bg[black]%}%m%{$reset_color%} %{$fg_no_bold[white]%}%1~ %{$reset_color%}%# "
#RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
#[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
#[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}"  ]] && bindkey  "${key[PageDown]}" history-beginning-search-forward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
  printf '%s' ${terminfo[smkx]}
}
function zle-line-finish () {
printf '%s' ${terminfo[rmkx]}
}
zle -N zle-line-init
zle -N zle-line-finish
fi

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line

# Color definitions
COLOR_BLACK=$'\033'"[${color[black]}m"
COLOR_RED=$'\033'"[${color[red]}m"
COLOR_GREEN=$'\033'"[${color[green]}m"
COLOR_YELLOW=$'\033'"[${color[yellow]}m"
COLOR_BLUE=$'\033'"[${color[blue]}m"
COLOR_MAGENTA=$'\033'"[${color[magenta]}m"
COLOR_CYAN=$'\033'"[${color[cyan]}m"
COLOR_WHITE=$'\033'"[${color[white]}m"

COLOR_BG_BLACK=$'\033'"[${color[bg-black]}m"
COLOR_BG_RED=$'\033'"[${color[bg-red]}m"
COLOR_BG_GREEN=$'\033'"[${color[bg-green]}m"
COLOR_BG_YELLOW=$'\033'"[${color[bg-yellow]}m"
COLOR_BG_BLUE=$'\033'"[${color[bg-blue]}m"
COLOR_BG_MAGENTA=$'\033'"[${color[bg-magenta]}m"
COLOR_BG_CYAN=$'\033'"[${color[bg-cyan]}m"
COLOR_BG_WHITE=$'\033'"[${color[bg-white]}m"

COLOR_BOLD=$'\033'"[${color[bold]}m"
COLOR_RESET=$'\033'"[${color[none]}m"

# Color for Grep-Matching #####################################################
export GREP_COLOR="${color[bold]};${color[blue]}"

# Color for Manpages #########################################################
#export LESS_TERMCAP_md=$COLOR_YELLOW$COLOR_BOLD
export LESS_TERMCAP_md=$COLOR_YELLOW
export LESS_TERMCAP_me=$COLOR_RESET

export LESS_TERMCAP_so=$COLOR_WHITE$COLOR_BG_BLUE
export LESS_TERMCAP_se=$COLOR_RESET

export LESS_TERMCAP_us=$COLOR_RED
export LESS_TERMCAP_ue=$COLOR_RESET
# see man termcap:
#	[...]
#       md   Start bold mode
#       me   End all mode like so, us, mb, md and mr
#       so   Start standout mode
#       se   End standout mode
#       us   Start underlining
#       ue   End underlining
#	[...]

# We don't need a history in less #############################################
export LESSHISTFILE=-

# Invoke ls after cd
function chpwd()
{
  exa
}

# Function to unpack content with different formats
extract()
{
  if [[ -f $1 ]]; then
    case $1 in
      (*.tar.gz | *.tgz) 	  tar xvzf $1   ;;
      (*.tar.bz2 | *.tbz2) 	tar xvjf $1   ;;
      (*.bz2)			          bunzip2 -v $1 ;;
      (*.rar)			          unrar x $1    ;;
      (*.gz)			          gunzip -v $1  ;;
      (*.tar)			          tar xvf $1    ;;
      (*.zip)			          unzip $1      ;;
      (*.Z)		  	          uncompress $1 ;;
      (*.7z)			          7z x $1       ;;
      (*)			              echo "'$1' cannot be extracted with >extract<" ;;
    esac
  else
    echo "Error: '$1' is not a valid file!"
  fi
}

# replacements
alias cp="cp -v"
alias g++="g++ -std=c++17"
alias gdb="cgdb"
alias grep="grep --color=auto"
alias ls='exa'
alias mv="mv -v"
alias python="ipython"
alias rm="rm -v"
alias vi="nvim"
alias vim="nvim"

# System
alias cupson='sudo systemctl start cups-browsed.service'
alias unneeded='sudo pacman -Rs $(pacman -Qtdq)'
alias pacman-preview="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# Option aliases
alias dpmsoff='xset s off;xset -dpms'
alias dpmson='xset s on;xset +dpms'

# config files
alias orc="$EDITOR ~/.config/openbox/rc.xml && openbox --reconfigure"
alias omrc="$EDITOR ~/.config/openbox/menu.xml && openbox --reconfigure"
alias vrc="$EDITOR ~/.vimrc"
alias arc="$EDITOR ~/.config/openbox/autostart"
alias xrc="$EDITOR ~/.xinitrc"
alias zrc="$EDITOR ~/.zshrc && source ~/.zshrc"
alias obcrc="$EDITOR ~/.config/obmenu-generator/config.pl"
alias obsrc="$EDITOR ~/.config/obmenu-generator/schema.pl"

# useful
alias cleantex='rm -I *.log *.aux *.toc'
alias clock='tty-clock -c -S -C 3'
alias ll='exa -l'
alias la='exa -al'
alias lh='exa -d .*'
alias llh='exa -ld .*'
alias mergepdf="gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf"
alias pdf="zathura --fork"
alias spotifyd="systemctl --user start spotifyd"
alias venter="source $HOME/workspace/SpotifyDJ/venv/spotifydj/bin/activate"
alias xp='obxprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias yolo='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'

# Use fuzzy file finder
[ -f ~/.fzf.sh ] && source ~/.fzf.sh
