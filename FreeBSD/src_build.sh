#!/bin/sh

cd /usr/src &&
	make clean &&
	make USER=anatoly.borodin HOSTNAME=gmail.com buildkernel buildworld
