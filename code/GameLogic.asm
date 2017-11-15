; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:

    lda #OVERSCAN_TIMER
    sta WSYNC
    sta TIM64T	; 03
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare for Scoreboard and Level Progress
;
; Set object positions for scoreboard kernel.
; Also load the values for the playfield registers in RAM
; for drawing the level progress bar.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #$B0	; 05 - set HMOVE offsets for both player objects
    sta HMP0	; 08
    lda #$C0	; 10
    sta HMP1	; 13
    lda #$80	; 15 - set HMOVE offsets for ball and missile0
    sta HMBL	; 18
    sta HMM0	; 21
    
    SLEEP 2	; 24
    
    sta RESP0	; 27 - set player positions
    sta RESP1	; 30
    
    lda #$D0	; 32 - set HMOVE offset for missile1
    sta HMM1	; 35
    
; Use up 21 cycles

    ; reset all progress bar playfield graphics RAM
    
    lda #%11100000	; 37
    sta ProgressBar+0	; 40
    lda #%11111111	; 42
    sta ProgressBar+1	; 45
    sta ProgressBar+2	; 48
    sta ProgressBar+3	; 51
    lda #%11111110	; 53
    sta ProgressBar+4	; 56
    
    sta RESBL	; 59 - set ball and missile positions
    sta RESM0	; 62
    sta RESM1	; 65
    
    sta WSYNC
    sta HMOVE
    
; Load RAM for progress bar display (takes 32-57 cycles)
    lda Progress	; 3 - get amount of progress (color clock range 0-120)
    lsr			; 2
    lsr			; 2 - divide by 4 (playfield range 0-30)
    
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
    
    ldy #%00000000	; 2 - value to store when a playfield byte is full
    
    sec			; 2
    sbc #3		; 3 - 3 PF bits in 1st PF0 are used, so subtract 3
    bmi .Underflow1	; 2/3
    sty ProgressBar	; 3 - this playfield byte is full
    
    sbc #8		; 3 - 8 PF bits in 1st PF1 are used, so subtract 8
    bmi .Underflow2	; 2/3
    sty ProgressBar+1	; 3 - this playfield byte is full
    
    sbc #8		; 3 - 8 PF bits in PF2 are used, so subtract 8
    bmi .Underflow3	; 2/3
    sty ProgressBar+2	; 3 - this playfield byte is full
    
    sbc #4		; 3 - 4 PF bits in 2nd PF1 are used, so subtract 4
    bmi .Underflow4	; 2/3
    sty ProgressBar+3	; 3 - this playfield byte is full
    
    tax			; 2
    lda PgBarGfx+1,x	; 4 - load from normal set of playfield graphics
    asl			; 2
    sta ProgressBar+4	; 3
    jmp .Finish		; 3
    
.Underflow1	; for 1st PF0
    adc #3		; 3 - add back the 3
    tax			; 2
    lda PgBarGfxR+5,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar	; 3
    jmp .Finish		; 3
    
.Underflow2	; for 1st PF1
    adc #8		; 3 - add back the 8
    tax			; 2
    lda PgBarGfx,x	; 4 - load from normal set of playfield graphics
    sta ProgressBar+1	; 3
    jmp .Finish		; 3
    
.Underflow3	; for PF2
    adc #8		; 3 - add back the 8
    tax			; 2
    lda PgBarGfxR,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar+2	; 3
    jmp .Finish		; 3
    
.Underflow4	; for 2nd PF0
    adc #4		; 3 - add back the 4
    tax			; 2
    lda PgBarGfxR+4,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar+3	; 3
.Finish


    
    sta HMCLR	; 60
    lda #$B0	; 62 - another HMOVE is neccesary for the ball
    sta HMBL	; 65
    
    sta WSYNC
    sta HMOVE
    
    
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
    
    
    
    sta HMCLR



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
;
; Takes 20 cycles to complete
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda Frame		; 3 - get the current frame number
    and #%00011100	; 2 - change animation frame every 4 game frames
    lsr			; 2
    lsr			; 2 - shift to get a value from 0-7
    sta Temp		; 3
    asl			; 2 - carry flag will always be clear after this
    adc Temp		; 3 - multiply by 3
    sta ThrobFrame	; 3 - store the gfx offset



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
;
; Takes 1245 cycles to complete (16 full scanlines + 29 cycles)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE

    lda #6		; 2 - start with bottom of digit graphics data
    sta TempLoop	; 3

.Loop

; push level counter graphics data
    lda BCDLevel	; 3 - get level counter
    and #$0F		; 2 - isolate left nybble/digit
    asl			; 2
    asl			; 2
    asl			; 2 - digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop	; 3 - add offset for current loop iteration
    tay			; 2
    lda LevelGfx,y	; 4
    pha			; 3
    
    ldx #2		; 2 - start with rightmost BCD score value
    			; (we must push to stack in reverse of drawing order)
.DigitLoop

; right nybble
    lda BCDScore,x	; 4 - get current BCD value (contains 2 digits)
    and #$0F		; 2 - isolate right nybble/digit
    asl			; 2
    asl			; 2
    asl			; 2 - digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop	; 3 - add offset for current loop iteration
    tay			; 2
    lda ScoreGfx,y	; 4
    pha			; 3
    
; left nybble
    lda BCDScore,x	; 4 - get current BCD value (contains 2 digits)
    and #$F0		; 2 - isolate left nybble/digit
    lsr			; 2 - digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop	; 3 - add offset for current loop iteration
    tay			; 2
    lda ScoreGfx,y	; 4
    pha			; 3

    dex			; 2
    bpl .DigitLoop	; 2/3
    
    dec TempLoop	; 5
    bpl .Loop		; 2/3



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
