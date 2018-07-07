#!/usr/bin/env sh

# Lock after # minutes
LOCKTIME=5

# get dpms status
DPMS=$(xset q | grep "DPMS is Disabled")

# if argument #1 given exit with status info
if [ ! -z "$1" ]; then
  if [ "$DPMS" == "" ]; then
    echo "caffeine: disabled"
  else
    echo "caffeine: active"
  fi

  exit 0
fi

if [ "$DPMS" == "" ]; then
    # dpms enabed, turn it off
    xset s 0 0
    xset s noblank
    xset -dpms
    # send notification
    notify-send -u low \
	    -a "Caffeine" \
	    -i "Caffeine mode: on" \
	    "Caffeine mode has been enabled. The display will not go blank until you disable it."
else
    # dpms disabled, turn it on
    xset s $(($LOCKTIME*60))
    xset +dpms
    notify-send -u low \
	    -a "Caffeine" \
	    -i "Caffeine mode: off" \
	    "Caffeine has been disabled. You display will automatically lock after $LOCKTIME minutes."
fi
