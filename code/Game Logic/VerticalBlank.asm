; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare HMOVE offsets for all scoreboard objects, and
; reset the progress bar's RAM values to empty. (39 cycles)

    lda #$E0	; 05
    sta HMP0	; 08 - set HMOVE offset for score's left digit
    sta HMM0	; 11 - set HMOVE offset for left side of level counter digit
    
    sta ProgressBar+0	; 14 - reset RAM byte 0 to %11100000 for progress bar
    
    lda #$FF	; 16
    sta HMP1	; 19 - set HMOVE offset for score's right digit
    sta HMBL	; 22 - set HMOVE offset for leading 1 in level counter
    		; right side of level counter digit doesn't need an HMOVE offset
    
    sta ProgressBar+1	; 25 - reset RAM byte 1 to %11111111 for progress bar
    
    sta RESP0	; 28 - set position of score's left digit
    sta RESP1	; 31 - set position of score's right digit

    sta ProgressBar+2	; 34
    sta ProgressBar+3	; 37
    lda #%11111110	; 39 - reset byte 4 for the progress bar
    sta ProgressBar+4	; 42
    
    SLEEP 19
    
    sta RESM0	; 64 - set position for left side of level counter digit

    SLEEP 72	; 60
    
    sta RESBL	; 63
    sta RESM1	; 66
    
    sta WSYNC
    sta HMOVE



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
;
; Takes 685 cycles to complete (9 full scanlines + 1 cycle)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare pointer for level digit graphics
    
    lda #>LevelGfx	; 2
    sta LevelLoadPtr+1	; 3 - set MSB of level digit graphics pointer
    
    lda Level		; 3
    
    sec			; 2 - perform a mod 10 to isolate left digit
    sbc #10		; 2
    
    bcc .Negative	; 3/2
    bcs .Positive	; 3 - done this way to use the same number of cycles
			;     either way, may or may not be neccesary
.Negative
    adc #10		; 2
.Positive
    
    asl			; 2
    asl			; 2
    asl			; 2
    adc #<LevelGfx	; 2 - add graphics table offset
    sta LevelLoadPtr	; 3 - set LSB of level digit graphics pointer

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare one pointer MSB and multiple LSB's for score digit graphics
    
    lda #>ScoreGfx	; 2
    sta ScoreLoadPtr+1	; 3 - set MSB of score digit graphics pointer
    
    lax BCDScore+0	; 3
    and #$F0		; 2
    lsr			; 2
    sta ScoreDigit0	; 3 - set LSB for digit 0
    txa			; 2
    and #$0F		; 2
    asl			; 2
    asl			; 2
    asl			; 2
    sta ScoreDigit1	; 3 - set LSB for digit 1
    
    lax BCDScore+1	; 3
    and #$F0		; 2
    lsr			; 2
    sta ScoreDigit2	; 3 - set LSB for digit 2
    txa			; 2
    and #$0F		; 2
    asl			; 2
    asl			; 2
    asl			; 2
    sta ScoreDigit3	; 2 - set LSB for digit 3
    
    lax BCDScore+2	; 3
    and #$F0		; 2
    lsr			; 2
    sta ScoreDigit4	; 3 - set LSB for digit 4
    txa			; 2
    and #$0F		; 2
    asl			; 2
    asl			; 2
    asl			; 2
    sta ScoreDigit5	; 3 - set LSB for digit 5
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load the stack with the graphics for the scoreboard
    
    ldy #6		; 2

.LoadScoreboard

    lda (LevelLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit5	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit4	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit3	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit2	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit1	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    lda ScoreDigit0	; 3
    sta ScoreLoadPtr	; 3
    lda (ScoreLoadPtr),y; 5
    pha			; 3
    
    dey			; 2
    bpl .LoadScoreboard	; 2/3



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
    
    sta WSYNC
    sta HMCLR

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
; Prepare the NUSIZx, VDELPx and COLUPx values for the 6-digit score
    
    lda #THREE_CLOSE | MSL_SIZE_2
    
    sta NUSIZ0
    sta NUSIZ1
    
    sta VDELP0
    sta VDELP1

    lda #COL_SCORE
    sta ScoreColor

    lda ScoreColor
    sta COLUP0		; set color registers
    sta COLUP1
    sta COLUPF
    sta COLUBK
    
    
    
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
    
    lda #$56
    sta PgBarColor
    
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
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
