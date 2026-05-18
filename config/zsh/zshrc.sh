DOTFILES_ZSH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DOTFILES_ZSH_DIR: $DOTFILES_ZSH_DIR"

source $DOTFILES_ZSH_DIR/01-ohmyzsh.sh
source $DOTFILES_ZSH_DIR/02-exports.sh
source $DOTFILES_ZSH_DIR/03-packages.sh
