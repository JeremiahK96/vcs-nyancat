; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw all the rows below the cat's two rows.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

LoRows:	
	SUBROUTINE

	; Output 4 lines, drawing the rest of the "throb" line, while preparing
	; player 1 for the next row's food items.

	lda ThrobColor+1
	jsr SetFoodPosition
	sta WSYNC

	lda ThrobColor+2	; 03
	sta COLUBK		; 06
	sta COLUPF		; 09
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12		; 69
	sta.w HMOVE		; 73
	sta WSYNC

	lda ThrobColor+1
	sta COLUBK
	sta COLUPF
	sta WSYNC

	lda ThrobColor+0	; 3
	sta COLUBK		; 6
	sta COLUPF		; 9
	ldy CurrentRow		; 12
	
	lda FoodItemL,y		; 16
	and #$F0		; 18
	sta FoodGfxPtr1		; 21
	tax			; 23
	lda FoodGfx+15,x	; 27
	sta FoodColor1		; 30
	
	lda FoodItemR,y		; 34
	and #$F0		; 37
	sta FoodGfxPtr2		; 39
	tax			; 41
	lda FoodGfx+15,x	; 45
	sta FoodColor2		; 48
	
	lda FoodPosX,y		; 52
	sta Temp		; 55

	; Output 14 lines to draw a row, exactly the same as in HiRows.
	; It may be possible to code this as a subroutine to save ROM space.

	jsr DrawFoodRow	; 61
	sta WSYNC

	; Lastly, output a single line for the next "throb" line.
	; Use this time to prepare the next row's food item pointers (unless this is
	; the last row). If this is not the last row, loop to LoRows for the next row.

	lda ThrobColor+0
	sta COLUBK
	sta COLUPF
	lda #0
	sta GRP0
	sta GRP1
	dec CurrentRow
	bpl LoRows

	ldx #$FF
	txs

GameplayEnd
	sta WSYNC
	SLEEP 2
