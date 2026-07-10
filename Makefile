ANSIBLE_DIR := ansible
PLAYBOOK := site.yml
PROFILE ?= desktop
TAGS ?=
TAG_ARGS := $(if $(TAGS),--tags $(TAGS),)

.PHONY: galaxy install tui desktop check-tui check-desktop

galaxy:
	cd $(ANSIBLE_DIR) && ansible-galaxy collection install -r requirements.yml

install: galaxy
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --ask-become-pass --ask-vault-pass -e profile=$(PROFILE) $(TAG_ARGS)

tui: galaxy
	$(MAKE) install PROFILE=tui TAGS=$(TAGS)

desktop: galaxy
	$(MAKE) install PROFILE=desktop TAGS=$(TAGS)

check-tui:
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --check --ask-become-pass --ask-vault-pass -e profile=tui $(TAG_ARGS)

check-desktop:
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --check --ask-become-pass --ask-vault-pass -e profile=desktop $(TAG_ARGS)
