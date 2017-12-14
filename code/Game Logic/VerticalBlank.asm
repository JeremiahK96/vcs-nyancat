; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare for Scoreboard and Level Progress Displays
;
; Takes 193 cycles (2 full scanlines + 41 cycles)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #$E0	; 05 - set HMOVE offsets for the scoreboard kernel
    sta HMP0	; 08
    sta HMM0	; 14
    lda #$F0	; 16
    sta HMP1	; 19
    sta HMBL
    
    SLEEP 6	; 26
    
    sta RESP0	; 29 - set player positions
    sta RESP1	; 32
    
    SLEEP 7	; 38

    lda #%11100000	; 38 - reset byte 0 for the progress bar
    sta ProgressBar+0	; 41
    lda #%11111111	; 21 - reset byte 1 for the progress bar
    sta ProgressBar+1	; 24
    sta ProgressBar+2	; 33 - reset bytes 2-3 for the progress bar
    sta ProgressBar+3	; 36
    lda #%11111110	; 43 - reset byte 4 for the progress bar
    sta ProgressBar+4	; 46
    
    SLEEP 2	; 62
    
    sta RESM0	; 65
    
    sta WSYNC
    
    SLEEP 60
    sta RESBL
    sta RESM1
    
    sta WSYNC
    sta HMOVE

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>    
; Load RAM for progress bar display (28-53 cycles)

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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow1	; for 1st PF0

    adc #3		; 3 - add back the 3
    tax			; 2
    lda PgBarGfxR+5,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar	; 3
    jmp .Finish		; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow2	; for 1st PF1

    adc #8		; 3 - add back the 8
    tax			; 2
    lda PgBarGfx,x	; 4 - load from normal set of playfield graphics
    sta ProgressBar+1	; 3
    jmp .Finish		; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow3	; for PF2

    adc #8		; 3 - add back the 8
    tax			; 2
    lda PgBarGfxR,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar+2	; 3
    jmp .Finish		; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow4	; for 2nd PF0

    adc #4		; 3 - add back the 4
    tax			; 2
    lda PgBarGfxR+4,x	; 4 - load from reversed set of playfield graphics
    sta ProgressBar+3	; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Finish
    
    inc Frame	; 66 increment the frame number
    
    sta WSYNC
    sta HMCLR

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare the NUSIZx, VDELPx and COLUPx values for the 6-digit score
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #$10
    sta BCDLevel

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



    lda #0
    sta BCDScoreAdd
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
    tay
    lda LineThrobGfx+0,y
    sta ThrobColor+0
    lda LineThrobGfx+1,y
    sta ThrobColor+1
    lda LineThrobGfx+2,y
    sta ThrobColor+2
    
    
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #>FoodGfx
    sta FoodGfxPtr1+1
    sta FoodGfxPtr2+1
    
    lda #<CatTartGfx
    sta TartGfxPtr
    lda #>CatTartGfx
    sta TartGfxPtr+1
    
    lda #$10
    sta FoodItemL+0
    lda #$70
    sta FoodItemR+0
    lda #$20
    sta FoodItemL+1
    lda #$80
    sta FoodItemR+1
    lda #$30
    sta FoodItemL+2
    lda #$90
    sta FoodItemR+2
    lda #$40
    sta FoodItemL+3
    lda #$A0
    sta FoodItemR+3
    lda #$50
    sta FoodItemL+4
    lda #$B0
    sta FoodItemR+4
    lda #$60
    sta FoodItemL+5
    lda #$C0
    sta FoodItemR+5
    lda #$D0
    sta FoodItemL+6
    lda #$E0
    sta FoodItemR+6
    
    lda #<CatFaceGfx
    sta CatGfxPtr
    lda #>CatFaceGfx
    sta CatGfxPtr+1
    
    dec FoodPosX
    bpl .NoReset
    lda #88
    sta FoodPosX
.NoReset
    
    lda FoodPosX
    sec
    
    sbc #41
    bcs .Rock1
    adc #89
.Rock1
    sta FoodPosX+1
    
    sbc #17
    bcs .Rock2
    adc #89
.Rock2
    sta FoodPosX+2
    
    lsr
    sta FoodPosX+3
    
    sbc #29
    bcs .Rock4
    adc #89
.Rock4
    sta FoodPosX+4
    
    lsr
    sta FoodPosX+5
    
    sbc #57
    bcs .Rock6
    adc #89
.Rock6
    sta FoodPosX+6
    
    lda Frame
    and #%00001000
    lsr
    lsr
    lsr
    tay
    lda RainbowGfx,y
    sta Rainbow



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare for Main Gameplay Kernel
;
; Figure out how many rows to draw before and after the two cat rows
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
    lda #3
    sta PreCatRows
    lda #2
    sta PostCatRows



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

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
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
