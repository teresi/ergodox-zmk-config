#!/usr/bin/env bash

# install ZEPHYR SDK, an Real Time OS for embedded systems
#    this is a dependency for ZMK, a firmware for keyboards

# SEE
#    https://docs.zephyrproject.org/3.2.0/introduction/index.html
#    https://docs.zephyrproject.org/3.2.0/develop/getting_started/index.html
#    https://zmk.dev/docs


_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $_ROOT_DIR/helpers.bash

SDK_URL=https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.0/zephyr-sdk-0.15.0_linux-x86_64.tar.gz
SDK_SHA=https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.15.0/sha256.sum
SDK_FILE=zephyr-sdk-0.15.0_linux-x86_64.tar.gz
SDK=zephyr-sdk-0.15.0


# TODO consider installing to `~/.local` instead of `~`?
install_sdk ()
{
	cd ~
	wget -c $SDK_URL
	wget -O - $SDK_SHA | shasum --check --ignore-missing
	tar xvf $SDK_FILE
	cd $SDK
	./setup.sh
	set -ex
	sudo cp ~/$SDK/sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d
	sudo udevadm control --reload
	set +ex
	rm ~/$SDK_FILE
}


notify "installing ZEPHYR SDK..."
install_sdk

