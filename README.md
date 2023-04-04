# dotfiles

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
