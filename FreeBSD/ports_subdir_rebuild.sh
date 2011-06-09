#!/bin/sh

PORTSDIR=/usr/ports
DIRS=`fgrep SUBDIR ${PORTSDIR}/Makefile | sed -E 's|.*=||g' | sort -u`
MAKEFILE_TMP=`mktemp -t Makefile.tmp`

for DIR in ${DIRS}; do
	echo -n "Processing ${PORTSDIR}/${DIR}..."
	cd ${PORTSDIR}/${DIR}
	(fgrep '#' ./Makefile
	echo
	fgrep -w 'COMMENT' ./Makefile
	echo
	find -s . -depth 1 -type d | sed -E 's|./|    SUBDIR += |g'
	echo
	echo '.include <bsd.port.subdir.mk>') > ${MAKEFILE_TMP}
	mv -f Makefile Makefile.bak
	cat ${MAKEFILE_TMP} > ./Makefile
	echo ' done.'
done
