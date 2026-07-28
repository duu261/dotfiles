# Power Mode Toggle

Scripts in `bin/dot-bin/`, stowed to `~/.bin/`.

## Telegram quick commands (config.yaml)

```yaml
quick_commands:
  smode:
    type: exec
    command: /home/duu/.bin/server-mode
  dmode:
    type: exec
    command: /home/duu/.bin/desktop-mode
  rspc:
    type: exec
    command: /home/duu/.bin/reboot-machine
```

## What they do

### `/smode` — Server mode (AFK)
- Record current power profile, SDDM state, Bluetooth state
- Set `power-saver`
- Stop Bluetooth only if previously active
- Stop SDDM/desktop only if previously active
- Power off the monitor via DDC/CI
- Preserve LAN, NetworkManager, Tailscale, Docker, Hermes, OmniRoute

### `/dmode` — Desktop mode (sit down)
- Restore recorded power profile
- Restore SDDM and Bluetooth only when previously active
- Power on the monitor via DDC/CI
- Remove recorded runtime state after successful restoration

### `/rspc` — Reboot
- `sudo systemctl reboot` (3s delay, bypasses Hermes hardline block)

## Sudoers

File: `/etc/sudoers.d/hermes-power`

```bash
sudo cp /tmp/hermes-power-sudoers /etc/sudoers.d/hermes-power && sudo chmod 440 /etc/sudoers.d/hermes-power && sudo visudo -cf /etc/sudoers.d/hermes-power
```

Sudoers content covers: tee for cpu/gpu/pcie sysfs, nvidia-smi, systemctl (bluetooth, docker, libvirtd, wpa, sddm), ddcutil, reboot.

## Dependencies

- `ddcutil` — monitor power off via DDC/CI
- `i2c-dev` kernel module + i2c group + udev rule
- `power-profiles-daemon` (already running)
- NVIDIA proprietary driver

## Re-apply on fresh install

1. Install deps: `sudo pacman -S ddcutil`
2. i2c access: `sudo groupadd -f i2c && sudo usermod -aG i2c duu`
3. udev: `echo 'KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"' | sudo tee /etc/udev/rules.d/99-i2c.rules && sudo udevadm control --reload-rules && sudo udevadm trigger`
4. Sudoers: copy `/tmp/hermes-power-sudoers` or recreate from above
5. Quick commands: update paths in quick_commands if username changed
6. Log out and back in for i2c group
