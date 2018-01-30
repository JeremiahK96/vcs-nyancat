; Draw all the rows above the cat's two rows

	include subroutines/SetFoodPosition.asm
    
HiRows:
	SUBROUTINE
	
	sta WSYNC
	
	lda ThrobColor+0
	sta COLUBK
	sta COLUPF
	
	
	; First, output a single-color line to draw the bottom of a "throb" line.
	; This will probably be a good time to prepare the pointers for the
	; food items' graphics, as well as loading the colors for the food items.
	
	; After that, output 14 lines to draw a single row with food items,
	; but without drawing the cat. The food graphics will be updated every line,
	; but there will probably not be enough time to also update the food colors
	; every line throughout the kernel.
	
	jsr DrawFoodRow
	
	dec CurrentRow	; 73
	
	sta WSYNC
	
	; Lastly, output four single-color lines to draw most of a "throb" line,
	; while setting the position of player 1 to draw the next set of food items.
	
	
	lda ThrobColor+0
	sta COLUBK
	sta COLUPF
	lda #0
	sta GRP0
	sta GRP1
	
	lda ThrobColor+1
	
	jsr SetFoodPosition
	
	sta WSYNC
	
	lda ThrobColor+2; 03
	sta COLUBK	; 06
	sta COLUPF	; 09
	
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12
	jsr Sleep12	; 69
	
	sta.w HMOVE	; 73
	
	sta WSYNC
	
	lda ThrobColor+1; 03
	sta COLUBK	; 06
	sta COLUPF	; 09
	
	lda FoodItemL,y	; 13
	and #$F0	; 15
	sta FoodGfxPtr1	; 18
	tax		; 20
	lda FoodGfx+15,x; 24
	sta FoodColor1	; 27
	
	lda FoodItemR,y	; 31
	and #$F0	; 33
	sta FoodGfxPtr2	; 36
	tax		; 38
	lda FoodGfx+15,x; 42
	sta FoodColor2	; 45
	
	lda FoodPosX,y	; 49
	sta Temp	; 52
	
	dec PreCatRows
	bne HiRows
	
	; If this is not the last row before drawing the cat's rows,
	; loop back to HiRows to draw the next row.
