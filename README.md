# Basic_NES_Cartridge

## General

This project gives you an example of a basic working NES cartridge  
compilable with the cc65 tool chain.  
The NES cartridge is loadable by any NES emulator.

## Build

* ca65 (assembler)
* ld65 (linker)

Just run compile.bat to build the NES cartridge.  
The built cartridge can be checked by check_nes_file.bat.

## Run

Runnable on any NES emulator (e.g. iNES, Jnes, etc.)

## Files

* src/link.x  
linker file for ld65 that puts the code together to an NES cartridge.
* src/game.s  
the whole NES cartridge code.
* src/header.s  
the iNES header required for basic information about the NES cartridge  
e.g. ROM-Capacity of the NES cartridge
