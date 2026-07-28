# 09: Setup home files

ZSHRC_PATH="$HOME/.zshrc"

# zshrc
if [[ -f "$ZSHRC_PATH" ]]; then
  log_msg "GOOD" "zshrc exists: $ZSHRC_PATH"
else
  create_file "$ZSHRC_PATH" "$(cat <<EOF
# Shared configuration
source $DOTFILES_DIR/config/zsh/config.zsh
# Place unique configuration below this point ⬇⬇⬇

EOF
)"
fi

# gitconfig
symlink_file "$DOTFILES_DIR/config/git/gitconfig" "$HOME/.gitconfig"
# vimrc
symlink_file "$DOTFILES_DIR/config/vimrc" "$HOME/.vimrc"
# mise
symlink_file "$DOTFILES_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"
# mise (local, optional)
if [[ -f "$DOTFILES_DIR/config/mise/config.local.toml" ]]; then
  symlink_file "$DOTFILES_DIR/config/mise/config.local.toml" "$HOME/.config/mise/config.local.toml"
fi

unset GITCONFIG_PATH
unset ZSHRC_PATH
