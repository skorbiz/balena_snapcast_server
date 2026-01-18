#!/bin/sh
set -eu

# "snapserver" is the Docker Compose service name, which Docker's internal DNS
# resolves to the snapserver container's IP address automatically.

HOST="${SNAPSERVER_HOST:-snapserver}"
HOST_ID="${SNAPCLIENT_ID:-}"

if [ -n "$HOST_ID" ]; then
  exec /usr/bin/snapclient -h "$HOST" --hostID "$HOST_ID" "$@"
else
  exec /usr/bin/snapclient -h "$HOST" "$@"
fi
