#!/usr/bin/make -f

# compile the keyboard firmware
#     compiles the keyboard firmware w/ the custom keymap to `zmk.uf2`
#     which can then be installed to the keyboard

# zmk:                  keyboard software
# zephyr-project:       microcontroller OS
# zephyr-sdk:           zephyr dependency
# west:                 version control / build tool, etc
# pipx:                 manages cli python packages
# zmk-nodefree-config:  headers for keymaps
# config/:              directory of custom keymap


SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
MAKEFLAGS += --no-print-directory

# TODO need to pass in venv var to install_zephyr.bash
ZEPHYR_VENV := zephyr
PIPX_BIN := ~/.local/bin/pipx
ZEPHYR_CMAKE := ~/.cmake/packages/Zephyr
ZEPHYR_SDK_CMAKE := ~/.cmake/packages/Zephyr-sdk


BOARD=raytac_mdbt50q_rx_green
SHIELD=slicemk_ergodox_dongle

define log_info
	@echo -e "\e[32mINFO\t$1\e[39m"
endef

.PHONY: uf2
uf2: zmk.uf2

zmk.uf2: $(ROOT_DIR)/config/slicemk_ergodox_dongle.keymap $(ROOT_DIR)/config/slicemk_ergodox_dongle.conf
	source `which virtualenvwrapper.sh` && \
	workon $(ZEPHYR_VENV) && \
	cd $(ROOT_DIR)/zmk/app && \
		west build \
		--pristine \
		-s $(ROOT_DIR)/zmk/app \
		-b $(BOARD) -- \
		-DSHIELD=$(SHIELD) \
		-DZMK_CONFIG=$(ROOT_DIR)/config
	cp $(ROOT_DIR)/zmk/app/build/zephyr/zmk.uf2 $(ROOT_DIR)/


.PHONY: help
help:                 ## usage
	@echo Usage:  make [RECIPE] [OPTIONS]
	@echo ""
	@echo "    compile ZMK firmware"
	@echo ""
	@grep -E '^[a-z_A-Z0-9^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: clean
clean:
	@# TODO move cleaning zmk & sdk to another rule, our primary goal is to build the zmk.uf2
	rm -rf $(ZEPHYR_CMAKE)
	rm -rf $(ZEPHYR_SDK_CMAKE)
	rm -rf $(ROOT_DIR)/zmk.uf2


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
pipx: $(PIPX_BIN)                  ## install pip extension 'pipx'


.PHONY: zephyr
zephyr: $(ZEPHYR_CMAKE)            ## zephyr project


$(ZEPHYR_CMAKE): $(PIPX_BIN)
	$(call log_info,installing $@...)
	@$(ROOT_DIR)/install_zephyr.bash


.PHONY: zephyr_sdk
zephyr_sdk: $(ZEPHYR_SDK_CMAKE)    ## zephyr RTOS SDK


$(ZEPHYR_SDK_CMAKE):
	@$(ROOT_DIR)/install_zephyr_sdk.bash


.PHONY: zmk
zmk: $(ZEPHYR_CMAKE) $(ZEPHYR_SDK_CMAKE)  ## Zephyr Mechanical Keyboard Firmware
	@# NOTE not sure what the best 'target' for this should be,
	@# but west update appears to handle rebuilds so we can keep this as a PHONY target
	@$(ROOT_DIR)/install_zmk.bash

