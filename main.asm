; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
;
; Project - Nyan Cat Game
; by Jeremiah Knol
;
; Make a game based off of "Nyan Cat FLY!" on addictinggames.com
; http://www.addictinggames.com/funny-games/nyan-cat-fly-game.jsp
;
;
;
; 09-04-2017 Version 1.1
;
; Test a possible color scheme
;
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; DASM Initialization
;
; Define CPU type and include header files
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    PROCESSOR 6502
    
    incdir ../		; Allows files from the parent directory to be included
    
    include vcs.h
    include macro.h



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80
    
RamStart



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Beginning of Cartridge
;
; Ensure that the code is placed in the proper place in the binary
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG CODE
    ORG $F000	; 4K ROM



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Full System Clear
;
; Clear all system registers and RAM at startup
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

SystemClear:

    CLEAN_START



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
;
; Do the vertical sync and start the vertical blanking timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VerticalSync:

    lda #2
    sta WSYNC
    sta VSYNC	; enable VSYNC
    
    lda #45	; for the VBLANK timer
    sta WSYNC
    sta WSYNC
    sta TIM64T	; start VBLANK timer
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; LOOP UNTIL THE END OF VERTICAL BLANKING
VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
    
    sta WSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
;
; Draw the sections of the kernel zones
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #0
    sta VBLANK	; enable display



    lda #$90
    sta COLUBK
    
    ldy #27
KernelLoop
    sta WSYNC
    
    dey
    bne KernelLoop

    ldx #7
KernelLoopA



    lda #$94
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$9E
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$94
    sta COLUBK
    sta WSYNC
    
    
        
    lda #$90
    sta COLUBK

    ldy #14
KernelLoopC
    sta WSYNC

    dey
    bne KernelLoopC
    
    dex
    bne KernelLoopA



    lda #$94
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$9E
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$94
    sta COLUBK
    sta WSYNC



    lda #$90
    sta COLUBK

    ldy #27
KernelLoopE
    sta WSYNC
    
    dey
    bne KernelLoopE
    
    
    
    lda #2
    sta VBLANK	; disable display



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Waste time to finish the frame
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ldy #29
FinishFrame
    sta WSYNC
    
    dey
    bne FinishFrame
    
    jmp VerticalSync



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End of Cartridge
;
; Define the end of the cartridge
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ORG $FFFA        ; set address to 6507 Interrupt Vectors 
    .WORD SystemClear ; NMI
    .WORD SystemClear ; RESET
    .WORD SystemClear ; IRQ
