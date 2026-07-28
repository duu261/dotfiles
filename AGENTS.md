# Dotfiles

Personal dotfiles for Arch Linux with Hyprland.

## Structure

Stow-style layout with `--dotfiles` flag: directories use `dot-` prefix (e.g. `zsh/dot-zsh/` → `~/.zsh/`).

### Stow packages

Shared now: bat, bin, nvim, starship, tmux, yazi, zsh

Desktop now: caelestia (shell.json config, not to be confused with the `caelestia-shell` AUR package it configures), fuzzel, gtk-3.0, hypr, kvantum, qt6ct, swappy, wezterm


### Non-stow (ansible-only)

- `sddm/` - targets `/etc/sddm.conf.d/` and `/usr/share/sddm/themes/`, system/root-owned paths outside `$HOME`. Stow can't symlink here; deploy via ansible `copy` with `become: true` instead.
- `openrgb/` - targets `/etc/systemd/system/`. Same pattern as sddm: store file in repo, deploy via Ansible with `become: true`.
- `zsh/dot-secrets` - vault-encrypted source for `~/.secrets`; ciphertext is tracked, plaintext target is not.

### Submodules

- `nvim/.config/nvim` → [github.com/duu261/nvim.git](https://github.com/duu261/nvim.git) - separate repo, do not edit nvim config inline

## Ansible

Single entry point: `ansible/site.yml`.

Profiles are runtime vars, not inventory groups:
- `-e profile=tui`
- `-e profile=desktop`

`site.yml` loads desktop vars when `profile == 'desktop'`. Keep profile-specific behavior there; do not reintroduce split playbooks or fake inventory groups for localhost.

## Secrets

`zsh/dot-secrets` is git-tracked but ansible-vault encrypted (`$ANSIBLE_VAULT;1.1;AES256` header) and holds API keys. It is not stow-symlinked directly, since ciphertext can't be `source`'d by zsh. Runtime copy lives at `~/.secrets`, sourced from `zsh/dot-zshrc`.

Ansible now deploys `~/.secrets` via `roles/secrets`. Manual rotation still looks like this:

```bash
ansible-vault decrypt /home/duu/dotfiles/zsh/dot-secrets --output=/home/duu/dotfiles/zsh/dot-secrets.tmp
# edit dot-secrets.tmp with your editor, swap in new values
mv /home/duu/dotfiles/zsh/dot-secrets.tmp /home/duu/dotfiles/zsh/dot-secrets
ansible-vault encrypt /home/duu/dotfiles/zsh/dot-secrets
ansible-vault decrypt /home/duu/dotfiles/zsh/dot-secrets --output=/home/duu/.secrets
chmod 600 ~/.secrets
so   # reload zshrc (alias)
```

On a fresh machine, Ansible can create `~/.secrets` during provisioning as long as vault password is available. If rotating manually after provision, same last 3 lines still apply.

Prefer `ansible-vault edit zsh/dot-secrets`. A protected
`--vault-password-file` is valid for intentional automation; never commit the
password file or expose vault credentials in commands, logs, or chat.

## Rules

- Do not modify nvim config here - it lives in its own repo as submodule
- Verify stow compatibility when adding new packages - directory must mirror target path under `$HOME`
- Catppuccin Macchiato is color scheme

## caelestia-shell integration

Desktop shell is `caelestia-shell` (AUR), quickshell-based. It self-implements notification daemon, lock screen, and idle management - do not add `hyprlock`/`hypridle`/`dunst`/`mako`/etc alongside it, they duplicate caelestia's own tray/status/lock features and cause double-tray-icon conflicts (seen with `nm-applet`/`blueman-applet` vs caelestia's native `bar.status` network/bluetooth icons).

`~/.config/caelestia/shell.json` is the config; keys not set fall back to documented defaults (bundled with caelestia-shell docs).

When adding/removing a package that a hypr config file (`execs.lua`, `keybinds.lua`, `rules.lua`) or a caelestia app-default shells out to:
- add/remove it in `ansible/group_vars/desktop.yml` `desktop_packages`/`desktop_aur_packages`, not just install it manually - an orphan package works on this machine but silently breaks a fresh provision
- if the package has an actual dotfiles config directory here, add it to `desktop_stow_packages` too, or the package installs but its config never gets symlinked
- update the inline `# comment` next to the package entry if what references it changed - stale comments (pointing at deleted rofi/fuzzel configs, a since-renamed `autostart.conf`) accumulate silently otherwise

## Agent reference

Directory conventions and Ansible patterns for agents working in this repo.

### Directory patterns

| Pattern | Example | Deployed by | Target |
|---------|---------|-------------|--------|
| `dot-` prefix (stow) | `zsh/dot-zsh/` | Ansible `stow` | `~/.zsh/` |
| Flat dir (system) | `sddm/`, `openrgb/` | Ansible `copy` + `become` | `/etc/`, `/usr/share/` |
| Ansible-only (vault) | `zsh/dot-secrets` | `roles/secrets` | `~/.secrets` (decrypted) |

Stow packages use `--dotfiles` flag: `dot-config` becomes `.config`, `dot-zsh` becomes `.zsh`. Every stow package needs a corresponding entry in `stow_packages` or `desktop_stow_packages` in group_vars.

System directories (sddm, openrgb) hold files destined for root-owned paths. The directory name matches the role/package, not the target path. Ansible tasks use `copy` with `become: true` - see `ansible/roles/desktop/tasks/main.yml` for examples.

### Adding a package

Checklist, in order:

1. **Package**: add to `desktop_packages` or `desktop_aur_packages` in `ansible/group_vars/desktop.yml`
2. **Config**: if it has dotfiles config, create the stow dir with `dot-` prefix and add to `desktop_stow_packages` (or `stow_packages` if shared with tui profile)
3. **System files**: if it needs files in `/etc/` or `/usr/`, create a flat dir at repo root (like `sddm/`, `openrgb/`) and add Ansible tasks to copy them with `become: true`
4. **Systemd services**: for system services, store the `.service` file in the package's flat dir, add ansible `copy` + `systemd` tasks. For user services, use stow (`dot-config/systemd/user/`)

### Ansible layout

```
ansible/
  site.yml              # single entry point, profile-driven
  group_vars/desktop.yml # desktop_packages, desktop_aur_packages, desktop_stow_packages
  roles/
    base/                # pacman tier1 + aur + xdg-user-dirs
    dotfiles/            # clone repo + stow
    ecosystem/           # external Hermes/OmniRoute user-service definitions
    network/             # NetworkManager DNS policy
    desktop/             # GUI packages, services, sddm, openrgb (profile=desktop only)
    shell/               # zsh + plugins
    secrets/             # vault-decrypt ~/.secrets
```

Shared roles run always. `desktop` and `dev` roles are gated with `when: profile == 'desktop'` or `tags: [dev, never]`.

### Hermes ecosystem boundary

There is intentionally no monolithic `roles/hermes`. Ansible manages stable
host intent through contextual roles such as `ecosystem`, `network`, and
`tailscale`. Keep Hermes/Hindsight/OmniRoute runtime state outside Git. Never
commit or copy `.env`, auth/OAuth files, sessions, memories, logs, DBs, caches,
request dumps, generated model catalogs, or live runtime `config.yaml` files.

For substantial changes: create a feature branch first, make small thematic
checkpoint commits, and never absorb unrelated dirty files. Validation order:
syntax/lint, real converge on a disposable VM or human-gated host, functional
inspection, then an identical second run requiring `changed=0`. `--check` is a
preview/drift aid, not proof of a fresh installation.

### Systemd services

- **System service**: file in flat dir (e.g. `openrgb/openrgb-off.service`), ansible copies to `/etc/systemd/system/`, enables + starts with `become: true`
- **User service**: file in stow dir (e.g. `mypkg/dot-config/systemd/user/mysvc.service`), ansible enables with `scope: user`, no become
- `daemon_reload: true` when deploying new/updated unit files
