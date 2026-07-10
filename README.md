# dotfiles

Arch Linux, Hyprland, Catppuccin Macchiato. Stow-managed dotfiles + ansible provisioning.

## Install

```bash
sudo pacman -S --needed base-devel git ansible-core ansible make
git clone --recurse-submodules https://github.com/<you>/dotfiles.git ~/dotfiles && cd ~/dotfiles
make install PROFILE=desktop   # or PROFILE=tui
```

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
- `dev` role (language toolchains, e.g. jdk-openjdk) is opt-in, skipped by default: `make install TAGS=dev`.
