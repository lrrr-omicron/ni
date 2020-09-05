#!/usr/bin/env bash

MYDIRNAME=$(dirname "$0")
NEE_CMD="${MYDIRNAME}/ni-cmd"
exec "${NEE_CMD}" nee "$@"
