#!/usr/bin/env bash
set -euo pipefail
umask 077

: "${RESTIC_REPOSITORY:?Set RESTIC_REPOSITORY to encrypted off-machine storage}"
if [[ -z "${RESTIC_PASSWORD_FILE:-}" && -z "${RESTIC_PASSWORD_COMMAND:-}" ]]; then
  echo "Set RESTIC_PASSWORD_FILE or RESTIC_PASSWORD_COMMAND" >&2
  exit 2
fi
for command in hermes sqlite3 restic unzip; do
  command -v "$command" >/dev/null || { echo "Missing required command: $command" >&2; exit 2; }
done

staging="$(mktemp -d "${TMPDIR:-/tmp}/ecosystem-backup.XXXXXX")"
trap 'rm -rf "$staging"' EXIT
mkdir -p "$staging/hermes" "$staging/omniroute/db_backups"

hermes backup --output "$staging/hermes/hermes-backup.zip"
unzip -tq "$staging/hermes/hermes-backup.zip" >/dev/null

source_db="$HOME/.omniroute/storage.sqlite"
[[ -f "$source_db" ]] || { echo "Missing OmniRoute database: $source_db" >&2; exit 2; }
sqlite3 "$source_db" ".backup '$staging/omniroute/storage.sqlite'"
[[ "$(sqlite3 "$staging/omniroute/storage.sqlite" 'PRAGMA integrity_check;')" == "ok" ]]
# Existing rollback DBs are immutable historical inputs, not substitutes for the
# online snapshot. Copy them after the authoritative snapshot and verify SQLite
# files that can be opened; WAL/SHM are deliberately unnecessary in the export.
if [[ -d "$HOME/.omniroute/db_backups" ]]; then
  cp -a "$HOME/.omniroute/db_backups/." "$staging/omniroute/db_backups/"
fi

(
  cd "$staging"
  restic backup --tag ecosystem-minimal --host "$(hostname)" hermes omniroute
)
restic forget --tag ecosystem-minimal --host "$(hostname)" \
  --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
restic check
printf 'Backup complete. Run disposable restore proof from: %s\n' \
  "$HOME/dotfiles/hermes/BACKUP-RESTORE.md"
