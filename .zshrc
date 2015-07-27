ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(atom brew encode64 git httpie npm nyan osx screen sudo vagrant web-search)

source $ZSH/oh-my-zsh.sh

#alias ll="ls -lF --group-directories-first"
alias putio="node ~/.dotfiles/putio/putio.js $@"
alias sshserver="sh ~/.dotfiles/ssh-server/script.sh"
alias xkcd-password="bash ~/.dotfiles/xkcd-password.sh $@"

export EDITOR=vim
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/npm/bin:$HOME/bin:$HOME/.bin

if [ -f ~/.zsh_more ]; then
    . ~/.zsh_more
fi

if [ -f ~/.dotfiles/welcome ]; then
	. ~/.dotfiles/welcome
else
	printf "You have not set up the screen selector yet...\n"
fi
