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
if HOMEBREW_NVM_PREFIX=$(brew --prefix nvm 2>/dev/null); then
  export NVM_DIR="$HOME/.nvm"
  # This loads nvm
  [ -s "$HOMEBREW_NVM_PREFIX/nvm.sh" ] && \. "$HOMEBREW_NVM_PREFIX/nvm.sh"
  # This loads nvm bash_completion
  [ -s "$HOMEBREW_NVM_PREFIX/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_NVM_PREFIX/etc/bash_completion.d/nvm"
fi

# chruby
if HOMEBREW_CHRUBY_PREFIX=$(brew --prefix chruby 2>/dev/null); then
  source $HOMEBREW_CHRUBY_PREFIX/share/chruby/chruby.sh
  source $HOMEBREW_CHRUBY_PREFIX/share/chruby/auto.sh
  chruby ruby-3.4.1
fi

# cargo
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
