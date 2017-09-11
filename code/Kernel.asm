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
    
    ldy #5
KernelLoop1	; draw border above scoreboard
    sta WSYNC
    
    lda #0
    sta GRP0
    sta GRP1
    
    dey
    bne KernelLoop1
    
    lda #$80
    sta PF1
    
    lda #COL_SCOREBOARD
    sta COLUBK
    
    sta WSYNC
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
    sta WSYNC
    sta WSYNC
    
    lda #COL_SCOREBOARD; - 4
    sta COLUBK
    lda #COL_SCORE
    sta COLUPF
    sta WSYNC
    lda #COL_SCOREBOARD + 2; - 8
    sta COLUBK
    lda #COL_SCORE + 2
    sta COLUPF
    sta WSYNC
    
    lda #$00
    sta PF0
    sta PF1
    
    

    ldx #6
KernelLoopA	; draw the gameplay display
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC	; draw a row
    sta WSYNC

    dey
    bne KernelLoopC
    
    ; draw a row seperator
    

    ldy ThrobFrame
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+2,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC


    dex
    bne KernelLoopA


    lda #COL_BACKGROUND
    sta COLUBK
    
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    
    lda #COL_SCORE
    sta COLUBK
    lda #COL_CAT_FACE
    sta COLUPF
    lda #BALL_SIZE_4
    sta CTRLPF
    
    sta WSYNC
    
    lda VDEL_FALSE
    sta VDELP0
    sta VDELP1
    
    SLEEP 44
    
    lda #$20
    sta HMP0
    lda #$B0
    sta HMP1
    
    sta RESP0
    sta RESP1
    
    sta WSYNC
    SLEEP 71
    sta HMOVE
    
    lda #$00
    sta COLUP0
    sta COLUP1
    
    lda #DOUBLE_SIZE
    sta NUSIZ0
    sta NUSIZ1

    lda #REFP_TRUE
    sta REFP1
    
    SUBROUTINE
    
    ldy #4
HealthTop	; draw top of health
    ldx #3
.Loop
    lda HealthTopGfx,y
    sta GRP0
    sta GRP1
    lda #$00
    sta PF2
    SLEEP 20
    lda HealthBgGfx+8,y
    sta PF2
    sta WSYNC
    
    dex
    bne .Loop
    
    dey
    bpl HealthTop
    
    SUBROUTINE
    
    ldy #7
HealthBottom	; draw bottom of health
    ldx #3
.Loop
    lda HealthLeftGfx,y
    sta GRP0
    lda HealthRightGfx,y
    sta GRP1
    lda #$00
    sta PF2
    SLEEP 16
    lda HealthBgGfx,y
    sta PF2
    sta WSYNC
    
    dex
    bne .Loop
    
    dey
    bpl HealthBottom

    
    lda #$00
    sta GRP0
    sta GRP1
    sta REFP0
    sta REFP1
    sta PF2
    
    sta WSYNC
    sta WSYNC
    
    
    
    lda #2
    sta VBLANK	; disable display
    
    jmp Overscan
