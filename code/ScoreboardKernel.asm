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
    
    ldy #4

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

    ;sleep38
    jsr Sleep12
    jsr Sleep12
    jsr Sleep12
    SLEEP 2
    
    lda #$01
    sta BCDScoreAdd+1

    lda #$14
    sta BCDLevel
    
    pla			; pull gfx for digit0
    sta GRP0		; digit0 -> [GRP0]
    
; draw ball if level > 9

    lda BCDLevel
    lsr
    lsr
    lsr
    sta ENABL
    
    jmp .EntrancePoint
    
    ALIGN $100

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.ScoreDigitLoop

    ; A contains gfx for digit3
    sta GRP0		; 14	digit2 -> [GRP0]	digit1 -> GRP1
    
    ; gfx for the first 3 digits are now pre-loaded into the GRPx registers
    
    pla			; 18 - pull gfx for digit3...
    tay			; 20 - ...and store in Y
    pla			; 24 - pull gfx data for digit4...
    tax			; 26 - ...and store in X
    pla			; 30 - pull gfx data for digit5 to A
    
    sty GRP1		; 33 - digit3 -> [GRP1]	digit2 -> GRP0
    stx GRP0		; 36 - digit4 -> [GRP0]	digit3 -> GRP1
    sta GRP1		; 39 - digit5 -> [GRP1]	digit4 -> GRP0
    sta GRP0		; 42 - digit5 -> [GRP0]	digit5 -> GRP1
    
    pla			; 46 - pull gfx data for level counter
    sta ENAM0		; 49 - use bit 1 of data for ENAM0
    rol			; 51	
    sta ENAM1		; 54 - use bit 0 of data for ENAM1
    ror			; 56	
    ror			; 58	
    ror			; 60	
    sta NUSIZ0		; 63 - use bits 2-7 of data (re-aligned) for NUSIZ0

    pla			; 67 - pull gfx for digit0
    sta GRP0		; 70 - digit0 -> [GRP0]
.EntrancePoint
    pla			; 74 - pull gfx for digit1
    sta.w GRP1		; 02 - digit1 -> [GRP1]	digit0 -> GRP0
    			;      (use an extra cycle for timing reasons)
    
    pla			; 06 - pull gfx for digit2
    			
	; On the final iteration of the loop, the stack will have wrapped
	; and pulled from location $02 at this point.
	; This happens to be the collision register CXP0FB.
	; Bit-7 will always be set in this register,
	; and bit-7 is always clear in the score graphics,
	; so checking bit-7 of the data pulled is all that you need
	; to determine when to terminate the loop.
    			
    tax			; 08 - set flags according to pulled data
    
    bpl .ScoreDigitLoop	; 10/11 - check negative flag to see if the loop is over
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
