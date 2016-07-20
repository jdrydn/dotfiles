ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(atom brew emoji encode64 git httpie npm nyan osx screen vagrant web-search)

source $ZSH/oh-my-zsh.sh

#alias ll="ls -lF --group-directories-first"
alias sorry='sudo $(history -p !-1)'
alias sshserver="sh ~/.dotfiles/ssh-server/script.sh"
alias xkcd-password="bash ~/.dotfiles/xkcd-password.sh $@"

export EDITOR=vim
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/npm/bin:$HOME/bin:$HOME/.bin

if [ -f ~/.zsh_more ]; then
    . ~/.zsh_more
fi

if [ ! -z "$ZSH_IGNORE_WELCOME" ]; then
  if [ -f ~/.dotfiles/welcome ]; then
    . ~/.dotfiles/welcome
  else
    printf "You have not set up the screen selector yet...\n"
  fi
fi

