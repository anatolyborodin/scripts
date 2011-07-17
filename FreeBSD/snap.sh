#!/bin/sh

TIMESTAMP="`date -u +%Y_%m_%d_%H_%M_%S`"

mksnap_ffs "/.snap/${TIMESTAMP}"
