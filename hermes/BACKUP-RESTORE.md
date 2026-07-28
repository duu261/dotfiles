# Backup and restore

## Boundary

Local rollback snapshots ≠ disaster backup. Disaster recovery needs encrypted copies outside this machine plus a tested restore.

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

Later backup run must copy a consistent SQLite snapshot or a verified native export to encrypted off-machine storage. Do not naïvely copy only `storage.sqlite` while the service writes WAL data.

## Firecrawl

Mutable Docker volumes currently include FoundationDB, PostgreSQL, RabbitMQ, plus cluster metadata. Raw live-volume copying can be inconsistent. Later backup work must use service-aware dumps/snapshots, record restore order, then prove restore in a disposable environment.

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
