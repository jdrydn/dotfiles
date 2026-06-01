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

if [[ "$DOTFILES_PROFILE" == "personal" ]]; then
  printf "\n✻ Claude\n"

  # CLAUDE files
  mkdir -p "$HOME/.claude"
  symlink_file "$DOTFILES_DIR/config/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
  symlink_file "$DOTFILES_DIR/config/claude/settings.json" "$HOME/.claude/settings.json"
  symlink_file "$DOTFILES_DIR/config/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
  # symlink_dir  "$DOTFILES_DIR/config/claude/agents" "$HOME/.claude/agents"
  symlink_dir  "$DOTFILES_DIR/config/claude/skills" "$HOME/.claude/skills"
else
  log_msg "INFO" "Skipping Claude config (profile: $DOTFILES_PROFILE)"
fi

unset GITCONFIG_PATH
unset ZSHRC_PATH
