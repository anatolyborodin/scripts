#!/bin/sh

cd /usr/src &&
	make USER=anatoly.borodin HOSTNAME=gmail.com installkernel installworld &&
	(yes | make delete-old delete-old-libs delete-old-dirs) &&
	mergemaster -i -p &&
	mergemaster -i &&
	make USER=anatoly.borodin HOSTNAME=gmail.com installkernel installworld

rm -rf /boot/*.old
