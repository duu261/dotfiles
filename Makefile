ANSIBLE_DIR := ansible
PLAYBOOK := site.yml
PROFILE ?= desktop
TAGS ?=
DOTFILES_VERSION ?= main
VAULT_PASSWORD_FILE ?=
TAG_ARGS := $(if $(TAGS),--tags $(TAGS),)
VERSION_ARGS := -e dotfiles_version=$(DOTFILES_VERSION)
VAULT_ARGS := $(if $(VAULT_PASSWORD_FILE),--vault-password-file $(VAULT_PASSWORD_FILE),--ask-vault-pass)

.PHONY: galaxy syntax lint validate install tui desktop preview preview-tui preview-desktop

galaxy:
	cd $(ANSIBLE_DIR) && ansible-galaxy collection install -r requirements.yml

syntax:
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --syntax-check -e profile=$(PROFILE) $(VERSION_ARGS)

lint:
	cd $(ANSIBLE_DIR) && ansible-lint $(PLAYBOOK)

validate: syntax lint

install: galaxy
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --ask-become-pass $(VAULT_ARGS) -e profile=$(PROFILE) $(VERSION_ARGS) $(TAG_ARGS)

tui:
	$(MAKE) install PROFILE=tui TAGS=$(TAGS) DOTFILES_VERSION=$(DOTFILES_VERSION) VAULT_PASSWORD_FILE=$(VAULT_PASSWORD_FILE)

desktop:
	$(MAKE) install PROFILE=desktop TAGS=$(TAGS) DOTFILES_VERSION=$(DOTFILES_VERSION) VAULT_PASSWORD_FILE=$(VAULT_PASSWORD_FILE)

preview:
	cd $(ANSIBLE_DIR) && ansible-playbook $(PLAYBOOK) --check --diff --ask-become-pass $(VAULT_ARGS) -e profile=$(PROFILE) $(VERSION_ARGS) $(TAG_ARGS)

preview-tui:
	$(MAKE) preview PROFILE=tui TAGS=$(TAGS) DOTFILES_VERSION=$(DOTFILES_VERSION) VAULT_PASSWORD_FILE=$(VAULT_PASSWORD_FILE)

preview-desktop:
	$(MAKE) preview PROFILE=desktop TAGS=$(TAGS) DOTFILES_VERSION=$(DOTFILES_VERSION) VAULT_PASSWORD_FILE=$(VAULT_PASSWORD_FILE)
