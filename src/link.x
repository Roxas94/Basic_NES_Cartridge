#
# general memory map of a NES (Nintendo Entertainment System)
# -----------------------------------------------------------
# 
# (the one with the (x) are NOT important!)
#
# $0000 - $07FF = 2KB (0x8000=2048) of internal RAM (^^)
# $0800 - $1FFF = 3x System Memory Mirror						(x)
# $2000 - $2007 = PPU registers	(Picture Proc Unit)
# $2008 - $3FFF = PPU register mirrors (repeats every 8 bytes)	(x)
# $4000 - $4017 = APU and IO registers (Audio Proc Unit)
# $4018 - $401F = APU and IO disabled functionality				(x)
# $4020 - $FFFF = Cartridge space (PRG ROM, PRG RAM, mapper registers ...)
# 					$FFFA-$FFFB = NMI vector
#					$FFFC-$FFFD = Reset vector
#					$FFFE-$FFFF = IRQ/BRK vector
#
MEMORY {

	######################
	#    SYSTEM RAM      #
	######################
	
	# Zero-Page addressing memory with LDA, STA, etc.
    ZP:     start = $0000, 
			size  = $00FF,
			type  = rw; 
	
	# Useable RAM
    RAM:    start = $0100, 
			size  = $06FF, 
			type  = rw;
	
	########################
	#  NROM-128 CARTRIDGE  #
	########################
	
	# file = %0 means that this has to be in the file from -o ...
	# fill = yes means that the remaining area has to be filled with zeros

	# iNES Header (16 Bytes)
    HEADER: start = $0000,
			size  = $0010, 
			type  = ro,
            file  = %O;
			
	# PRG ROM bank	(16 KB for program code)
    PRG0:   start = $8000, 
			size  = $4000, 	# 16 KB, SO END IS 0x800 + 0x4000 = BFFF
			type  = ro,
            file  = %O, 
			fill  = yes;
	
	# CHR ROM bank	(8 KB for graphics)
	CHR0: 	start = $0000,
			size  = $2000,	# 8 KB
			type  = ro,
			file  = %O,
			fill  = yes;
}

#
# segments in the assembler code
# ------------------------------
#
SEGMENTS {
	
	######################
	#    SYSTEM RAM      #
	######################
	
    ZEROPAGE: load = ZP,     type = zp;
    BSS:      load = RAM,    type = bss;
	
	########################
	#  NROM-128 CARTRIDGE  #
	########################

    INES:     load = HEADER, type = ro;
    CODE:     load = PRG0,   type = ro;
    VECTOR:   load = PRG0,   type = ro,  start = $BFFA; # END OF PRG ROM
}






