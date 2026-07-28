# Install and reconstruction

## What Ansible should reconstruct

- OS packages and services
- NetworkManager Cloudflare DNS policy
- Tailscale installation, enrollment, and `accept-dns=false`
- Hermes dashboard user unit
- OmniRoute user units
- external ecosystem components not covered by Hermes backup
- power-mode host permissions and scripts

Ansible must not copy a live Hermes or OmniRoute database/config tree into place.

## Provision

```bash
git clone --recurse-submodules git@github.com:duu261/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install PROFILE=desktop
```

The playbook is profile-driven through `ansible/site.yml`.

## Hermes

Install Hermes using its supported installer/version process, then restore a full backup:

```bash
hermes import --force /secure/path/hermes-backup.zip
hermes config check
hermes gateway install
hermes gateway start
```

Enable user services at boot once:

```bash
sudo loginctl enable-linger "$USER"
```

Hermes normally works from `$HOME`; do not globally pin it to the dotfiles repository. Agents working on this repository should launch/use tools with `~/dotfiles` as their task-local workdir.

## Hindsight

Hindsight is Hermes' active memory provider, not an independently managed system service:

```bash
hermes memory status
hermes memory setup   # only when setup/restore did not configure it
```

Do not duplicate its config in Ansible. Full Hermes backup asks the active provider for external backup paths.

## OmniRoute

Run-1 Ansible deploys the known-good user units. A later run must make installation/versioning reproducible and restore `~/.omniroute` from encrypted backup.

## Deferred

Separate later runs own:

- OmniRoute pinned installation/version policy
- Firecrawl Compose deployment and consistent Docker-volume recovery
- Squid deployment
- scheduled encrypted backups and tested restores
- Agent Reach/browser external-state inventory, if retained
