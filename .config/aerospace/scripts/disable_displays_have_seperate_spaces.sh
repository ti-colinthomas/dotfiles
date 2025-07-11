#!/bin/bash

defaults write com.apple.spaces spans-displays -bool true
killall SystemUIServer

echo "Disabled 'Displays have separate Spaces'. You may need to log out and back in for full effect."

