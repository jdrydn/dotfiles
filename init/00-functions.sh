# 00: Functions
# A small collection of shared functions to make these scripts easier to read

throw_err() {
  if [ "$1" -ne "0" ]; then
    log_msg "FAIL" "$2"
    exit "$1"
  fi
}

# Log a message with a level prefix
# Usage: log_msg "INFO" "Starting setup"
log_msg() {
  local color="" reset=""
  if [ -t 1 ]; then
    case "$1" in
      GOOD) color=$'\033[32m' ;;  # green
      INFO) color=$'\033[36m' ;;  # cyan
      WARN) color=$'\033[33m' ;;  # yellow
      FAIL) color=$'\033[31m' ;;  # red
    esac
    reset=$'\033[0m'
  fi
  case "$1" in
    WARN|FAIL) printf "%s[%s]:%s %s\n" "$color" "$1" "$reset" "$2" 1>&2 ;;
    *)         printf "%s[%s]:%s %s\n" "$color" "$1" "$reset" "$2" ;;
  esac
}

# Usage: [[ "$(prompt_one 'Continue? (y/n)')" == "y" ]]
prompt_one() {
  local result
  read -r -p "[USER]: $1 " -n 1 result </dev/tty
  printf "\n" >&2
  printf "%s" "$result"
}

# Usage: prompt_sentence "What's your name?" name
prompt_sentence() {
  read -r -p "[USER]: $1 " "$2" </dev/tty
}

# Copy SRC -> DEST, backing up any existing different file at DEST
# Usage: copy_file "$DOTFILES_DIR/file" "$HOME/.file"
copy_file() {
  local src="$1" dest="$2"

  if [[ ! -f "$src" ]]; then
    throw_err "1" "copy_file: source does not exist: $src"
  fi

  if [[ -f "$dest" && ! -L "$dest" ]] && cmp -s "$src" "$dest"; then
    log_msg "GOOD" "$dest: already matches $src"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "$dest.bak"
    log_msg "WARN" "$dest: existing file backed up to $dest.bak"
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  log_msg "GOOD" "$dest: copied ← $src"
}

# Write CONTENT to DEST, backing up any existing different file at DEST
# Usage: create_file "$HOME/.foo" "$(cat <<'EOF'
# line one
# line two
# EOF
# )"
create_file() {
  local dest="$1" content="$2"

  if [[ -f "$dest" && ! -L "$dest" ]] && cmp -s <(printf "%s\n" "$content") "$dest"; then
    log_msg "GOOD" "$dest: already matches content"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "$dest.bak"
    log_msg "WARN" "$dest: existing file backed up to $dest.bak"
  fi

  mkdir -p "$(dirname "$dest")"
  printf "%s\n" "$content" > "$dest"
  log_msg "GOOD" "$dest: created"
}

# Symlink SRC -> DEST, backing up any existing real file/dir at DEST
# Usage: symlink_file "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
symlink_file() {
  local src="$1" dest="$2"

  if [[ ! -e "$src" ]]; then
    throw_err "1" "symlink_file: source does not exist: $src"
  fi

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    log_msg "GOOD" "$dest: already linked → $src"
    return
  fi

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mv "$dest" "$dest.bak"
    log_msg "WARN" "$dest: existing file backed up to $dest.bak"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  log_msg "GOOD" "$dest: linked → $src"
}
