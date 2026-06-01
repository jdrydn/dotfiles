# 00: Prerequisites
# A small series of checks to ensure the system is ready

# Confirm HOME is set and its directory exists
[[ -n "${HOME:-}" ]]
throw_err "$?" "HOME is required but was not set"
[[ -d "$HOME" ]]
throw_err "$?" "HOME directory does not exist: $HOME"
log_msg "GOOD" "HOME: $HOME"

# Confirm DOTFILES_DIR exists
[[ -n "$DOTFILES_DIR" ]]
throw_err "$?" "DOTFILES_DIR is required but was not set"
log_msg "GOOD" "DOTFILES_DIR: $DOTFILES_DIR"

# Confirm curl is present
command -v curl >/dev/null 2>&1
throw_err "$?" "curl is required but not installed"
log_msg "GOOD" "curl: installed"

# Confirm git is present
if command -v git >/dev/null 2>&1; then
  log_msg "GOOD" "git: installed"
else
  printf "git is not installed. Install, then re-run this script\n"
  printf "  macOS:  xcode-select --install\n"
  printf "  Ubuntu: sudo apt-get install -y git\n"
  printf "  AL2023: sudo dnf install -y git\n"
  throw_err "1" "Exited"
fi

# Ensure ~/Applications exists
if [[ -d "$HOME/Applications" ]]; then
  log_msg "GOOD" "$HOME/Applications: exists"
else
  mkdir -p "$HOME/Applications"
  throw_err "$?" "Failed to create $HOME/Applications"
  log_msg "GOOD" "$HOME/Applications: created"
fi
# Ensure ~/Downloads exists
if [[ -d "$HOME/Downloads" ]]; then
  log_msg "GOOD" "$HOME/Downloads: exists"
else
  mkdir -p "$HOME/Downloads"
  throw_err "$?" "Failed to create $HOME/Downloads"
  log_msg "GOOD" "$HOME/Downloads: created"
fi

# Confirm we are ready to `git pull` from GitHub
GITHUB_SSH_TEST=$(ssh -T git@github.com 2>&1 || true)
if [[ "$GITHUB_SSH_TEST" == *"You've successfully authenticated"* ]]; then
  log_msg "GOOD" "github: Successfully authenticated with SSH"
  unset GITHUB_SSH_TEST
else
  throw_err "1" "GitHub SSH authentication failed. Set up & add an SSH key, add to GitHub, then re-run"
fi

# Determine machine profile (personal or work) — persisted per-machine to $DOTFILES_DIR/.profile
PROFILE_FILE="$DOTFILES_DIR/.profile"
if [[ -f "$PROFILE_FILE" ]]; then
  DOTFILES_PROFILE="$(tr -d '[:space:]' < "$PROFILE_FILE")"
  log_msg "GOOD" "profile: $DOTFILES_PROFILE (from $PROFILE_FILE)"
else
  while :; do
    answer="$(prompt_one 'Machine profile? (p)ersonal / (w)ork')"
    case "$answer" in
      p|P) DOTFILES_PROFILE="personal"; break ;;
      w|W) DOTFILES_PROFILE="work"; break ;;
      *)   log_msg "WARN" "Please enter 'p' or 'w'" ;;
    esac
  done
  printf "%s\n" "$DOTFILES_PROFILE" > "$PROFILE_FILE"
  log_msg "GOOD" "profile: $DOTFILES_PROFILE (saved to $PROFILE_FILE)"
fi
export DOTFILES_PROFILE
unset PROFILE_FILE
