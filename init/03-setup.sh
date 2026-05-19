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
  git config --file "$GITCONFIG_PATH" include.path "$DOTFILES_DIR/config/git/config"

  unset GIT_USER_NAME GIT_USER_EMAIL
  log_msg "GOOD" "$GITCONFIG_PATH: created"
fi

ZSHRC_PATH="$HOME/.zshrc"

# zshrc
if [[ -f "$ZSHRC_PATH" ]]; then
  log_msg "GOOD" "zshrc exists: $ZSHRC_PATH"
else
  create_file "$ZSHRC_PATH" "$(cat <<EOF
# Shared configuration
source $DOTFILES_DIR/config/zsh/config.zsh
EOF
)"
fi

# vimrc
symlink_file "$DOTFILES_DIR/config/vimrc" "$HOME/.vimrc"

unset GITCONFIG_PATH
unset ZSHRC_PATH
