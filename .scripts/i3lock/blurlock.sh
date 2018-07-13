#!/bin/sh

SCRIPT_PATH="$(dirname $(realpath $0))"
OVERLAY_PATH="$SCRIPT_PATH/overlays"
IMG_OUT=/tmp/i3lock.png

RESOLUTION=$(xrandr --current | grep '*' | head -n 1 | awk '{print $1}')
OVERLAY_IMG=$(find $OVERLAY_PATH -type f | rev | cut -d'/' -f1 | rev | shuf | shuf -n 1)

ffmpeg -f x11grab \
	-video_size $RESOLUTION \
	-y \
	-i $DISPLAY \
	-i "$OVERLAY_PATH/$OVERLAY_IMG" \
	-filter_complex "boxblur=15,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
	-vframes 1 \
  $IMG_OUT

i3lock -i $IMG_OUT
\rm -f $IMG_OUT
