# dotfiles

My dotfiles. No longer scattered!

---

## Installation

```bash
$ git clone github.com:jdrydn/dotfiles .dotfiles
$ cd .dotfiles && ./install.sh
```

This will take every single file starting with a `.` (except `.gitignore`) and create a symlink matching it to your home directory.

	.vimrc -> .dotfiles/.vimrc
	.zshrc -> .dotfiles/.zshrc

And so on.

---

## Git Pre-Commit Hooks

Check out [Git Pre-Commit Hooks README](./git-pre-commits/README.md) for more details, but basically this folder contains a selection of pre-commit hooks for validating work before it's committed.

This has been especially useful to me as I move towards online development using various terminals such as [Secure Shell](https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo?hl=en) & [iTerm](http://iterm2.com).

