# 02: Exports

export EDITOR="vim"

PATH_ENTRIES=(
  # Homebrew
  "/opt/homebrew/bin"
  "/usr/local/bin"

  # Local binaries
  "$HOME/.local/bin"

  # Regular PATH
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"

  # Dotfiles
  "${0:A:h:h:h}/bin"
)

PATH=""
for entry in "${PATH_ENTRIES[@]}"; do
  [[ -d "$entry" && ":$PATH:" != *":$entry:"* ]] && PATH="${PATH:+$PATH:}$entry"
done
export PATH
unset PATH_ENTRIES

echo $PATH
