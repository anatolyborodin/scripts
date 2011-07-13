#!/bin/sh

cd /usr/ports &&
	git fetch -v --all &&
	git checkout -f local &&
	git clean -d -x &&
	git pull -v &&
	ports_subdir_rebuild.sh &&
	(git commit -a -m "*** Fix the Makefiles. ***" || true) &&
	git clean -d -x &&
	git push -v -f origin local:local &&
	make index &&
	portold.sh
