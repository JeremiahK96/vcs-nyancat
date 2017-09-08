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
; 09-07-2017 Version 1.4
;
; Clean up and optimize code
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
; TIA Register Value Equates
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; NUSIZx player size and player/missile copies
ONE_COPY		equ	$00
TWO_CLOSE		equ	$01
TWO_MED			equ	$02
THREE_CLOSE		equ	$03
TWO_WIDE		equ	$04
DOUBLE_SIZE		equ	$05
THREE_MED		equ	$06
QUAD_SIZE		equ	$07

; NUSIZx missile size
MSL_SIZE_1		equ	$00
MSL_SIZE_2		equ	$10
MSL_SIZE_4		equ	$20
MSL_SIZE_8		equ	$30

; CTRLPF values
PF_REFLECT		equ	$01
PF_SCORE_MODE		equ	$02
PF_PRIORITY		equ	$04
BALL_SIZE_1		equ	$00
BALL_SIZE_2		equ	$10
BALL_SIZE_4		equ	$20
BALL_SIZE_8		equ	$30

; VDELxx values
VDEL_FALSE		equ	#0
VDEL_TRUE		equ	#1



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Program Equates
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; colors
COL_SCORE		equ $42
COL_SCOREBOARD		equ $9E
COL_BACKGROUND		equ $90



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80
    
RamStart

BCDScore	ds 3	; 3-byte array for score value which will be stored as a
			; BCD encoded 6-digit number and used to control the
			; 6-digit score display

; pointers for digit graphics
DigitPtr0	ds 2
DigitPtr1	ds 2
DigitPtr2	ds 2
DigitPtr3	ds 2
DigitPtr4	ds 2
DigitPtr5	ds 2

BCDLevel	ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

LvlGfxPtr	ds 2	; pointer for LevelGfx table

; temporary variables
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

; Prepare the NUSIZx, VDELPx and COLUPx values for the 6-digit score

    lda #THREE_CLOSE | MSL_SIZE_2
    sta NUSIZ0
    sta NUSIZ1
    
    lda #VDEL_TRUE
    sta VDELP0
    sta VDELP1
    
    lda #COL_SCORE
    sta COLUP0
    sta COLUP1
    sta COLUPF
    sta COLUBK
    
; Set player positions for 6-digit score (extremely inefficiently)
    sta WSYNC
    SLEEP 25
    sta RESP0
    sta RESP1
    lda #$F0
    sta HMP0
    SLEEP 4
    lda #$80
    sta HMBL
    lda #$80
    sta HMM0
    lda #$D0
    sta HMM1
    sta RESBL
    sta RESM0
    sta RESM1
    sta WSYNC
    sta HMOVE
    sta WSYNC
    sta HMCLR
    lda #$B0
    sta HMBL
    sta WSYNC
    sta HMOVE
    sta WSYNC
    sta HMCLR

; Increment the score
    inc TempLoop
    lda TempLoop
    and #%00000111
    bne .SkipScoreInc

    lda #$21		; we are adding 54,321
    ldx #$43
    ldy #$05
    
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
    
    clc
    lda BCDLevel
    adc #1
    sta BCDLevel
    
    cld		; disable BCD mode
.SkipScoreInc

; Prepare gfx pointers for 6-digit score
    SUBROUTINE
    
    ldx #0		; leftmost bitmap pointer
    ldy #2		; start with most-significant BCD value
.Loop
    lda BCDScore,y	; get BCD value
    and #$F0		; isolate high nybble
    lsr			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>ScoreGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    lda BCDScore,y	; get BCD value (again)
    and #$0F		; isolate low nybble
    asl
    asl
    asl			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>ScoreGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    dey
    bpl .Loop		; next BCD value

; Prepare gfx pointer for level counter
    lda BCDLevel
    and #$0F		; isolate right nybble
    asl
    asl
    asl
    clc
    adc #<LevelGfx
    sta LvlGfxPtr	; store low byte
    lda #>LevelGfx
    sta LvlGfxPtr+1	; store high byte

; Load stack with the gfx for the 6-digit score and level counter
    SUBROUTINE
    
    ldy #0
.LoadStack
    lda (DigitPtr3),y
    pha
    lda (DigitPtr4),y
    pha
    lda (DigitPtr5),y
    pha
    lda (LvlGfxPtr),y
    pha
    lda (DigitPtr2),y
    pha
    lda (DigitPtr1),y
    pha
    lda (DigitPtr0),y
    pha
    iny
    cpy #8
    bne .LoadStack
    
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

    
    lda #PF_REFLECT | PF_PRIORITY | BALL_SIZE_2
    sta CTRLPF
    lda #$FF
    sta PF0
    lda #$C0
    sta PF1
    
    ldy #6
KernelLoop1
    sta WSYNC
    
    dey
    bne KernelLoop1
    
    
; Draw ball?
    SUBROUTINE
    
    lda #COL_SCOREBOARD
    sta COLUBK
    
    sta WSYNC
    lda #$80
    sta PF1
    sta WSYNC
    
    lda BCDLevel
    lsr
    lsr
    lsr
    sta ENABL	; draw ball if bit 4 is set (if level > 9)
    
    SLEEP 33

; 6-digit score and level counter display
    SUBROUTINE
.Loop
    pla			; 49 load B0 (1st sprite byte)
    sta GRP0		; 52 B0 -> [GRP0]
    pla			; 56 load B1 -> A
    sta GRP1		; 59 B1 -> [GRP1], B0 -> GRP0
    pla			; 63 load B2 -> A
    sta GRP0		; 66 B2 -> [GRP0], B1 -> GRP1
    
    pla			; 70
    tax			; 72
    lsr			; 74
    lsr			; 76
    hex	8D 04 00	; 04 means "sta NUSIZ0" (NUSIZ0 = $04 in zero page)
    			;    (force absolute addressing to waste 1 extra cycle)
    txa			; 06
    sta ENAM0		; 09
    asl			; 11
    sta ENAM1		; 14
    
    pla			; 18 load B5 -> A
    tay			; 20 B5 -> Y
    pla			; 24 load B4
    tax			; 26 -> X
    pla			; 30 load B3 -> A
    sta GRP1		; 33 B3 ->[GRP1], B2 -> GRP0
    stx GRP0		; 36 B4 -> [GRP0], B3 -> GRP1
    sty GRP1		; 39 B5 -> [GRP1], B4 -> GRP0
    sta GRP0		; 42 ?? -> [GRP0], B5 -> GRP1
    
    bne .Loop		; 45 next line
    
    SUBROUTINE
    
    
    lda #0
    sta GRP0
    sta GRP1
    sta GRP0
    sta GRP1
    sta ENABL
    sta ENAM0
    sta ENAM1
    
    sta WSYNC
    sta PF1
    sta WSYNC
    sta PF0
    
    ldy #8
KernelLoop3
    sta WSYNC
    
    dey
    bne KernelLoop3
    
    lda #$00
    sta PF0
    sta PF1



    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$94
    sta COLUBK
    sta WSYNC
    
    

    ldx #7
KernelLoopA
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC
    sta WSYNC

    dey
    bne KernelLoopC
    

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


    dex
    bne KernelLoopA


    lda #COL_BACKGROUND
    sta COLUBK

    ldy #31
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
; Graphics Tables
;
; All the data in these tables is upside-down,
; i.e. the last byte in each section is the first byte of information
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ALIGN $100	; align to page

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Digit graphics for the scoreboard
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

ScoreGfx

    .byte %00000000
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

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Nusiz data for level counter graphics
;
; This table controls the leftmost missile's width in the level counter
; line-by-line. The rightmost missile's width is not changed.
; In each byte, the right nybble controls the number of player copies,
; and the left nybble controls the width of the missile.
; The right nybble is always $3 to keep the score graphics correct.
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

LevelGfx

	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 0
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 1
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 2
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 3
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 4
    .byte %01001101
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 5
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 6
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 7
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 8
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 9
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Enam0 and Enam1 data for level counter graphics
;
; This table enables or disables each missile in the level counter line-by-line.
; Only bits 1 and 0 are used.
; Bit 1 is used for the leftmost missile,
; and bit 0 is used for the rightmost missile.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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
