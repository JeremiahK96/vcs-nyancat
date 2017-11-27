; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Scoreboard Display
;
; Draw the 6-digit score and level counter.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE
    
    lda #PF_REFLECT | PF_PRIORITY | BALL_SIZE_2
    sta CTRLPF
    
    lda #$FF
    sta PF0
    
    sta GRP0	; This forces a collision between P0 and PF, setting bit-7
    sta GRP1	; in CXP0FB, which will be used to end the scoreboard
    sta PF1	; display kernel loop.
    
    ldy #5

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
ScoreTop	; draw border above scoreboard

    sta WSYNC
    
    lda #0
    sta GRP0
    sta GRP1
    
    dey
    bne ScoreTop
    
    lda #$80
    sta PF1
    
    lda #COL_SCOREBOARD
    sta COLUBK
    
    sta WSYNC
    sta WSYNC

    SLEEP 48
    
    lda BCDLevel
    lsr
    lsr
    lsr
    sta ENABL	; draw ball if bit-4 is set (if level > 9)
    
    jmp .EntrancePoint
    
    ALIGN $100

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.ScoreDigitLoop

    ; A contains gfx for digit3
    sta GRP0		; 14	digit3 -> [GRP0]	digit2 -> GRP1
    
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
    
    pla			; 46	pull gfx data for level counter
    sta ENAM0		; 49	use bit 1 of data for ENAM0
    rol			; 51	
    sta ENAM1		; 54	use bit 0 of data for ENAM1
    ror			; 56	
    ror			; 58	
    ror			; 60	
    sta NUSIZ0		; 63	use bits 2-7 of data (re-aligned) for NUSIZ0
    
.EntrancePoint

    pla			; 67	pull gfx for digit1
    sta GRP0		; 70	digit1 -> [GRP0]
    
    pla			; 74	pull gfx for digit2
    sta.w GRP1		; 02	digit2 -> [GRP1]	digit1 -> GRP0
    			;	(use an extra cycle for timing reasons)
    
    pla			; 06	pull gfx for digit3
    			
	; On the final iteration of the loop, the stack will have wrapped
	; and pulled from location $02 at this point.
	; This happens to be the collision register CXP0FB.
	; Bit-7 will always be set in this register,
	; and bit-7 is always clear in the score graphics,
	; so checking bit-7 of the data pulled is all that you need
	; to determine when to terminate the loop.
    			
    tax			; 08	set flags according to pulled data
    
    bpl .ScoreDigitLoop	; 10/11	check negative flag to see if the loop is over
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
    lda #0	; 12
    sta ENAM0	; 15 - disable missiles
    sta ENAM1	; 18
    sta GRP0	; 21 - disable player graphics
    sta GRP1	; 24
    sta VDELP0	; 27 - disable player vertical delays
    sta VDELP1	; 30
    sta ENABL	; 33 - disable ball
    sta CTRLPF	; 36 - disable playfield mirroring
    
    ldx #$FF	; 38
    txs		; 40 - reset the stack pointer
