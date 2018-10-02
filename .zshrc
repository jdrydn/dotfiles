# Simply put, this is my ZSHRC file for use with ZSH
# It relies on OH-MY-ZSH since their theme support is just amazing
# Also allows a .zsh_more file to be present on each machine, for machine-specific items
# And if you wish to disable the screen-selector, you can do that from your .zsh_more too
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(atom emoji encode64 git httpie npm osx screen vagrant web-search)

source $ZSH/oh-my-zsh.sh
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

#alias ll="ls -lF --group-directories-first"
#alias sshserver="sh ~/.dotfiles/ssh-server/script.sh"
alias check-uptime="~/.dotfiles/check-uptime.sh"
alias xkcd-password="~/.dotfiles/xkcd-password/cli.sh $@"

export EDITOR=vim

if [ -f ~/.zsh_more ]; then
  source ~/.zsh_more
fi

