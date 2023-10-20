#!/usr/bin/make -f

# compile the firmware


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

zmk.uf2:
	source `which virtualenvwrapper.sh` && \
	workon $(ZEPHYR_VENV) && \
	ZCONFIG=$(ROOT_DIR)/ergodox-zmk-config/config \
	Z_APP=$(ROOT_DIR)/zmk/app \
	west build \
		-s $(ROOT_DIR)/zmk/app \
		-b $(BOARD) -- \
		-DSHIELD=$(SHIELD) \
		-DZMK_CONFIG=$(ROOT_DIR)/ergodox-zmk-config/config

.PHONY: help
help:                 ## usage
	@echo Usage:  make [RECIPE] [OPTIONS]
	@echo ""
	@echo "    compile ZMK firmware"
	@echo ""
	@grep -E '^[a-z_A-Z0-9^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: clean
clean:
	rm -rf $(ZEPHYR_CMAKE)
	rm -rf $(ZEPHYR_SDK_CMAKE)


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
zmk: $(ZEPHYR_CMAKE) $(ZEPHYR_SDK_CMAKE)  # Zephyr Mechanical Keyboard Firmware
	@# NOTE not sure what the best 'target' for this should be,
	@# but west update appears to handle rebuilds so we can keep this as a PHONY target
	@$(ROOT_DIR)/install_zmk.bash

