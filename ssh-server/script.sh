#!/bin/bash
BASE_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

php $BASE_PATH/script.php $(pwd)
CODE=$?
if [ $CODE -ne 0 ]; then
	CMD=$(php $BASE_PATH/script.php $(pwd) $CODE)
	exec $CMD
	exit $?
fi
exit 1