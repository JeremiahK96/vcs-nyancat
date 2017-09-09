; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #0
    sta WSYNC
    sta VBLANK	; enable display

    
    lda #PF_REFLECT | PF_PRIORITY | BALL_SIZE_2
    sta CTRLPF
    
    lda #$FF
    sta PF0
    
    sta GRP0	; This forces a collision between P0 and PF, setting bit-7
    sta GRP1	; in CXP0FB, which will be used to end the scoreboard
    sta PF1	; display kernel loop.
    
    ldy #6
KernelLoop1	; draw border above scoreboard
    sta WSYNC
    
    lda #0
    sta GRP0
    sta GRP1
    
    dey
    bne KernelLoop1
    
    lda #$C0
    sta PF1
    
    lda #COL_SCOREBOARD
    sta COLUBK
    
    sta WSYNC
    
    lda #$80
    sta PF1
    
    sta WSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Scoreboard Display
;
; Draw the 6-digit score and level counter.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE
    
    SLEEP 48
    
    lda BCDLevel
    lsr
    lsr
    lsr
    sta ENABL	; draw ball if bit-4 is set (if level > 9)
    
    jmp .EntrancePoint
    
.Loop

    ; A contains gfx for digit3
    sta GRP0		; 69	digit3 -> [GRP0]	digit2 -> GRP1
    
    ; gfx for the first 3 digits are now pre-loaded into the GRPx registers
    
    pla			; 18	pull gfx for digit4...
    tay			; 20	...and store in Y
    pla			; 24	pull gfx data for digit5...
    tax			; 26	...and store in X
    pla			; 30	pull gfx data for digit6 to A
    
    sty GRP1		; 33	digit4 -> [GRP1]	digit3 -> GRP0
    stx GRP0		; 36	digit5 -> [GRP0]	digit4 -> GRP1
    sta GRP1		; 39	digit6 -> [GRP1]	digit5 -> GRP0
    sta GRP0		; 42	digit6 -> [GRP0]	digit6 -> GRP1
    
    pla			; 73	pull gfx data for level counter
    sta ENAM0		; 00	use bit 1 of data for ENAM0
    rol			; 02	
    sta ENAM1		; 05	use bit 0 of data for ENAM1
    ror			; 07	
    ror			; 09	
    ror			; 11	
    sta NUSIZ0		; 14	use bits 2-7 of data (re-aligned) for NUSIZ0
    
.EntrancePoint

    pla			; 46	pull gfx for digit1
    sta GRP0		; 49	digit1 -> [GRP0]
    
    pla			; 53	pull gfx for digit2
    sta.w GRP1		; 57	digit2 -> [GRP1]	digit1 -> GRP0
    			;	(use an extra cycle for timing reasons)
    
    pla			; 61	pull gfx for digit3
    			
	; On the final iteration of the loop, the stack will have wrapped
	; and pulled from location $02 at this point.
	; This happens to be the collision register CXP0FB.
	; Bit-7 will always be set in this register,
	; and bit-7 is always clear in the score graphics,
	; so checking bit-7 of the data pulled is all that you need
	; to determine when to terminate the loop.
    			
    tax			; 63	set flags according to pulled data
    
    bpl .Loop		; 66	check negative flag to see if the loop is over
    
    lda #0		; disable the players/missiles/ball
    sta GRP0
    sta GRP1
    sta GRP0
    sta GRP1
    sta ENABL
    sta ENAM0
    sta ENAM1
    
    ldx #$FF
    txs			; reset the stack pointer
    
    sta WSYNC
    sta PF1		; disable PF1
    sta WSYNC
    sta PF0		; disable PF0
    
    ldy #8
KernelLoop3	; draw border below scoreboard
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
KernelLoopA	; draw the gameplay display
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC	; draw a row
    sta WSYNC

    dey
    bne KernelLoopC
    
    ; draw a row seperator
    

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
KernelLoopE	; draw bottom of screen
    sta WSYNC
    
    dey
    bne KernelLoopE
    
    
    
    lda #2
    sta VBLANK	; disable display
    
    jmp Overscan
