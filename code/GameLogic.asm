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
; Update Score
;
; Add to the score
;
; Takes 45 cycles to complete
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda BCDScoreAdd+1	; 2
    ldx BCDScoreAdd	; 2
    
    sed			; 2 - enable BCD mode
    
    clc			; 2
    sta Temp		; 3
    lda BCDScore+2	; 2
    adc Temp		; 3
    sta BCDScore+2	; 3
    stx Temp		; 3
    lda BCDScore+1	; 2
    adc Temp		; 3
    sta BCDScore+1	; 3
    lda #$00		; 2
    sta Temp		; 3
    lda BCDScore+0	; 2
    adc Temp		; 3
    sta BCDScore+0	; 3
    
    cld			; 2 - disable BCD mode



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
    
    sta HMCLR	; clear any HMOVE offsets
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare Scoreboard and Level Progress Displays
;
; Set object positions for scoreboard kernel.
; Also load the values for the playfield registers in RAM
; for drawing the level progress bar.
;
; Takes 193 cycles (2 full scanlines + 41 cycles)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #$B0	; 05 - set HMOVE offsets for both player objects
    sta HMP0	; 08
    lda #$C0	; 10
    sta HMP1	; 13
    lda #$80	; 15 - set HMOVE offsets for ball and missile0
    sta HMBL	; 18
    sta HMM0	; 21
    
    SLEEP 3	; 24
    
    sta RESP0	; 27 - set player positions
    sta RESP1	; 30
    
    lda #$D0	; 32 - set HMOVE offset for missile1
    sta HMM1	; 35

; reset all progress bar playfield graphics RAM (and use 21 cycles)
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
    
; Load RAM for progress bar display (takes 28-53 cycles)
    lda Progress	; 3 - get amount of progress
    
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
    
    sta HMCLR	; 56
    lda #$B0	; 58 - another HMOVE is neccesary for the ball
    sta HMBL	; 61
    inc Frame	; 66 increment the frame number
    
    sta WSYNC
    sta HMOVE

; Prepare the NUSIZx, VDELPx and COLUPx values for the 6-digit score
    lda #THREE_CLOSE | MSL_SIZE_2	; 2
    sta NUSIZ0		; 3
    sta NUSIZ1		; 3
    
    lda #VDEL_TRUE	; 2
    sta VDELP0		; 3
    sta VDELP1		; 3
    
    lda #COL_SCORE	; 2
    sta COLUP0		; 3
    sta COLUP1		; 3
    sta COLUPF		; 3
    sta COLUBK		; 3
    sta ScoreColor	; 3
    lda #$56		; 2
    sta PgBarColor	; 3



    lda #$00
    sta BCDScoreAdd
    lda #$00
    sta BCDScoreAdd+1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare Health Display
;
; Set the pointers for the health graphics
;
; Takes 28 cycles to complete
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
    clc			; 2

    lda #<HealthLeftGfx	; 2
    adc Health		; 3
    sta HthGfxLPtr	; 3
    lda #>HealthLeftGfx	; 2
    sta HthGfxLPtr+1	; 3
    
    lda #<HealthRightGfx; 2
    adc Health		; 3
    sta HthGfxRPtr	; 3
    lda #>HealthRightGfx; 2
    sta HthGfxRPtr+1	; 3



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
