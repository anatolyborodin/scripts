#!/bin/sh

DATE=`env LANG=C date -u` # the date for logs

LISTS_DIR=/var/db
LOG_DIR=/var/log
ALL_NAME=bt.list.all
LAST_NAME=bt.list.last
LOG_NAME=bt.list.log

ALL_LIST=${LISTS_DIR}/${ALL_NAME}
LAST_LIST=${LISTS_DIR}/${LAST_NAME}
LOG=${LOG_DIR}/${LOG_NAME}

# Use precreated temp files
ALL_TMP=`mktemp -t "${ALL_NAME}"`
LAST_TMP=`mktemp -t "${LAST_NAME}"`
LOG_TMP=`mktemp -t "${LOG_NAME}"`

touch "${ALL_LIST}" # may be empty during the first run
cat "${ALL_LIST}" > "${ALL_TMP}"

# Get the addresses of the visible devices
addr=`hccontrol -N inquiry | \
	fgrep 'BD_ADDR: ' | \
	sed 's|^[[:space:]]*BD_ADDR:[[:space:]]*\(.*\)$|\1|g' | \
	sort -u`

for x in ${addr}; do
	# Get the name of the device, produce an 'address="name"' string
	hccontrol -N Remote_Name_Request ${x} | \
		grep '^\(BD_ADDR\|Name\): ' | \
		paste -s - | \
		sed 's|^BD_ADDR:[[:space:]]*\([^[:space:]]*\)[[:space:]]*Name:[[:space:]]*\(.*\)$|\1="\2"|g' \
		>> "${LAST_TMP}";
done

# Update the lists
sort -u -o "${LAST_LIST}" "${LAST_TMP}"
sort -u -o "${ALL_LIST}" "${LAST_TMP}" "${ALL_TMP}"

# Detect the new discovered or renamed devices and log them
grep -v -F -x -f "${ALL_TMP}" "${LAST_TMP}" > "${LOG_TMP}"
if [ -s "${LOG_TMP}" ] ; then
	echo "# ${DATE}" >> "${LOG}"
	cat "${LOG_TMP}" >> "${LOG}"
fi

# Clean up
rm -f "${ALL_TMP}" "${LAST_TMP}" "${LOG_TMP}"
