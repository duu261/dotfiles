# Operations

## Status

```bash
hermes config check
hermes gateway list
hermes memory status
systemctl --user status hermes-gateway.service hermes-dashboard.service omniroute.service omniroute-tailscale-proxy.service
systemctl status tailscaled.service docker.service
hermes-health-check
```

## Endpoints

```bash
curl -fsS http://127.0.0.1:20128/v1/models >/dev/null
curl -fsS http://127.0.0.1:3002/ >/dev/null
```

Dashboard launcher:

```bash
hermes-dashboard-phone
```

OmniRoute dashboard info:

```bash
omniroute-dashboard
```

## DNS censorship-bypass validation

NetworkManager—not `systemd-resolved`—owns DNS on this host.

```bash
nmcli -g ipv4.ignore-auto-dns,ipv4.dns,ipv6.ignore-auto-dns,ipv6.dns connection show "Wired connection 1"
tailscale debug prefs | jq '{CorpDNS,WantRunning}'
getent ahostsv4 reddit.com
curl -ILsS --max-time 12 -o /dev/null -w 'reddit http=%{http_code} ip=%{remote_ip}\n' https://reddit.com
```

Expected:

- Cloudflare IPv4 `1.1.1.1,1.0.0.1`
- Cloudflare IPv6 configured
- `CorpDNS: false`
- Reddit HTTP success
- Tailscale still connected

## Service logs

```bash
journalctl --user -u hermes-gateway.service -n 100 --no-pager
journalctl --user -u hermes-dashboard.service -n 100 --no-pager
journalctl --user -u omniroute.service -n 100 --no-pager
journalctl --user -u omniroute-tailscale-proxy.service -n 100 --no-pager
```

## Hindsight lifecycle

Hindsight is an on-demand Hermes memory plugin, not a separately enabled unit. `hermes memory status` is authoritative for config availability. A missing idle health daemon alone is not failure; exercise retain/recall only when diagnosing actual memory behavior.

## Power mode

See [POWER-MODE.md](POWER-MODE.md). Server mode deliberately preserves LAN, NetworkManager, Tailscale, Docker, Hermes, and OmniRoute.

## Minimal disaster backup

```bash
~/dotfiles/hermes/backup-minimal.sh
restic snapshots --tag ecosystem-minimal
```

See [BACKUP-RESTORE.md](BACKUP-RESTORE.md) for required Restic environment,
retention, and disposable restore proof. Laptop access normally remains SSH
over Tailscale; this backup is for loss of the primary PC/disk.
