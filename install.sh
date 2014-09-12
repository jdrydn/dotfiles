#!/bin/bash
# A simple file to install the dotfiles to the home directory.

for FILE in `find .* -maxdepth 0 ! -type d | grep -v ".gitignore"`; do
	echo $FILE
	rm -rf ~/$FILE
	ln -s `pwd`"/"$FILE ~/$FILE
done

echo "Dotfiles successfully placed!"
