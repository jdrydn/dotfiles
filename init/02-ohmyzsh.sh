# 02: Install Oh-My-ZSH
# @link: https://github.com/ohmyzsh/ohmyzsh

INIT_01_OHMYZSH_DIR="$HOME/.oh-my-zsh"

if [ -d "$INIT_01_OHMYZSH_DIR" ]; then
  log_msg "GOOD" "Oh-my-ZSH is already installed"
else
  echo "Installing OH MY ZSH"
  log_msg "INFO" "Cloning: ohmyzsh/ohmyzsh → ~/.oh-my-zsh"
  git clone git@github.com:ohmyzsh/ohmyzsh "$INIT_01_OHMYZSH_DIR"
  throw_err "$?" "Failed to clone ohmyzsh/ohmyzsh"
fi
