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
; 09-05-2017 Version 1.2
;
; Add a 6-digit score
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

BCDScore	ds 3	; 3-byte array for score value which will be stored as a
			; BCD encoded 6-digit number

; Pointers for digit graphics
DigitPtr0	ds 2
DigitPtr1	ds 2
DigitPtr2	ds 2
DigitPtr3	ds 2
DigitPtr4	ds 2
DigitPtr5	ds 2

; Temporary variables
Temp		ds 1
TempLoop	ds 1

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

; Prepare the NUSIZx, VDELPx and COLUPx values for the player graphics
    lda #3
    sta NUSIZ0	; 3 copies close
    sta NUSIZ1
    
    lda #1
    sta VDELP0	; bit 0 is still set
    sta VDELP1	; (turn on both player's vertical delays)
    
    lda #$0E	; white
    sta COLUP0
    LDA #$9E
    sta COLUP1
    
; Set player positions for 6-digit score
    sta WSYNC
    SLEEP 25
    sta RESP0
    sta RESP1
    lda #$F0
    sta HMP0
    sta WSYNC
    sta HMOVE
    sta WSYNC
    sta HMCLR

; Prepare gfx pointers for 6-digit score
    SUBROUTINE
    
    ldx #0		; leftmost bitmap pointer
    ldy #2		; start with most-significant BCD value
.Loop
    lda BCDScore,y	; get BCD value
    and #$F0		; isolate high nybble
    lsr			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>DigitGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    lda BCDScore,y	; get BCD value (again)
    and #$0F		; isolate low nybble
    asl
    asl
    asl			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>DigitGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    dey
    bpl .Loop		; next BCD value
    
    SUBROUTINE

; Increment the score
    lda #$99		; we are adding 99
    ldx #0
    ldy #0
    
    sed			; enable BCD mode
    clc
    sta Temp
    lda BCDScore
    adc Temp
    sta BCDScore
    stx Temp
    lda BCDScore+1
    adc Temp
    sta BCDScore+1
    sty Temp
    lda BCDScore+2
    adc Temp
    sta BCDScore+2
    cld		; disable BCD mode

; Loop until the end of vertical blanking
VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
;
; Draw the sections of the kernel zones
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #0
    sta WSYNC
    sta VBLANK	; enable display



    lda #$90
    sta COLUBK
    
    lda #$FF
    sta PF0
    sta CTRLPF
    lda #$80
    sta PF1
    
    ldy #4
KernelLoop1
    sta WSYNC
    
    dey
    bne KernelLoop1
    
    
; 6-digit score display

    SUBROUTINE
    
    SLEEP 35		; start near end of scanline
    lda #7
    sta TempLoop
.Loop
    ldy TempLoop	; count backwards
    lda (DigitPtr0),y	; load B0 (1st sprite byte)
    sta GRP0		; B0 -> [GRP0]
    lda (DigitPtr1),y	; load B1 -> A
    sta GRP1		; B1 -> [GRP1], B0 -> GRP0
    sta WSYNC
    lda (DigitPtr2),y	; load B2 -> A
    sta GRP0		; B2 -> [GRP0], B1 -> GRP1
    lda (DigitPtr5),y	; load B5 -> A
    sta Temp		; B5 -> temp
    lda (DigitPtr4),y	; load B4
    tax			; -> X
    lda (DigitPtr3),y	; load B3 -> A
    ldy Temp		; load B5 -> Y
    sta GRP1		; B3 ->[GRP1], B2 -> GRP0
    stx GRP0		; B4 -> [GRP0], B3 -> GRP1
    sty GRP1		; B5 -> [GRP1], B4 -> GRP0
    sta GRP0		; ?? -> [GRP0], B5 -> GRP1
    
    
    ldy TempLoop
    lda (DigitPtr0),y	; repeat graphics for another scanline
    sta GRP0
    lda (DigitPtr1),y
    sta GRP1
    sta WSYNC
    lda (DigitPtr2),y
    sta GRP0
    lda (DigitPtr5),y
    sta Temp
    lda (DigitPtr4),y
    tax
    lda (DigitPtr3),y
    ldy Temp
    sta GRP1
    stx GRP0
    sty GRP1
    sta GRP0
    
    dec TempLoop
    bpl .Loop		; next line
    
    SUBROUTINE
    
    
    ; y = 0
    lda #0
    sta GRP0
    sta GRP1
    sta GRP0
    sta GRP1
    
    ldy #6
KernelLoop3
    sta WSYNC
    
    dey
    bne KernelLoop3
    
    lda #$00
    sta PF0
    sta PF1

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

    ldy #28
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

    ldy #29+15
FinishFrame
    sta WSYNC
    
    dey
    bne FinishFrame
    
    jmp VerticalSync



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ALIGN $100	; align to page

; Digit graphics for the scoreboard
DigitGfx

    .byte %00011100	; digit 0
    .byte %00110010
    .byte %01100011
    .byte %01100011
    .byte %01100011
    .byte %00100110
    .byte %00011100
    .byte %00000000

    .byte %01111110	; digit 1
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00111000
    .byte %00011000
    .byte %00000000

    .byte %01111111	; digit 2
    .byte %01110000
    .byte %00111100
    .byte %00011110
    .byte %00000111
    .byte %01100011
    .byte %00111110
    .byte %00000000

    .byte %00111110	; digit 3
    .byte %01100011
    .byte %00000011
    .byte %00011110
    .byte %00001100
    .byte %00000110
    .byte %01111111
    .byte %00000000

    .byte %00000110	; digit 4
    .byte %00000110
    .byte %01111111
    .byte %01100110
    .byte %00110110
    .byte %00011110
    .byte %00001110
    .byte %00000000

    .byte %00111110	; digit 5
    .byte %01100011
    .byte %00000011
    .byte %00000011
    .byte %01111110
    .byte %01100000
    .byte %01111110
    .byte %00000000

    .byte %00111110	; digit 6
    .byte %01100011
    .byte %01100011
    .byte %01111110
    .byte %01100000
    .byte %00110000
    .byte %00011110
    .byte %00000000

    .byte %00011000	; digit 7
    .byte %00011000
    .byte %00011000
    .byte %00001100
    .byte %00000110
    .byte %01100011
    .byte %01111111
    .byte %00000000

    .byte %00111110	; digit 8
    .byte %01000011
    .byte %01000011
    .byte %00111100
    .byte %01110010
    .byte %01100010
    .byte %00111100
    .byte %00000000

    .byte %00111100	; digit 9
    .byte %00000110
    .byte %00000011
    .byte %00111111
    .byte %01100011
    .byte %01100011
    .byte %00111110
    .byte %00000000


; Animated graphics for the throbbing lines



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End of Cartridge
;
; Define the end of the cartridge
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ORG $FFFA        ; set address to 6507 Interrupt Vectors 
    .WORD SystemClear ; NMI
    .WORD SystemClear ; RESET
    .WORD SystemClear ; IRQ
