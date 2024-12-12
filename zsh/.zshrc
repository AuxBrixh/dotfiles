export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/lib"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

alias ll="ls -lah"
alias la='ls -A'
alias l='ls -CF'
alias gs="git status"
alias ..="cd .."

setopt autocd
setopt histignoredups
setopt sharehistory
setopt no_beep

source $ZSH/oh-my-zsh.sh
if [ -f "$ZSH/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source $ZSH/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f "$ZSH/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $ZSH/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -x /usr/lib/command-not-found ]; then
    function command_not_found_handler {
        /usr/lib/command-not-found -- "$1"
    }
fi

eval "$(starship init zsh)"