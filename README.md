# dotfiles

Arch Linux, Hyprland, Catppuccin Macchiato. Stow-managed dotfiles + ansible provisioning.

## Install

```bash
sudo pacman -S --needed base-devel git ansible-core ansible make
git clone --recurse-submodules https://github.com/duu261/dotfiles.git ~/dotfiles && cd ~/dotfiles
make install PROFILE=desktop   # or PROFILE=tui
```

Want language toolchains (java/rust/python) too? They're opt-in, run separately:

```bash
make install PROFILE=desktop TAGS=dev
```

## Make targets

| Target          | What it does                                              |
|-----------------|-------------------------------------------------------------|
| `make galaxy`   | Install required ansible-galaxy collections                |
| `make install`  | galaxy + run playbook (`PROFILE=desktop\|tui`, `TAGS=...`)  |
| `make desktop`  | Shortcut for `install PROFILE=desktop`                      |
| `make tui`      | Shortcut for `install PROFILE=tui`                          |
| `make check-desktop` | Dry-run (`--check`) of the desktop profile             |
| `make check-tui`     | Dry-run (`--check`) of the tui profile                 |

`TAGS` filters to matching tasks only (plus anything tagged `always`) — everything
else in the play is skipped, not just reordered. Used for opt-in roles like `dev`
(tagged `never`, so it only runs when explicitly requested via `TAGS=dev`).

Vault password comes from wherever you keep it (not in the repo). yay is bootstrapped
automatically if missing — no separate AUR helper step.

Tailored to my own setup — review `ansible/group_vars/` and roles before running on
another machine.

## Notes

- AUR packages install as unprivileged `aur_builder` user, scoped `NOPASSWD` sudo for
  `pacman` only.
- Resumed a partial run with `--start-at-task` and it skipped prerequisite tasks (user
  creation)? Resume from `--start-at-task="Create aur_builder user"` instead.
- Preview sddm theme without logout: `sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin-macchiato`
- sddm is preinstalled/enabled by archinstall before ansible ever runs; the "enable sddm" ansible task is a harmless no-op safety net, not the real work - the theme file copies right after it are.
