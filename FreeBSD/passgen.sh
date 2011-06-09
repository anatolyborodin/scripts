#!/bin/sh

COUNT=10
LENGTHS="8 10 12"

for l in ${LENGTHS}; do
	echo "${l} character(s)"
	apg -M SNCL -n ${COUNT} -m ${l} -x ${l}
	echo
done
