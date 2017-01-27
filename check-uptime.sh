#!/bin/bash
while true; do
	echo ""
	http GET "$1" --follow --all --max-redirects=5 --print=Hh
	echo "----"
	sleep 5
done
