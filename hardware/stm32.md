# Notes on working with the STM32 discovery board

## Memory Map

All memory regions are defined in the file `stm32f407xx.h`. If using PlatformIO, this file is under `$HOME/.platformio/packages/framework-stm32cube/f4/Drivers/CMSIS/Device/ST/STM32F4xx/Include/stm32f407xx.h`. This file contains a group called `Peripheral_memory_map` (starting at line 923), where the base addresses and all offsets for the `stm32f407` are defined.

## Startup Files
The assembly dealing with CPU startup is `startup_stm32f407xx.s` in `$HOME/.platformio/packages/framework-stm32cube/f4/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/arm/startup_stm32f407xx.s`

## Processor States

The CPU has a special register, the `CONTROL` register. Only the last three bits are used:
 - [2] FPCA: is floating point context active? 0 no, 1 yes
 - [1] SPSEL: stack pointer select, 0 MSP, 1 PSP
 - [0] nPRIV: privilege level: 0 privileged, 1 unprivileged

tags: #hardware #stm32 #rene 
