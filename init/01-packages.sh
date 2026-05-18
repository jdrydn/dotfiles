# 01: Installing package managers & packages

# @link: https://github.com/Homebrew/brew
if command -v brew >/dev/null 2>&1; then
  log_msg "GOOD" "Homebrew is installed"
else
  HOMEBREW_PKG_URL="https://github.com/Homebrew/brew/releases/latest/download/Homebrew.pkg"
  log_msg "INFO" "Downloading Homebrew (via pkg from $HOMEBREW_PKG_URL)"
  HOMEBREW_PKG_PATH="$HOME/Downloads/Homebrew.pkg"
  curl -fsSL -o "$HOMEBREW_PKG_PATH" "$HOMEBREW_PKG_URL"

  # For managed devices that require seperate admin credentials, this is the only way
  log_msg "INFO" "Launching macOS Installer — enter your admin credentials when prompted"
  open -W "$HOMEBREW_PKG_PATH"

  if command -v brew >/dev/null 2>&1; then
    log_msg "GOOD" "Homebrew installed"
    rm -f "$HOMEBREW_PKG_PATH"
    unset HOMEBREW_PKG_PATH
  else
    throw_err "1" "Homebrew pkg installer did not complete"
  fi

  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"

# Update Homebrew
log_msg "INFO" "Updating Homebrew"
brew update

# Install packages from brewfile
log_msg "INFO" "Installing Homebrew packages from brewfile"
brew bundle --file="$DOTFILES_DIR/config/brewfile"

unset HOMEBREW_CASK_OPTS

log_msg "GOOD" "Homebrew installed & configured"
