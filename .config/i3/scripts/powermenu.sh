#!/usr/bin/env bash

DMENU_BIN="rofi -dmenu -no-sort"

declare -A MENU
MENU=(
  ["Abort"]="exit 0"
  ["Lock"]="dm-tool lock"
  ["Shutdown"]="poweroff"
  ["Reboot"]="reboot"
)


show_menu() {
  local dmenu_string=""

  for entry in ${!MENU[@]}; do
    dmenu_string+="${entry}\n"
  done

  echo -ne $dmenu_string | $DMENU_BIN
}

main() {
  local result=$(show_menu)
  eval "${MENU[$result]}"
}

main

