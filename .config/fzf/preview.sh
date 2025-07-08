#!/bin/bash

file="$1"

# if [[ -d "$file" ]]; then
#   tree -C "$file" 2>/dev/null || ls -la "$file"
#   exit
# fi

if [[ -d "$file" ]]; then
  if command -v eza &>/dev/null; then
    eza --color=always --tree "$file"
  elif command -v tree &>/dev/null; then
    tree -C "$file"
  else
    ls -la "$file"
  fi
  exit
fi

case "$(file --mime-type -Lb "$file")" in
  text/*)
    bat --style=numbers --color=always --line-range=:500 "$file" 2>/dev/null || head -n 100 "$file"
    ;;
  application/json)
    # jq . "$file" 2>/dev/null || cat "$file"
    bat --style=numbers --color=always "$file" 2>/dev/null || cat "$file"
    ;;
  application/xml)
    bat --style=numbers --color=always "$file" 2>/dev/null || cat "$file"
    ;;
  image/*)
    if command -v imgcat &>/dev/null; then
      imgcat "$file"
    else
      echo "[Image] $file"
    fi
    ;;
  text/markdown)
    glow -s dark "$file" 2>/dev/null || bat "$file"
    ;;
  *)
    head -n 100 "$file"
    ;;
esac

