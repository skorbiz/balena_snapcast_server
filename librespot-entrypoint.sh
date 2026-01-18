#!/bin/sh
set -eu

# Check if server is enabled
if [ "${ENABLE_SERVER:-off}" != "on" ]; then
  echo "Librespot disabled (ENABLE_SERVER=$ENABLE_SERVER)"
  echo "Set ENABLE_SERVER=on to enable"
  exit 0
fi

# Generate config with device name
mkdir -p /config
DEVICE_NAME="${SPOTIFY_DEVICE_NAME:-snapcast-spotify}"
sed "s|__DEVICE_NAME__|${DEVICE_NAME}|g" /defaults/librespot-config.yml > /config/config.yml

exec "$@"
