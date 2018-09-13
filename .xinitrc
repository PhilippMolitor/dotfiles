#!/bin/sh

# reset autocompletion cache for binaries
rehash

# load fonts
xset +fp ~/.local/share/fonts
xset fp rehash

# keyboard layout: german
setxkbmap de
localectl set-x11-keymap de

# WM
i3 &

