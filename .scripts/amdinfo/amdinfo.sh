#!/bin/sh

DEVICE="amdgpu-pci-0400"
SENSOR="temp1"

while true; do
  temp="$(sensors $DEVICE 2>/dev/null | sed -En "s/^$SENSOR:\s+[\+\-]([0-9]+).*\(.*$/\1/p")"

  if [ -z "$temp" ]; then
    echo "off"
  else
    echo "$temp°C"
  fi

  sleep 5;
done;

