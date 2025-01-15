#!/bin/bash
if xset q | grep "Caps Lock:   on" >/dev/null; then
  echo '{"text":"󰘲"}'
else
  echo ''
fi
