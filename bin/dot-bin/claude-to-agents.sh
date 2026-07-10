#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in --revert)
  cd "${2:-.}"
  echo "=== REVERT ==="
  while IFS= read -r -d '' link; do
    if [ "$(readlink "$link")" = "CLAUDE.md" ]; then
      rm "$link" && echo "removed symlink $link"
    fi
  done < <(find . -type l -name 'AGENTS.md' -print0)
  exit 0
  ;;
esac

DRY_RUN=0
case "${1:-}" in --dry-run) DRY_RUN=1; shift ;; esac

cd "${1:-.}"

mapfile -t files < <(fd -H -t f -g -i 'CLAUDE.md' -E .git)
if [ ${#files[@]} -eq 0 ]; then echo "No CLAUDE.md files found."; exit 0; fi

err=0

for filepath in "${files[@]}"; do
  d="$(realpath "$(dirname "$filepath")")"
  f="$(basename "$filepath")"

  echo "--- $d/$f ---"

  if [ -f "$d/AGENTS.md" ] && [ ! -L "$d/AGENTS.md" ]; then
    echo "ERROR: $d/AGENTS.md real file"; err=1; continue
  fi

  if [ "$DRY_RUN" = 1 ]; then
    echo "[dry] symlink $d/AGENTS.md -> $f + edit header"
    continue
  fi

  ln -sf "$f" "$d/AGENTS.md" && echo "symlink $d/AGENTS.md -> $f" || { echo "FAIL: ln"; err=1; continue; }

  sed -i \
    -e "s/^# CLAUDE\.md/# AGENTS.md/" \
    -e "s/This file provides guidance to Claude Code (claude\\.ai\\/code) when working with code in this repository\\./This file provides guidance to AI agents when working with code in this repository./" \
    -e "s/Claude Code (claude\\.ai\\/code)/AI agents/g" \
    "$d/$f" && echo "updated $d/$f" || { echo "FAIL: sed"; err=1; }
done

if [ "$err" -ne 0 ]; then
  echo "Errors found. Run with --revert to undo."
  exit 1
fi

echo "Done. Run with --revert to remove symlinks."
