; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	VERT_SYNC

	sta HMCLR
	sta WSYNC

; set gfx obj positions for scoreboard display
	lda #$F0	; 02
	sta HMM1	; 05
	lda #$10	; 07
	sta HMP1	; 10
	sta HMM0	; 13
	SLEEP 7		; 20
	sta RESM1	; 23
	SLEEP 3		; 26
	sta RESBL	; 29
	jsr Sleep12	; 41
	SLEEP 11	; 52
	sta RESP0	; 55
	sta RESP1	; 58
	jsr Sleep12	; 67
	sta RESM0	; 70
	
	sta WSYNC
	sta HMOVE

; prepare for throbbing lines
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

	SUBROUTINE

; get graphics data for the scoreboard and push it onto the stack

; Prepare MSBs for all the scoreboard loading pointers - 23 cycles    
	lda #>ScoreGfx
	sta LvlLoadPtr+1
	sta ScrLoadPtr0+1
	sta ScrLoadPtr1+1
	sta ScrLoadPtr2+1
	sta ScrLoadPtr3+1
	sta ScrLoadPtr4+1
	sta ScrLoadPtr5+1

; Prepare pointer for level digit graphics - 14 cycles
	lda Level
	cmp #$10
	bmi .Less10_1
	sbc #10
.Less10_1
	sta LvlLoadPtr	; set LSB of level digit graphics pointer

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

	lda Frame
	lsr
	lsr
	lsr
	sta Progress

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

	lda #10
	sta Level

	lda Level
	cmp #$10
	bmi .Less10
	sbc #6
.Less10
	asl
	tax
	lda LevelColors,x
	sta ScoreColor
	sta COLUP0
	sta COLUP1
	sta COLUPF
	sta COLUBK


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

	NEXT_PAGE
	TIMER_LOOP
