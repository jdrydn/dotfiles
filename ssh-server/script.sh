#!/bin/bash
BASE_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR=$(pwd)
pushd "$BASE_PATH" > /dev/null

php script.php $DIR $1
CODE=$?
if [ $CODE -eq 0 ]; then
	CMD=$(RETURN_CMD=TRUE php script.php $DIR $1)
	popd > /dev/null
	# exec $CMD
	echo $CMD
	pushd "$BASE_PATH" > /dev/null
fi
if [ $CODE -eq 1 ]; then
	CODE=0
fi

popd > /dev/null
exit $CODE
