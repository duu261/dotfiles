# Backup and restore

## Boundary

Local rollback snapshots ≠ disaster backup. Disaster recovery needs encrypted copies outside this machine plus a tested restore.

## Minimal disaster backup

Normal laptop access uses Tailscale + SSH to this PC; it does not require a
second Hermes installation. This backup is for loss of the PC/disk.

The enabled scope is Hermes/Hindsight plus a consistent OmniRoute SQLite
snapshot and existing OmniRoute rollback databases. Firecrawl's service-aware
plan is documented below but disabled until its historical jobs become valuable;
Squid definitions are already reproducible and have no required mutable state.

Configure Restic credentials outside Git, then run:

```bash
export RESTIC_REPOSITORY='sftp:user@off-machine-host:/srv/restic/duu-ecosystem'
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/duu-ecosystem-password"
~/dotfiles/hermes/backup-minimal.sh
```

The script creates temporary private staging, verifies the Hermes ZIP, uses
SQLite's online backup API for OmniRoute (including committed WAL content),
uploads both to encrypted off-machine Restic storage, retains 7 daily, 4
weekly, and 6 monthly snapshots, then runs `restic check`. Temporary plaintext
staging is deleted on exit.

Do not put the Restic password, repository credential, archives, or snapshots
in Git. `RESTIC_PASSWORD_COMMAND` may replace `RESTIC_PASSWORD_FILE`.

## Hermes + Hindsight

Use Hermes' full backup/export path. It covers `~/.hermes` and asks the active memory provider for declared external paths; Hindsight therefore stays inside the Hermes backup workflow.

```bash
hermes backup --output /secure/path/hermes-backup.zip
hermes import --force /secure/path/hermes-backup.zip
hermes memory status
hermes config check
```

Backup archives contain secrets/private state. Store encrypted; never Git.

## OmniRoute

Live data:

```text
~/.omniroute/storage.sqlite
~/.omniroute/storage.sqlite-wal
~/.omniroute/storage.sqlite-shm
~/.omniroute/db_backups/
```

OmniRoute already creates local manual/pre-migration/repair DB backups under `~/.omniroute/db_backups`. These protect against a bad change, not disk loss.

`backup-minimal.sh` uses `sqlite3 .backup` against the live database and checks
the resulting snapshot with `PRAGMA integrity_check`; SQLite incorporates the
committed WAL state, so exported WAL/SHM files are neither copied nor needed.
The script also includes `db_backups/` as historical rollback inputs. Do not
naïvely copy only `storage.sqlite` while the service writes WAL data.

## Firecrawl service-aware plan (disabled by default)

Current mutable stores: FoundationDB `fdb-data`, shared `fdb-cluster-file`, the
PostgreSQL data mount, RabbitMQ data mount, plus runtime `.env`. Redis is an
ephemeral queue/cache here. Raw live-volume copies are not valid backups.

If Firecrawl history becomes recovery-critical, add an explicit opt-in backup
which records image/Compose revisions and uses native tools:

1. Quiesce API job producers/workers; verify queues stop changing.
2. FoundationDB: run the matching-image `fdbbackup` against the mounted cluster
   file; wait for a completed, restorable backup. Capture `fdb.cluster`
   separately with the backup metadata, never as the database backup itself.
3. PostgreSQL: run `pg_dump`/`pg_dumpall --globals-only` from the running,
   version-matched container; verify archives with `pg_restore --list`.
4. RabbitMQ: export definitions with `rabbitmqctl export_definitions`; preserve
   queued messages only if required, using a stopped-node volume snapshot or a
   supported RabbitMQ backup procedure for that exact version.
5. Encrypt/offload dumps, metadata, required volume snapshots, and runtime `.env`
   through Restic; never commit them.

Disposable restore order: Compose/images → runtime `.env` → cluster-file volume
→ FoundationDB restore/configure → PostgreSQL globals/database → RabbitMQ
node/definitions (and message store only if intentionally retained) → start
Redis, RabbitMQ, DB services → API/workers → endpoint/job checks. Keep production
stopped or isolated while proving restore. The current policy is rebuild from
Git/Ansible because historical jobs are not valuable enough to justify this
operationally disruptive path.

## Squid and other external state

Back up/provision:

- Squid config definitions
- required Agent Reach/MCP/browser profiles only after explicit inventory/classification
- generated Hermes backup archives
- OmniRoute consistent exports/snapshots

Do not back up reconstructable caches, logs, images, build outputs, or container layers unless proven necessary.

## Required proof

A backup is not accepted until:

1. Archive integrity check passes.
2. Restore occurs outside live paths.
3. SQLite integrity/config checks pass.
4. Hermes, Hindsight, OmniRoute, and selected external services start.
5. Retention and off-machine destination are documented.

## Restore proof (outside live paths)

Never restore directly over running services. Select a snapshot, restore into
a disposable directory, then verify it:

```bash
proof_dir="$(mktemp -d)"
trap 'rm -rf "$proof_dir"' EXIT
restic snapshots --tag ecosystem-minimal
restic restore latest --tag ecosystem-minimal --target "$proof_dir"
find "$proof_dir" -type f -name 'hermes-backup.zip' -exec unzip -tq {} \;
find "$proof_dir" -type f -name 'storage.sqlite' \
  -exec sqlite3 {} 'PRAGMA integrity_check;' \;
# Optional strongest Hermes proof: disposable user/VM only. `hermes import`
# writes the active Hermes home; never run it from the live account.
# hermes import --force "$proof_dir/.../hermes/hermes-backup.zip"
# hermes config check && hermes memory status
rm -rf "$proof_dir"
trap - EXIT
```

Expected SQLite output: `ok`. On actual disaster recovery, install Hermes and
OmniRoute first, import the restored Hermes archive with `hermes import
--force`, and restore OmniRoute through its dashboard/native restore workflow.
Do not overwrite the live OmniRoute database while its service is running.
