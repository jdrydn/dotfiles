#!/usr/bin/env bash
# Init the dotfiles
set -euo pipefail

printf '\033[1m%s\033[0m\n' "jdrydn/dotfiles (https://github.com/jdrydn/dotfiles)"

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DOTFILES_DIR/init/00-functions.sh"
printf "\n"
source "$DOTFILES_DIR/init/00-prerequisites.sh"
printf "\n"
source "$DOTFILES_DIR/init/01-packages.sh"
printf "\n"
source "$DOTFILES_DIR/init/02-ohmyzsh.sh"
printf "\n"
source "$DOTFILES_DIR/init/03-setup.sh"
