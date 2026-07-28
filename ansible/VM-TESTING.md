# Ansible test VM

`arch-test` is a disposable Arch staging machine. A real playbook run on this
VM is the installation test. `--check` is only a preview and cannot prove that
commands, packages, services, or registered-result conditionals work.

## 1. Push the revision under test

The VM clones GitHub, so the branch or commit must exist on `origin`. Never
assume a local unpushed commit is being tested.

```bash
git push -u origin <feature-branch>
```

## 2. Reset and boot the VM

Always select the system libvirt connection explicitly. Do not depend on an
interactive shell exporting `LIBVIRT_DEFAULT_URI`.

```bash
virsh -c qemu:///system snapshot-revert arch-test fresh
virsh -c qemu:///system start arch-test
virsh -c qemu:///system domifaddr arch-test --source lease
```

Use the IPv4 address reported by the final command.

## 3. Converge normally

Run from `/home/duu/dotfiles/ansible`. `tester` remains a human-gated SSH and
sudo account, so `-k` and `-K` intentionally prompt for its passwords.

```bash
ansible-playbook \
  -i '192.168.122.150,' \
  -u tester \
  -k \
  -K \
  --vault-password-file /absolute/path/to/vault-password-file \
  -e profile=desktop \
  -e dotfiles_version=<pushed-branch-or-commit> \
  site.yml
```

For a smaller diagnostic run, add `--tags <tags>`. A tagged run does not prove
that the full machine playbook works.

## 4. Verify and test idempotence

Inspect the VM's actual behavior, then run the exact same untagged command a
second time. The second run should report:

```text
failed=0
changed=0
```

Any nonzero `changed` count must be understood before production rollout. Some
legacy command tasks may need idempotence fixes rather than an exception.

Optional preview or drift inspection after convergence:

```bash
ansible-playbook ... --check --diff
```

This is supplementary, not a replacement for the two normal runs.

## 5. Stop and reset

```bash
virsh -c qemu:///system shutdown arch-test
```

If graceful shutdown hangs, force-stop without deleting the VM:

```bash
virsh -c qemu:///system destroy arch-test
```

The next test begins by reverting `fresh`. Replace that snapshot only after
deliberately preparing and verifying a new clean baseline.