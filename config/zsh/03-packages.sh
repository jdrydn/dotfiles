# 03: Additional packages

# brew
if hash brew 2>/dev/null; then
  eval "$(brew shellenv)"
fi

# direnv
if hash direnv 2>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# thefuck
if hash thefuck 2>/dev/null; then
  eval "$(thefuck --alias)"
fi

# nvm
HOMEBREW_NVM_PREFIX="$(brew --prefix nvm 2>/dev/null)"
if [ -s "$HOMEBREW_NVM_PREFIX/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  \. "$HOMEBREW_NVM_PREFIX/nvm.sh" --no-use
  [ -s "$HOMEBREW_NVM_PREFIX/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_NVM_PREFIX/etc/bash_completion.d/nvm"
fi
unset HOMEBREW_NVM_PREFIX

# chruby
HOMEBREW_CHRUBY_PREFIX="$(brew --prefix chruby 2>/dev/null)"
if [ -s "$HOMEBREW_CHRUBY_PREFIX/share/chruby/chruby.sh" ]; then
  source "$HOMEBREW_CHRUBY_PREFIX/share/chruby/chruby.sh"
  source "$HOMEBREW_CHRUBY_PREFIX/share/chruby/auto.sh"
  chruby ruby-3.4.1
fi
unset HOMEBREW_CHRUBY_PREFIX

# cargo
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
