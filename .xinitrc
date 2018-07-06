#!/bin/sh

# reset autocompletion cache for binaries
rehash

# load fonts
xset +fp ~/.fonts/pcf
xset +fp ~/.fonts/bdf
xset fp rehash

# keyboard layout: german
setxkbmap de
localectl set-x11-keymap de

# WM
i3 &
# Fallback if no login manager
termite

