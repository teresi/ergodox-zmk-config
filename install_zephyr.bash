#!/usr/bin/env bash

# install ZEPHYR, an Real Time OS for embedded systems
#    this is a dependency for ZMK, a firmware for keyboards

# NB
#    depends on virtualenvwrapper
#    creates / activates an env called "zephyr"

# SEE
#    https://docs.zephyrproject.org/3.2.0/introduction/index.html
#    https://docs.zephyrproject.org/3.2.0/develop/getting_started/index.html
#    https://zmk.dev/docs


_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $_ROOT_DIR/helpers.bash

Z_REPO=https://github.com/zephyrproject-rtos/zephyr
Z_SRC="$_ROOT_DIR"/zephyrproject
Z_VENV=zephyr
Z_DEP="git cmake ninja-build gperf ccache dfu-util device-tree-compiler wget python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1"


update_zephyr ()
{
	set -e
	source `which virtualenvwrapper.sh` \
		|| (error "could not source virtualenvwrapper, is virtualenvwrapper.sh in the path?" && false)
	set +e

	lsvirtualenv | grep -q $Z_VENV || (mkvirtualenv -a "$Z_SRC" "$Z_VENV") && true
	workon "$Z_VENV"  # NB `workon` raises errors so do not call under `set -ex`

	if [[ "$VIRTUAL_ENV" == "" ]]
	then
		error "could not activate virtual env $Z_VENV"
		exit 1
	fi

	set -ex
	pip install west

	cd "$( dirname "${Z_SRC}" )"
	if [ ! -d "$Z_SRC" ]; then
		west init -m "$Z_REPO" zephyrproject
	fi

	cd "$Z_SRC"
	west update
	west zephyr-export
	pip install -r "$Z_SRC"/zephyr/scripts/requirements.txt
}


notify "compile zephyr..."

notify "checking dependencies..."
are_packages_missing "$Z_DEP"

notify "updating zephyr project..."
update_zephyr
