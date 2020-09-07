#!/usr/bin/env bash

MYDIRNAME=$(dirname "$0")
NEE_CMD="${MYDIRNAME}/ni-cmd"

# don't use these again.
rm -f "${HOME}/.ni/LAST_VIEWER_PID"
rm -f "${HOME}/.ni/LAST_NI"

exec "${NEE_CMD}" nee "$@"
