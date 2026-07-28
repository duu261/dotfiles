# dotfiles

Arch Linux + Hyprland + Catppuccin Macchiato. GNU Stow manages user config;
Ansible provisions packages, services, secrets, networking, and desktop intent.

This repository is tailored to my machines. Review `ansible/group_vars/` and
`ansible/site.yml` before using it elsewhere.

## Install

```bash
sudo pacman -S --needed base-devel git ansible-core ansible make
git clone --recurse-submodules https://github.com/duu261/dotfiles.git ~/dotfiles
cd ~/dotfiles
make desktop
```

For a headless/TUI machine:

```bash
make tui
```

Both paths prompt for the sudo and Ansible Vault passwords. To use an existing,
protected vault-password file:

```bash
make desktop VAULT_PASSWORD_FILE=/absolute/path/to/vault-password-file
```

Language toolchains are opt-in:

```bash
make desktop TAGS=dev
```

`TAGS` restricts execution to matching tasks; a tagged run is not a full-machine
test.

## Make targets

| Target | Purpose |
|---|---|
| `make galaxy` | Install required Ansible collections |
| `make syntax PROFILE=desktop` | Parse/syntax-check one profile |
| `make lint` | Run `ansible-lint` on `site.yml` |
| `make validate PROFILE=desktop` | Run syntax + lint |
| `make install PROFILE=desktop` | Install/converge the selected profile |
| `make desktop` | Shortcut for the desktop converge |
| `make tui` | Shortcut for the TUI converge |
| `make preview-desktop` | `--check --diff` preview; not an install test |
| `make preview-tui` | TUI equivalent preview |

Useful variables:

```text
PROFILE=desktop|tui
TAGS=dev
DOTFILES_VERSION=main|<pushed-branch>|<commit>
VAULT_PASSWORD_FILE=/absolute/path
```

`DOTFILES_VERSION` matters when a staging machine clones this repository: pass
the pushed feature branch or commit under test instead of silently testing old
`main`.

## Testing

A valid machine test is:

1. Run `make validate PROFILE=desktop`.
2. Run a normal converge on the staging or real target.
3. Inspect actual services, files, listeners, DNS, and desktop behavior.
4. Run the identical normal converge again.
5. Require `failed=0 changed=0` before merging.

Ansible check mode is only a preview/drift aid. Commands, async work, service
integration, and registered-result conditionals may not be proven by `--check`.
The disposable libvirt workflow is documented in `ansible/VM-TESTING.md`.

## Layout

- `ansible/site.yml` — single profile-driven entry point
- `ansible/roles/` — host/service intent
- `ansible/group_vars/` — shared and desktop package/config variables
- `bin/dot-bin/` — Stow-managed helper commands → `~/.bin`
- `hermes/` — Hermes ecosystem architecture, operations, and recovery docs
- `nvim/dot-config/nvim` — separate Git submodule; edit in its own repository
- `zsh/dot-secrets` — Ansible Vault ciphertext deployed as `~/.secrets`
- `secrets-save` — safely refresh that ciphertext after editing `~/.secrets`

Mutable Hermes/Hindsight/OmniRoute state, databases, auth files, sessions, logs,
and `.env` files do not belong in Git. See `hermes/README.md` and
`hermes/BACKUP-RESTORE.md` for ownership and backup boundaries.

## Operational notes

- AUR packages install through the unprivileged `aur_builder` user with narrowly
  scoped package-manager sudo.
- Avoid `--start-at-task` unless prerequisite state is already known; it can skip
  required setup tasks.
- Preview SDDM without logout:

  ```bash
  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin-macchiato
  ```

- SDDM is normally installed by Arch setup; Ansible enforces the desired state
  and deploys its theme/config.
