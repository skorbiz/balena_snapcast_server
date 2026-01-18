#!/bin/bash
# Audio test script - plays continuous tone with sync clap and diagnostics
#
# Environment variables:
#   AUDIO_TEST=off|on  - Enable/disable test (default: off)
#   TONE_FREQ=440      - Tone frequency in Hz (default: 440)
#   CLAP_INTERVAL=10   - Seconds between sync claps (default: 10)

set -eu

AUDIO_TEST="${AUDIO_TEST:-off}"
TONE_FREQ="${TONE_FREQ:-440}"
CLAP_INTERVAL="${CLAP_INTERVAL:-10}"

if [ "$AUDIO_TEST" != "on" ]; then
  echo "Audio test disabled (AUDIO_TEST=$AUDIO_TEST)"
  echo "Set AUDIO_TEST=on to enable"
  exit 0
fi

play_clap() {
  sox -n -t wav - synth 0.05 noise vol 0.8 2>/dev/null | paplay --raw --rate=44100 --channels=1 2>/dev/null || \
    speaker-test -t pink -l 1 -c 2 -s 1 & sleep 0.1 && kill $! 2>/dev/null
}

play_tone() {
  duration="$1"
  sox -n -t wav - synth "$duration" sine "$TONE_FREQ" 2>/dev/null | paplay 2>/dev/null || \
    speaker-test -t sine -f "$TONE_FREQ" -c 2 -l 1 & sleep "$duration" && kill $! 2>/dev/null
}

print_diagnostics() {
  echo "══════════════════════════════════════════════════════════"
  echo "  Audio Diagnostics - $(date '+%Y-%m-%d %H:%M:%S')"
  echo "══════════════════════════════════════════════════════════"
  echo ""
  echo "▶ PulseAudio: $(pactl info 2>/dev/null | grep 'Default Sink' | cut -d: -f2 || echo 'N/A')"
  echo "▶ Volume: $(pactl list sinks 2>/dev/null | grep -A5 'State: RUNNING\|State: IDLE' | grep 'Volume:' | head -1 | sed 's/.*front-left: [0-9]* \/ *\([0-9]*%\).*/\1/' || echo 'N/A')"
  echo "▶ Streams: $(pactl list sink-inputs short 2>/dev/null | wc -l || echo '0')"
  echo "══════════════════════════════════════════════════════════"
}

echo "=== Audio Test ==="
echo "Frequency: ${TONE_FREQ}Hz | Clap every ${CLAP_INTERVAL}s"
echo ""

while true; do
  print_diagnostics
  echo ""
  echo ">>> CLAP <<<"
  play_clap
  play_tone "$CLAP_INTERVAL"
done
