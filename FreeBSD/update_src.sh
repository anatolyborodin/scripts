#!/bin/sh

cd /usr/src &&
	git fetch -v --all &&
	git checkout -f local &&
	git clean -d -x &&
	git pull -v &&
	git push -v -f origin local:local
