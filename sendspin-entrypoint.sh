#!/bin/sh
set -eu

# Check if sendspin is enabled
if [ "${ENABLE_SENDSPIN:-off}" != "on" ]; then
  echo "SendSpin disabled (ENABLE_SENDSPIN=$ENABLE_SENDSPIN)"
  echo "Set ENABLE_SENDSPIN=on to enable"
  exit 0
fi

exec sendspin
