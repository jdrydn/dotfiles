# 01: Configure Oh-My-ZSH
# @link: https://github.com/ohmyzsh/ohmyzsh

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(emoji encode64 git httpie npm macos)

source $ZSH/oh-my-zsh.sh
