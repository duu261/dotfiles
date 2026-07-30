#!/usr/bin/env bash
set -euo pipefail
umask 077

: "${RESTIC_REPOSITORY:?Set RESTIC_REPOSITORY to encrypted off-machine storage}"
if [[ -z "${RESTIC_PASSWORD_FILE:-}" && -z "${RESTIC_PASSWORD_COMMAND:-}" ]]; then
  echo "Set RESTIC_PASSWORD_FILE or RESTIC_PASSWORD_COMMAND" >&2
  exit 2
fi
for command in hermes sqlite3 restic; do
  command -v "$command" >/dev/null || { echo "Missing required command: $command" >&2; exit 2; }
done

staging="$(mktemp -d "${TMPDIR:-/tmp}/ecosystem-backup.XXXXXX")"
trap 'rm -rf "$staging"' EXIT
mkdir -p "$staging/hermes" "$staging/omniroute/db_backups"

# Daily ecosystem backups need critical Hermes state, not disposable worktrees,
# caches, logs, and other bulk data. The separate weekly full snapshot covers
# the slower whole-state recovery tier.
#
# hermes backup --quick ignores --output (upstream bug): it saves raw files
# to ~/.hermes/state-snapshots/ only. Use --quick for the local snapshot,
# then copy the latest snapshot into the staging dir for restic.
hermes backup --quick --label ecosystem-daily
latest_snap="$(find "$HOME/.hermes/state-snapshots" -maxdepth 1 -type d \
  -name '*-ecosystem-daily' | sort | tail -n1)"
[[ -d "$latest_snap" ]] || { echo "No ecosystem-daily snapshot found" >&2; exit 3; }
cp -a "$latest_snap/." "$staging/hermes/"

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
