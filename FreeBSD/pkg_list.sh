#!/bin/sh

fgrep -h '@comment ORIGIN:' /var/db/pkg/*/+CONTENTS | sed -e 's/@comment ORIGIN://' | sort -u
