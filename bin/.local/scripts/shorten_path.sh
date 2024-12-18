#!/bin/bash

FULL_PATH="$1"
HOME_DIR="$HOME"

# Only replace home directory with ~ if it's at the beginning of the path
if [[ "$FULL_PATH" == "$HOME_DIR"* ]]; then
  SHORT_PATH="~${FULL_PATH#$HOME_DIR}"
else
  SHORT_PATH="$FULL_PATH"
fi

# Shorten each component of the path
IFS='/' read -ra COMPONENTS <<< "$SHORT_PATH"
SHORTENED_COMPONENTS=()
LAST_COMPONENT_INDEX=$(( ${#COMPONENTS[@]} - 1 ))

for i in "${!COMPONENTS[@]}"; do
  COMPONENT="${COMPONENTS[$i]}"
  if [[ "$i" == "$LAST_COMPONENT_INDEX" ]]; then
    # Keep the last component as is
    SHORTENED_COMPONENTS+=("$COMPONENT")
  elif [[ "$COMPONENT" == "~" ]]; then
    # Keep ~ as is
    SHORTENED_COMPONENTS+=("$COMPONENT")
  elif [[ "$COMPONENT" != "" ]]; then
    # Shorten the component to the first character, including the dot for hidden files/dirs
    SHORTENED_COMPONENTS+=("${COMPONENT:0:1}")
  else
    SHORTENED_COMPONENTS+=("$COMPONENT")
  fi
done

# Join the components back into a path
IFS='/'
SHORTENED_PATH="${SHORTENED_COMPONENTS[*]}"

echo "$SHORTENED_PATH"
