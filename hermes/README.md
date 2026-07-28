# Hermes ecosystem

Purpose: remember how this machine's Hermes stack is reconstructed and recovered.
This directory documents the system; it does not contain live Hermes state.

## Ownership

| Owner | Responsibility |
|---|---|
| Hermes full backup | `~/.hermes` config, credentials, profiles, sessions, skills, memory, cron, plugins, databases; active memory-provider external paths such as Hindsight when declared by the plugin |
| Ansible/dotfiles | Host packages, DNS/Tailscale policy, external user services, power-mode integration, scripts, safe service definitions |
| Encrypted off-machine backup | Hermes backup archives, OmniRoute data/backups, external mutable data and secrets, later Firecrawl volume backups |
| These docs | Setup order, architecture, operations, validation, recovery boundaries |

Never commit `~/.hermes`, `~/.omniroute`, backup archives, OAuth/auth files, `.env`, sessions, logs, databases, or browser profiles.

## Current components

| Component | Purpose | Live location | Provision/recovery owner |
|---|---|---|---|
| Hermes gateway | Telegram/other channel agent | `~/.hermes`, generated user unit | Install/restore via Hermes CLI + full backup |
| Hindsight | Active external memory provider | Hermes plugin plus provider-declared external paths | `hermes memory`; full Hermes backup |
| OmniRoute | Local AI gateway/router | npm binary, `~/.omniroute`, user units | Pinned version (3.8.48) and user units managed via Ansible |
| Hermes dashboard | Phone dashboard on Tailscale | user unit | Ansible |
| Tailscale | Remote access | system service | Ansible |
| Cloudflare DNS | Bypass ISP DNS blocking, including Reddit | NetworkManager connection + Tailscale DNS preference | Ansible |
| Docker/Firecrawl | Local web extraction stack | `~/apps/firecrawl`, Docker volumes | Repository checkout, env configs, and Compose services managed via Ansible |
| Squid proxies | Local proxy pool | containers plus `~/docker/squid-proxy/` configs | Configs, Compose service, monitor, and test script managed via Ansible |
| Power mode | Preserve server stack while desktop sleeps | stowed scripts + sudoers/udev | Existing desktop role/scripts |

## Fresh-machine order

1. Provision Arch with `make install PROFILE=desktop`.
2. Install/restore Hermes using its supported CLI and full backup.
3. Configure Hindsight through `hermes memory setup` if restore did not reactivate it.
4. Restore OmniRoute/external mutable data from encrypted backup.
5. Complete later-run Firecrawl/Squid reconstruction.
6. Validate with [OPERATIONS.md](OPERATIONS.md).

## Files

- [INSTALL.md](INSTALL.md) — machine/bootstrap sequence and Ansible boundary
- [BACKUP-RESTORE.md](BACKUP-RESTORE.md) — Hermes, Hindsight, OmniRoute, external data
- [OPERATIONS.md](OPERATIONS.md) — status and health commands
- [POWER-MODE.md](POWER-MODE.md) — low-power server/desktop toggles
- `hermes-power-sudoers` — historical/reference sudoers; Ansible is authoritative where implemented
