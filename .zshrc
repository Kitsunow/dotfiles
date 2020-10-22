# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Environment variables for ROS
if [[ -e "/opt/ros/melodic/setup.zsh" ]]; then
    source "/opt/ros/melodic/setup.zsh"
fi

# Use Powerlevel10k prompt
[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ] && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Init Prompt and completion
autoload -Uz compinit promptinit up-line-or-beginning-search down-line-or-beginning-search
compinit
kitty + complete setup zsh | source /dev/stdin
promptinit
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Disable BEEEEP
setopt NO_BEEP

# Use TAB to select a completion option from the completion menu
zstyle ':completion:*' menu select
setopt COMPLETEALIASES
setopt COMPLETE_IN_WORD

# Ignore duplicate commands in history
setopt HISTIGNOREALLDUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Share history with other zsh processes
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Allow extended globbing (like rm -- ^*.zip)
setopt EXTENDED_GLOB

# Enable Colors
autoload -U colors && colors

# Emacs-like keybindings
bindkey -e
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

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
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}"  ]] && bindkey  "${key[PageDown]}" history-beginning-search-forward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Edit commands in external editor
autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line

# Invoke ls after cd
function chpwd()
{
    $LS $COLOR
}

############# Function goes here #################
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

############# Aliases goes here #################
# replacements
alias cp="cp -v"
alias g++="g++ -std=c++17"
alias gdb="cgdb"
alias grep="grep --color=auto"
alias ls="$LS $COLOR"
alias mv="mv -v"
alias python="ipython"
alias rm="rm -v"
alias vi="nvim"
alias vim="nvim"

# System
alias cupson='sudo systemctl start cups-browsed.service'
alias unneeded='sudo pacman -Rs $(pacman -Qtdq)'
alias pacman-preview="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias update="sudo pacman -Syu && pikaur -Syu && pikaur -Scc"

# Option aliases
alias dpmsoff='xset s off;xset -dpms'
alias dpmson='xset s on;xset +dpms'

# config files
alias arc="$EDITOR ~/.config/openbox/autostart"
alias orc="$EDITOR ~/.config/openbox/rc.xml && openbox --reconfigure"
alias omrc="$EDITOR ~/.config/openbox/menu.xml && openbox --reconfigure"
alias obcrc="$EDITOR ~/.config/obmenu-generator/config.pl"
alias obsrc="$EDITOR ~/.config/obmenu-generator/schema.pl"
alias vrc="$EDITOR ~/.vimrc"
alias zrc="$EDITOR ~/.zshrc && source ~/.zshrc"

# useful
alias ll="ls -l"
alias la="ls -al"
alias lh="ls -d .*"
alias llh="ls -ld .*"
alias mergepdf="gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf"
alias pdf="zathura --fork"
alias xp='obxprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias yolo='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'

# Use fuzzy file finder
[ -f ~/.fzf.sh ] && source ~/.fzf.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
