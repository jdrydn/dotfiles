#!/bin/bash
# A script to generate a phrase from a random set of words
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if (( $# < 1 )); then
  nwords=4
else
	nwords=$1
fi

declare -a array
let index=0

while read line; do
  array[$index]=$line
  let index=$index+1
done < "$DIR/words.txt"

RANDOM=$$$(date +%s)
let "lastword = $nwords - 1"

for (( i=0 ; i<$nwords ; i++ )); do
  let number=$RANDOM
  let "number %= $index"

  echo -n ${array[$number]}
  if (( $i != $lastword )); then
    echo -n "-"
  fi
done
echo
