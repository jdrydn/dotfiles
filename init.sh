#!/usr/bin/env bash
# Init the dotfiles
set -euo pipefail

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

run_file() {
  printf "\n"
  source "$1"
}

printf '\033[1m%s\033[0m\n' "jdrydn/dotfiles (https://github.com/jdrydn/dotfiles)"

run_file "$DOTFILES_DIR/init/00-functions.sh"
run_file "$DOTFILES_DIR/init/00-prerequisites.sh"
run_file "$DOTFILES_DIR/init/01-packages.sh"
run_file "$DOTFILES_DIR/init/02-ohmyzsh.sh"
run_file "$DOTFILES_DIR/init/03-setup.sh"
