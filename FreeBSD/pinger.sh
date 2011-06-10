#!/bin/sh

if [ "$1" = "" ]; then
	echo "Usage: `basename $0` host"
	exit 1
fi

COUNT=100
HOST=$1
DATE=`env LANG=C date`
LOSS=`env LANG=C ping -q -c ${COUNT} ${HOST} 2>&1 | fgrep 'packet loss' | sed 's|.* \(.*\)% packet loss.*|\1|'`

if [ "${LOSS}" != "" ]; then
	echo "${DATE} : ${LOSS} packet loss (${HOST})."
fi
