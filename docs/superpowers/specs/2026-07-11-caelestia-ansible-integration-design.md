# Caelestia ansible integration design

## Goal

Make Caelestia shell setup reproducible through existing desktop ansible flow while keeping custom user configuration in this dotfiles repo.

## Scope

In scope:
- Install Caelestia runtime dependencies through desktop ansible variables
- Manage Caelestia user config from this repo as stowed dotfiles
- Stop treating current ad-hoc `~/.config/quickshell/` custom shell files as target state
- Reuse existing `desktop` profile, `dotfiles` role, and stow package layout

Out of scope:
- Cloning or building upstream Caelestia shell from source
- Managing upstream shell payload in this repo
- Preserving current custom Quickshell shell implementation
- Refactoring ansible role structure unless blocked by existing role behavior

## Current state

Current machine has:
- `caelestia-cli` installed
- `quickshell-git` installed
- existing `~/.config/caelestia/` with `shell.json` and monitor overrides
- existing `~/.config/quickshell/` with custom QML files from older local work

Current repo state has:
- desktop ansible profile already managing desktop package set
- `quickshell` runtime already listed in desktop packages
- no stow package for `caelestia`
- no ansible-managed ownership of current Caelestia user config

## Decision

Use package-managed runtime plus repo-managed config.

That means:
- ansible installs packages needed to run Caelestia shell
- repo owns `~/.config/caelestia/` contents via stow
- ansible does not clone or build Caelestia shell source
- repo does not keep current custom `~/.config/quickshell/` shell as desired end state

This is smallest reproducible setup that matches goal. It reuses existing ansible and stow patterns instead of adding a new install path.

## Repo layout

Add a new stow package:

- `caelestia/dot-config/caelestia/`

Populate it from wanted files currently under:

- `~/.config/caelestia/`

Expected tracked files initially:
- `caelestia/dot-config/caelestia/shell.json`
- `caelestia/dot-config/caelestia/monitors/...` if monitor-specific overrides are intentionally part of desired state

Do not add a new `quickshell/` payload for upstream Caelestia shell unless later verification proves package-managed runtime cannot provide shell code.

## Ansible changes

Change only existing desktop configuration points:

1. `ansible/group_vars/desktop.yml`
   - ensure desktop package list contains packages required for package-managed Caelestia runtime
   - add `caelestia` to `desktop_stow_packages`

2. Existing stow deployment flow
   - reuse current `dotfiles` role behavior to link `caelestia/dot-config/caelestia` into `~/.config/caelestia`

No new ansible role unless current roles cannot express package installation plus stow package selection.

## Data ownership

Owned by repo:
- custom Caelestia user configuration under `~/.config/caelestia`

Owned by package manager and system:
- `caelestia` executable and CLI package files
- `quickshell` runtime package files
- any upstream shell code delivered by packages

Not part of target state:
- current hand-maintained `~/.config/quickshell/` custom shell files

## Migration plan

1. Inspect current `~/.config/caelestia/` files
2. Copy only desired Caelestia config into new repo stow package
3. Add `caelestia` stow package to desktop profile
4. Fill any missing runtime packages in desktop package list
5. Run desktop ansible profile
6. Verify resulting symlinks and commands
7. Remove or ignore old custom `~/.config/quickshell/` files as non-authoritative local leftovers

## Verification

Minimum verification:
- desktop ansible run completes successfully with `-e profile=desktop`
- `~/.config/caelestia` files come from repo via stow symlinks
- `caelestia` command exists after provision
- `qs` or required Quickshell runtime exists after provision

Success criteria:
- a desktop-profile machine can be provisioned without manual Caelestia config copy steps
- repo becomes source of truth for Caelestia user config
- old local Quickshell shell files are no longer required to recreate target setup

## Risks

### Package/runtime mismatch

Risk:
package-managed runtime may not include enough upstream shell payload for desired behavior.

Response:
verify package-managed path first. Only add source-managed shell install if package path fails on real setup.

### Host-specific monitor overrides

Risk:
current `monitors/.../shell.json` files may encode machine-specific state not suitable for all desktop installs.

Response:
only track monitor overrides that are intentionally part of desired shared setup. Leave purely local monitor state out of repo.

## Testing

Testing stays minimal:
- one ansible desktop run
- one filesystem ownership check for stow symlinks
- one command existence check for `caelestia` and Quickshell runtime

No extra test harness or new ansible role tests unless existing flow exposes a gap.
