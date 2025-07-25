#!/bin/bash

host=$(hostname)
if [[ "$(cat /proc/device-tree/model 2>/dev/null)" == *"Raspberry Pi"* ]]; then
  temp_raw=$(cat /sys/class/thermal/thermal_zone0/temp)
  temp_c=$(awk "BEGIN { printf \"%.1f\", $temp_raw / 1000 }")

  if (($(echo "$temp_c < 60" | bc -l))); then
    color="green"
  elif (($(echo "$temp_c < 65" | bc -l))); then
    color="yellow"
  else
    color="red"
  fi
  echo "#[fg=cyan]$host | #[fg=$color]$temp_c°C"
else
  echo "#[fg=cyan]$host"
fi
