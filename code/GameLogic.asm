; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:

    lda #OVERSCAN_TIMER
    sta WSYNC
    sta TIM64T
    
; Set object positions for scoreboard kernel (extremely inefficiently)
    sta WSYNC
    lda #$B0
    sta HMP0
    lda #$C0
    sta HMP1
    SLEEP 14
    sta RESP0
    sta RESP1
    SLEEP 11
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
    
    
    
    inc Frame		; increment the frame number
    
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
    sta ScoreColor
    lda #$56
    sta PgBarColor
    
    

; Increment the score
    lda Frame
    and #%00000111
    bne .SkipScoreInc

    lda #$21		; we are adding 21
    ldx #$00
    ldy #$00
    
    sed			; enable BCD mode
    clc
    sta Temp
    lda BCDScore+2
    adc Temp
    sta BCDScore+2
    stx Temp
    lda BCDScore+1
    adc Temp
    sta BCDScore+1
    sty Temp
    lda BCDScore+0
    adc Temp
    sta BCDScore+0
    
    clc
    lda BCDLevel
    adc #1
    sta BCDLevel
    
    cld		; disable BCD mode
.SkipScoreInc

; Set playfield graphics in RAM for the progress bar
    SUBROUTINE
    
    lda Frame
    lsr
    sec
    sbc #7
    bpl .Skip
    lda #120
.Skip
    sta Progress
    
    lda #%11100000	; reset all progress bar playfield graphics RAM
    sta ProgressBar+0
    lda #%11111111
    sta ProgressBar+1
    sta ProgressBar+2
    sta ProgressBar+3
    lda #%11111110
    sta ProgressBar+4
    
    lda Progress	; get the amount of progress (color clock range 0-120)
    lsr
    lsr			; divide by 4 (playfield range 0-30)
    
    ; The level progress bar uses the following playfield bits:
    ; (note that PF0 and PF2 are NOT reversed in this diagram)
    ;
    ; *PF0*  *PF1*    *PF2*  *PF0*  *PF1*
    ; ^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^ ^^^^^^^^	X = bit used
    ; oXXX XXXXXXXX XXXXXXXX XXXX XXXXXXXo	o = bit not used
    ;
    ; When the progress bar is empty, every bit labeled "X" above should be
    ; set (1), and when it is full, every "X" bit should be cleared (0).
    ; The bits labeled "o" must ALWAYS be cleared.
    ;
    ; The leftmost playfield value (the 1st PF0) will be calculated first,
    ; and then each playfield value to the right until the 2nd PF1
    ; will be calculated.
    
    ldy #%00000000	; value to store when a playfield byte is full
    
    sec
    sbc #3		; 3 PF bits in 1st PF0 are used, so subtract 3
    bmi .Underflow1
    sty ProgressBar	; this playfield byte is full
    
    sbc #8		; 8 PF bits in 1st PF1 are used, so subtract 8
    bmi .Underflow2
    sty ProgressBar+1	; this playfield byte is full
    
    sbc #8		; 8 PF bits in PF2 are used, so subtract 8
    bmi .Underflow3
    sty ProgressBar+2	; this playfield byte is full
    
    sbc #4		; 4 PF bits in 2nd PF1 are used, so subtract 4
    bmi .Underflow4
    sty ProgressBar+3	; this playfield byte is full
    
    tax
    lda PgBarGfx+1,x	; load from normal set of playfield graphics
    asl
    sta ProgressBar+4
    jmp .Finish
    
.Underflow1	; for 1st PF0
    adc #3	; add back the 3
    tax
    lda PgBarGfxR+5,x	; load from reversed set of playfield graphics
    sta ProgressBar
    jmp .Finish
    
.Underflow2	; for 1st PF1
    adc #8		; add back the 8
    tax
    lda PgBarGfx,x	; load from normal set of playfield graphics
    sta ProgressBar+1
    jmp .Finish
    
.Underflow3	; for PF2
    adc #8		; add back the 8
    tax
    lda PgBarGfxR,x	; load from reversed set of playfield graphics
    sta ProgressBar+2
    jmp .Finish
    
.Underflow4	; for 2nd PF0
    adc #4		; add back the 4
    tax
    lda PgBarGfxR+4,x	; load from reversed set of playfield graphics
    sta ProgressBar+3

.Finish

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare Health Display
;
; Set the pointers for the health graphics
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda Frame
    and #%11000000
    lsr
    lsr
    lsr
    sta Temp
    
    clc
    
    lda #<HealthLeftGfx
    adc Temp
    sta HthGfxLPtr
    lda #>HealthLeftGfx
    sta HthGfxLPtr+1
    
    lda #<HealthRightGfx
    adc Temp
    sta HthGfxRPtr
    lda #>HealthRightGfx
    sta HthGfxRPtr+1



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
    lda INTIM
    bne OverscanTimerLoop


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
;
; Do the vertical sync and start the vertical blanking timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #2
    sta WSYNC
    sta VSYNC	; enable VSYNC
    
    sta WSYNC
    lda #VBLANK_TIMER
    sta WSYNC
    sta TIM64T	; start VBLANK timer
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare for Throbbing Lines
;
; Set the offset value for the throbbing line graphics
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda Frame		; get the current frame number
    and #%00011100	; change animation frame every 4 game frames
    lsr
    lsr			; shift to get a frame value from 0-7
    sta Temp
    adc Temp		; carry flag will always be clear
    adc Temp		; multiply by 3
    sta ThrobFrame	; store the gfx offset



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE

    lda #6		; start with bottom of digit graphics data
    sta TempLoop

.Loop

; push level counter graphics data
    lda BCDLevel	; get level counter
    and #$0F		; isolate left nybble/digit
    asl
    asl
    asl			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda LevelGfx,y
    pha
    
    ldx #2		; start with rightmost BCD score value
    			; (we must push to stack in reverse of drawing order)
.DigitLoop

; right nybble
    lda BCDScore,x	; get current BCD value (contains 2 digits)
    and #$0F		; isolate right nybble/digit
    asl
    asl
    asl			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda ScoreGfx,y
    pha
    
; left nybble
    lda BCDScore,x	; get current BCD value (contains 2 digits)
    and #$F0		; isolate left nybble/digit
    lsr			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda ScoreGfx,y
    pha

    dex
    bpl .DigitLoop
    
    dec TempLoop
    bpl .Loop



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
