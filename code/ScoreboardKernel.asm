; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Scoreboard Display
;
; Draw the 6-digit score and level counter.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE
    
    sta COLUBK		; 06 - A contains 0
    sta COLUP0		; 09
    
    lda #$FF		; 11
    sta PF0		; 14
    sta GRP0		; 17
    
    lda #$A0		; 19
    sta PF1		; 22
    
    ldy ScoreColor
    ldx #%00010011	; 24
    stx NUSIZ1		; 34
    
    lda #$80		; 28
    sta PF1		; 31
    
    stx CTRLPF		; 37
    stx NUSIZ0		; 40
    stx VDELP0		; 43
    stx VDELP1		; 46
    sty COLUP0		; 49
    
    pla			; 53 - pull gfx for digit0
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
    sta.w GRP0		; 71 - digit0 -> [GRP0]
.EntrancePoint
    pla			; 74 - pull gfx for digit1
    sta GRP1		; 02 - digit1 -> [GRP1]	digit0 -> GRP0
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

    lda #0
    sta GRP0
    sta GRP1
    sta VDELP1
    sta VDELP0
    sta ENABL
    sta ENAM0
    sta ENAM1

    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    
    lda ScoreColor
    sta COLUBK
    
    sta WSYNC
    sta WSYNC
    
    SLEEP 10
