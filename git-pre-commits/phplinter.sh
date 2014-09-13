#!/bin/bash
# A simple script to validate PHP files.
EXIT=0
for FILE in `git diff-index --cached --name-only $against`; do
	if [[ "$FILE" =~ .php$ ]] && [[ -e $FILE ]]; then
		php -l $FILE
		RETURN=$?
		if [[ $RETURN -ne 0 ]]; then
			EXIT=1
		fi
	fi
done
if [[ $EXIT -eq 1 ]]; then
	exit 1
fi
