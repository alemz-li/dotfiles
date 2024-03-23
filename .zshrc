export ZSH="$HOME/.oh-my-zsh"
export GIT_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export HISTORY_IGNORE="(ls|cd|pwd|exit|reboot|off|history|cd -|cd ..)"
export TERMINAL="alacritty"
export BROWSER="firefox"
export ZSH_THEME="spaceship"
export SPACESHIP_CONFIG="$HOME/.dotfiles/.config/spaceship.zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/bin/obsidian"

plugins=(dirhistory git node colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)

alias vim="nvim"
alias neofetch="neofetch --ascii_distro fedora_small"
alias cava="TERM=st-256color cava"
alias r='ranger'
alias lg="lazygit"

# power options
alias off='poweroff'
alias sus='systemctl suspend'

# exa
alias lsi='exa --icons --long'

alias sz='source $HOME/.zshrc'
alias settings="XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

source $ZSH/oh-my-zsh.sh
