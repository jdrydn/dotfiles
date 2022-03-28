#!/bin/bash
# A simple file to install the dotfiles to the home directory.

if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing OH MY ZSH"
	git clone github.com:robbyrussell/oh-my-zsh ~/.oh-my-zsh
fi

for FILE in `find .* -maxdepth 0 ! -type d | grep -v ".gitignore"`; do
	echo $FILE
	rm -rf ~/$FILE
	ln -s `pwd`"/"$FILE ~/$FILE
done

echo "Dotfiles successfully placed!"
