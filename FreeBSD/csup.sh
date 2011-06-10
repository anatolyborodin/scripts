#!/bin/sh

case "$1" in
src | ports)
	PART=$1
	;;
*)
	echo "Usage: `basename $0` [src | ports]"
	exit 1
	;;
esac

REPO=${HOME}/FreeBSD/${PART}
BASE=${HOME}/csup
SUPFILE=${BASE}/${PART}
LOCK=/tmp/csup-${PART}.lock
MAXRETRIES=10
SERVER_COUNTRY='de'

if [ -f ${LOCK} ]; then
	echo "Error: ${LOCK} found."
	exit 1
fi
touch ${LOCK}

SERVER=`fastest_cvsup -Q -c ${SERVER_COUNTRY}`

(cd ${REPO} &&
# TODO: add workaround for initially empty repositories
git reset --hard HEAD &&
git clean -f -d -x -q &&
DATE=`env LANG=C date` &&
csup -b ${BASE} -h ${SERVER} -L 0 -r ${MAXRETRIES} -z ${SUPFILE} &&
git add -f . &&
git commit -a -m "Autoupdated: ${DATE}." -m "server=${SERVER}" &&
STATUS=0) || STATUS=1

rm -f ${LOCK}
exit ${STATUS}
