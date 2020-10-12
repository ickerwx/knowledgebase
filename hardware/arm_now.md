# Using arm_now

[Run a simple ARM VM in qemu](https://github.com/nongiach/arm_now)

From the README.md:

## Install

```sh
# pip3 install https://github.com/nongiach/arm_now/archive/master.zip --upgrade
```

## Usage

```cheat arm_now Start a VM
$ arm_now start armv5-eabi
```

```cheat arm_now Start a clean VM and sync the current dir with the VM home
$ arm_now start armv5-eabi --sync --clear
```

```cheat arm_now Resize VM
$ arm_now resize +10G
```

```cheat arm_now Start a MIPS VM
$ arm_now start mips32el
```

```cheat arm_now Exit VM/qemu
press "Ctrl+]"
```

tags: #hardware #links #reversing #arm #qemu 
