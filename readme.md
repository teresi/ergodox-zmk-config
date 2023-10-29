# ERGODOX / ZMK CONFIG

Builds firmware for a [ErgoDox Wireless](https://www.slicemk.com/pages/ergodox-wireless) keyboard.

Fork of https://github.com/teresi/ergodox-zmk-config


## USAGE


```
make zmk    # the compiler
make uf2    # the firmware
```

## DESIGN

- contains my keymap, at `./config`
- contains fork of ZMK from SliceMK, via a submodule (needed for the MCU on that keyboard)
- contains ZMK, via `west`
- contains [Zephyr](https://github.com/zephyrproject-rtos/zephyr), via `west`
- contains [zmk-nodefree-config](https://github.com/urob/zmk-nodefree-config), via submodule, convenience macros for the keymap
- installs Zephyr SDK to ~/zephyr-sdk-*


## UPDATES

- (todo) scripts for compiling
- (todo) merge slicemk's fork w/ upstream in order to use urob's homerow mods
- (todo) upload the left/right firmware (see [slicemk peripherals](https://www.slicemk.com/pages/ergodox-wireless-peripheral).)
- (todo) add copy of instructions
- (todo) handle different board / shield options?
- (todo) remove extraneous files
- (todo) checkout zephyr, zmk, to specific branch using west
