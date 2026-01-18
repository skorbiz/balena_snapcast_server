#!/bin/sh
set -eu

# Check if server is enabled
if [ "${ENABLE_SERVER:-off}" != "on" ]; then
  echo "Snapserver disabled (ENABLE_SERVER=$ENABLE_SERVER)"
  echo "Set ENABLE_SERVER=on to enable"
  exit 0
fi

PIPE_DIR=/run/snapserver
PIPE_PATH="${PIPE_DIR}/spotify"

mkdir -p "$PIPE_DIR"

if [ -e "$PIPE_PATH" ] && [ ! -p "$PIPE_PATH" ]; then
  echo "snapserver: $PIPE_PATH exists and is not a fifo" >&2
  exit 1
fi

if [ ! -p "$PIPE_PATH" ]; then
  mkfifo -m 666 "$PIPE_PATH"
fi

exec "$@"
