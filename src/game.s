;; assembler config
.setcpu "6502"

.include "ppu.s"
.include "io.s"
.include "header.s"


;; PRG CODE START
.segment "CODE"


    ;; FUNCTION TO HANDLE A RESET INTERRUPT
    .proc reset
        ;; general reset
        sei                 ; set interrupt flag to 1 to disable interrupts (second bit in status register)
        cld                 ; set decimal flag to 0 to disable decimal mode (third bit in status register)
        ldx #$FF            ; 0xFF in X-register
        txs                 ; write X-register in stack-pointer (init stack with 0xFF because stack grows to the ground)
        inx                 ; increment X-register to get  0x00
        stx PPUCTRL         ; store x in PPUCTRL   (set to 0x00)
        
        ;; wait for PPU to warmup
    :   bit PPUSTATUS
        bpl :-
    :   bit PPUSTATUS
        bpl :-
        
        ;; zero ram
        txa
    :   sta $000, x
        sta $100, x
        sta $200, x
        sta $300, x
        sta $400, x
        sta $500, x
        sta $600, x
        sta $700, x
        inx
        bne :-
        
        ;; final wait for PPU to warmup
    :   bit PPUSTATUS
        bpl :-
        call main
    .endproc
    
    
    ;; -------------
    ;; MAIN FUNCTION
    ;; -------------
    .proc main
    :   jmp :-
    .endproc
    
    
    ;; FUNCTION TO HANDLE A NMI INTERRUPT
    .proc nmi
        rti
    .endproc
    

    ;; FUNCTION TO HANDLE A IRQ INTERRUPT
    .proc irq
        rti
    .endproc
    

;; PRG CODE END



;; INTERRUPT HANDLER FUNCTION ADDRESSES START
.segment "VECTOR"
    .addr nmi
    .addr reset
    .addr irq
;; INTERRUPT HANDLER FUNCTION ADDRESSES END
