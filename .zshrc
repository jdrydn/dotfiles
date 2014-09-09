ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ll="ls -lF --group-directories-first"

export EDITOR="vim"

if [ -f ~/.zsh_more ]; then
    . ~/.zsh_more
fi

if [ -f ~/.thehub/scripts/welcome ]; then
	. ~/.thehub/scripts/welcome
else
	printf "You have not set up the screen selector yet...\n"
fi

