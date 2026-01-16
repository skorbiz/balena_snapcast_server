#!/bin/bash

echo "=== Generating 440Hz test tone ==="
echo "Duration: 5 seconds"
echo "If you hear a beep, your speaker is working!"
echo ""

# Generate a 440Hz sine wave directly to PulseAudio
paplay <(sox -n -t wav - synth 5 sine 440 2>/dev/null) || \
  speaker-test -t sine -f 440 -c 2 -l 1 & sleep 5 && killall speaker-test 2>/dev/null

echo ""
echo "Test complete!"
