#!/bin/sh

cd /usr/src &&
	git fetch -v --all &&
	git reset --hard &&
	git clean -d -x &&
	git pull -v &&
	git push -v origin +local:local
