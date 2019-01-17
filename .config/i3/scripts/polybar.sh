#!/usr/bin/env bash

POLYBAR_CONFIG="night"

# kill remaining polybars (if any)
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do
  sleep 1
done

# detect screens and launch polybar for each one
if [[ -x "$(command -v xrandr)" ]]; then
  for mon in $(xrandr --query | grep ' connected' | cut -d' ' -f1); do
    MONITOR=$mon polybar -q --reload $POLYBAR_CONFIG &
  done
else
  # fallback, if xrandr is not found
  polybar -q --reload $POLYBAR_CONFIG &
fi

