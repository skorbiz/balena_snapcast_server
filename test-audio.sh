#!/bin/bash

echo "=== Audio Device Test Script ==="
echo ""

echo "1. Checking PulseAudio status..."
pactl info | grep -E "Server Name|Server Version|Default Sink"
echo ""

echo "2. Listing available sinks..."
pactl list sinks short
echo ""

echo "3. Checking volume levels..."
pactl list sinks | grep -E "Name:|Volume:|Mute:"
echo ""

echo "4. Setting volume to 80%..."
pactl set-sink-volume @DEFAULT_SINK@ 80%
pactl set-sink-mute @DEFAULT_SINK@ 0
echo "Volume set and unmuted"
echo ""

echo "5. Playing test tone (440Hz for 3 seconds)..."
pactl play-sample /usr/share/sounds/alsa/Front_Center.wav 2>/dev/null || \
  speaker-test -t sine -f 440 -l 1 -c 2 -s 1 &
SPEAKER_PID=$!
sleep 3
kill $SPEAKER_PID 2>/dev/null
echo "Test tone completed"
echo ""

echo "6. Checking if there are any streams playing..."
pactl list sink-inputs short
echo ""

echo "=== Test Complete ==="
echo "If you heard a tone, audio is working!"
echo "If not, check:"
echo "  - Speaker connection"
echo "  - Volume levels above"
echo "  - ALSA mixer settings (run 'alsamixer')"
