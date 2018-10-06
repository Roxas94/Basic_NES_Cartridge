ca65 -l game.lst src/game.s -o game.o
ld65 -C src/link.x game.o -o game.nes