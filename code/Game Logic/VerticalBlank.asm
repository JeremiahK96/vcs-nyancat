; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	
	sta HMCLR
	sta WSYNC
	
	lda #$FF	; 02
	sta HMM1	; 05
	sta ProgressBar+1	; 08 - reset progress bar byte 1 to %11111111
	
	ldx #$10	; 10
	stx HMP1	; 13
	
	ldx #$80	; 15
	stx HMM0	; 18
	
	ldx #$E0	; 20
	sta RESM1	; 23
	stx ProgressBar+0	; 26 - reset progress bar byte 0 to %11100000
	
	sta RESBL	; 29
	
	sta ProgressBar+2	; 32 - reset progress bar byte 2 to %11111111
	sta ProgressBar+3	; 35 - reset progress bar byte 3 to %11111111

	lda #$FE		; 37
	sta ProgressBar+4	; 40 - reset byte 4 for the progress bar
	
	jsr Sleep12	; 52
	
	sta RESP0	; 55
	sta RESP1	; 58
	
	SLEEP 9		; 67
	
	sta RESM0	; 70
	
	sta WSYNC
	sta HMOVE



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare HMOVE offsets for all scoreboard objects, and
; reset the progress bar's RAM values to empty. (39 cycles)
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare for throbbing lines - 43 cycles

	lda Frame	; get the current frame number
	and #%00011100	; change animation frame every 4 game frames
	lsr
	lsr		; shift to get a value from 0-7
	sta Temp
	asl		; carry flag will always be clear after this
	adc Temp	; multiply by 3
	tay
	
	lda ScoreColor
	and #$F0
	sta Temp
	
	lda ThrobGfx+0,y
	asl
	bcc .Color0
	SKIP_WORD
.Color0
	adc Temp
	sta ThrobColor+0
	
	lda ThrobGfx+1,y
	asl
	bcc .Color1
	SKIP_WORD
.Color1
	adc Temp
	sta ThrobColor+1
	
	lda ThrobGfx+2,y
	asl
	bcc .Color2
	SKIP_WORD
.Color2
	adc Temp
	sta ThrobColor+2



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
;
; Takes 534 cycles to complete (7 full scanlines + 2 cycles)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare MSBs for all the scoreboard loading pointers - 23 cycles
    
	lda #>ScoreGfx
	sta LvlLoadPtr+1
	sta ScrLoadPtr0+1
	sta ScrLoadPtr1+1
	sta ScrLoadPtr2+1
	sta ScrLoadPtr3+1
	sta ScrLoadPtr4+1
	sta ScrLoadPtr5+1
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare pointer for level digit graphics - 14 cycles
    
	lda BCDLevel
	and #$0F
	asl
	asl
	asl
	sta LvlLoadPtr	; set LSB of level digit graphics pointer
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare pointers for score digit graphics - 69 cycles
    
	lax BCDScore+0
	and #$F0
	lsr
	sta ScrLoadPtr0	; set LSB for score digit pointer 0
	
	txa
	and #$0F
	asl
	asl
	asl
	sta ScrLoadPtr1	; set LSB for score digit pointer 1
	
	lax BCDScore+1
	and #$F0
	lsr
	sta ScrLoadPtr2	; set LSB for score digit pointer 2
	
	txa
	and #$0F
	asl
	asl
	asl
	sta ScrLoadPtr3	; set LSB for score digit pointer 3
	
	lax BCDScore+2
	and #$F0
	lsr
	sta ScrLoadPtr4	; set LSB for score digit pointer 4
	
	txa
	and #$0F
	asl
	asl
	asl
	sta ScrLoadPtr5	; set LSB for score digit pointer 5
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load the stack with the graphics for the scoreboard - 428 cycles
	
	ldy #6
	
.LoadScoreboard
	
	lda (ScrLoadPtr5),y
	pha
	lda (ScrLoadPtr4),y
	pha
	lda (ScrLoadPtr3),y
	pha
	lda (ScrLoadPtr2),y
	pha
	lda (ScrLoadPtr1),y
	pha
	lda (ScrLoadPtr0),y
	pha
	lda (LvlLoadPtr),y
	pha
	
	dey
	bpl .LoadScoreboard
	


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load RAM for progress bar display (28-53 cycles)

	lda Progress		; 3 - get amount of progress
    
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
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	ldy #%00000000	; 2 - value to store when a playfield byte is full
	
	sec		; 2
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
	
	tax		; 2
	lda PgBarGfx+1,x; 4 - load from normal set of playfield graphics
	asl		; 2
	sta ProgressBar+4	; 3
	jmp .Finish	; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow1	; for 1st PF0
	
	adc #3			; 3 - add back the 3
	tax			; 2
	lda PgBarGfxR+5,x	; 4 - load from reversed set of playfield graphics
	sta ProgressBar		; 3
	jmp .Finish		; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow2	; for 1st PF1
	
	adc #8			; 3 - add back the 8
	tax			; 2
	lda PgBarGfx,x		; 4 - load from normal set of playfield graphics
	sta ProgressBar+1	; 3
	jmp .Finish		; 3
	
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow3	; for PF2
	
	adc #8			; 3 - add back the 8
	tax			; 2
	lda PgBarGfxR,x		; 4 - load from reversed set of playfield graphics
	sta ProgressBar+2	; 3
	jmp .Finish		; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Underflow4	; for 2nd PF0
	
	adc #4			; 3 - add back the 4
	tax			; 2
	lda PgBarGfxR+4,x	; 4 - load from reversed set of playfield graphics
	sta ProgressBar+3	; 3
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.Finish
	
	sta HMCLR
	
	ldx FoodPosX
	dex
	bpl .NoReset0
	ldx #88
.NoReset0
	stx FoodPosX+0
	
	txa
	sec
	
	sbc #18
	bcs .NoReset1
	adc #89
.NoReset1
	sta FoodPosX+1
	
	sbc #52
	bcs .NoReset2
	adc #89
.NoReset2
	sta FoodPosX+2
	
	sbc #27
	bcs .NoReset3
	adc #89
.NoReset3
	sta FoodPosX+3
	
	sbc #63
	bcs .NoReset4
	adc #89
.NoReset4
	sta FoodPosX+4
	
	sbc #41
	bcs .NoReset5
	adc #89
.NoReset5
	sta FoodPosX+5
	
	sbc #17
	bcs .NoReset6
	adc #89
.NoReset6
	sta FoodPosX+6



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Calculate Hmove offsets for 2nd cat row's food items
    
	lda #5
	sec
	sbc PreCatRows
	tay
	
	lda FoodItemL,y
	and #$F0
	sta CatRow2FoodL
	tax
	lda FoodGfx+15,x
	sta CatRow2Color1
	
	lda FoodItemR,y
	and #$F0
	sta CatRow2FoodR
	tax
	lda FoodGfx+15,x
	sta CatRow2Color2
	
	lda FoodPosX,y
	sbc #44
	beq .Prepare
	bcc .Prepare
	sbc #45
    
.Prepare
	sec
	sbc #1
	
	ldx #$70
	ldy #2
    
.OffsetLoop
	clc
	adc #15
	beq .CalcOffset
	bmi .MaxOffset
	
.CalcOffset
	eor #7
	asl
	asl
	asl
	asl
	
	sta CatRowHmove,y
	lda #0
	beq .NextOffset
	
.MaxOffset
	stx CatRowHmove,y
	
.NextOffset
	dey
	bpl .OffsetLoop
	
	
	
	
	
	SUBROUTINE
	
	
	
	
	
	
	lda #COL_SCORE	; 2
	sta ScoreColor	; 3
	
	lda ScoreColor	; 3
	sta COLUP0		; 3 - set color registers
	sta COLUP1		; 3
	sta COLUPF		; 3
	sta COLUBK		; 3
	
	lda Frame
	and #%00001111
	beq .IncScore
	lda #0
	beq .IncSkip
.IncScore
	lda #$89
.IncSkip
	sta BCDScoreAdd+1
	
	lda #$19
	sta BCDLevel
	
	
    
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	
	lda #>FoodGfx
	sta FoodGfxPtr1+1
	sta FoodGfxPtr2+1
	
	lda #>CatTartGfx
	sta TartGfxPtr1+1
	sta TartGfxPtr2+1
	
	lda #>CatFaceGfx
	sta CatGfxPtr1+1
	sta CatGfxPtr2+1
	
	lda CatPosition
	and #%00011111
	tax
	
	clc
	
	adc #<CatTartGfx
	sta TartGfxPtr2
	adc #19
	sta TartGfxPtr1
	
	txa
	adc #<CatFaceGfx
	sta CatGfxPtr2
	adc #19
	sta CatGfxPtr1
	
	lda #$56
	sta PgBarColor
	
	lda #COL_CAT_TART
	sta CatTartColor
	
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



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	jmp VblankTimerLoop
	
	ALIGN $100

VblankTimerLoop
	lda INTIM
	bne VblankTimerLoop
