; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Scoreboard Display
;
; Draw the 6-digit score and level counter.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE
    
    sta COLUBK		; 06 - A = 0
    sta COLUP0		; 09 - set both colors to black
    
    lda #$FF		; 11
    sta PF0		; 14
    sta GRP0		; 17 - player 0 (black) will cover up...

    lda #$A0		; 19 - ...part of PF1, causing bit 7 of CXP0FB to be set
    sta PF1		; 22 - (player 0 is drawn over PF1 to hide it)
    
    ldy ScoreColor	; 25 - pre-load value to store to GRP0,
    ldx #%00010011	; 27 - and value to store to NUSIZx, CTRLPF, and VDELxx
    
    lda #$80		; 29
    sta PF1		; 33 - fix PF1 register only AFTER collision
    
    stx NUSIZ0		; 35 - X = THREE_CLOSE | BALL_SIZE_2
    stx NUSIZ1		; 38
    stx VDELP0		; 41 - enable vertical delay for player 0...
    stx VDELP1		; 44 - ...and player 1
    stx CTRLPF		; 47 - X = PF_REFLECT | PF_SCORE_MODE | MSL_SIZE_2
    			;      PF_SCORE_MODE isn't needed, but it saves a read
    sty COLUP0		; 50 - fix COLUP0 register
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Pre-load some graphics before the scoreboard kernel loop

    pla			; 54 - pull gfx for digit0
    sta GRP0		; 57 - digit0 -> [GRP0]

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Only draw leading 1 in level counter if the level is 10 or more

    lda BCDLevel	; 60 - the value of bit 4...
    lsr			; 62
    lsr			; 64
    lsr			; 66 - ...gets shifted three times...
    sta ENABL		; 69 - ...to be used to enable or disable the ball
    
    bpl .ScoreEntrance	; 72

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
    lsr			; 58	
    lsr			; 60	
    sta NUSIZ0		; 63 - use bits 2-7 of data (re-aligned) for NUSIZ0

    pla			; 67 - pull gfx for digit0
    sta.w GRP0		; 71 - digit0 -> [GRP0]
.ScoreEntrance
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
    jmp .Trampoline
    
    ALIGN $100
    
.Trampoline
    sta WSYNC
    
    SLEEP 10
