# 09: Setup home files

# gitconfig
GITCONFIG_PATH="$HOME/.gitconfig"

if [[ -f "$GITCONFIG_PATH" ]]; then
  log_msg "GOOD" "gitconfig exists: $GITCONFIG_PATH"
else
  log_msg "INFO" "Creating missing gitconfig: $GITCONFIG_PATH"

  prompt_sentence "gitconfig: user.name" GIT_USER_NAME
  prompt_sentence "gitconfig: user.email" GIT_USER_EMAIL

  git config --file "$GITCONFIG_PATH" user.name "$GIT_USER_NAME"
  git config --file "$GITCONFIG_PATH" user.email "$GIT_USER_EMAIL"
  git config --file "$GITCONFIG_PATH" include.path "$DOTFILES_DIR/config/gitconfig"

  unset GIT_USER_NAME GIT_USER_EMAIL
  log_msg "GOOD" "$GITCONFIG_PATH: created"
fi

unset GITCONFIG_PATH

# zshrc
create_file "$HOME/.zshrc" "$(cat <<EOF
source $DOTFILES_DIR/config/zsh/01-ohmyzsh.sh
source $DOTFILES_DIR/config/zsh/02-exports.sh
source $DOTFILES_DIR/config/zsh/03-packages.sh
EOF
)"

# vimrc
symlink_file "$DOTFILES_DIR/config/vimrc" "$HOME/.vimrc"
