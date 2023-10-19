#!/usr/bin/make -f


SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
MAKEFLAGS += --no-print-directory

PIPX_BIN := ~/.local/bin/pipx

define log_info
	@echo -e "\e[32mINFO\t$1\e[39m"
endef


.PHONY: help
help:                 ## usage
	@echo Usage:  make [RECIPE] [OPTIONS]
	@echo ""
	@echo "    compile ZMK firmware"
	@echo ""
	@grep -E '^[a-z_A-Z0-9^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: submodules
submodules:          ## initialize the submodules
	git submodule update --init --recursive


$(PIPX_BIN):
	$(call log_info,installing $@...)
	pip install --user --upgrade pipx
	pipx ensurepath
	pipx completions
	grep -q "eval.*argcomplete pipx)" $(BASHRC) || echo 'eval "$(register-python-argcomplete pipx)"' >> $(BASHRC)


.PHONY: pipx
pipx: $(PIPX_BIN)        ## install pip extension 'pipx'


.PHONY: zephyr
zephyr:                  ## zephyr RTOS SDK
	$(call log_info,installing $@...)
	# TODO make this rule target the cmake output
	@$(ROOT_DIR)/install_zephyr.bash

