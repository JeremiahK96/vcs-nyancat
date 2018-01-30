SetFoodPosition:

	sta WSYNC	; 00

	sta COLUBK	; 03
	sta COLUPF	; 06
	
	SLEEP 4		; 10
	
	ldy CurrentRow	; 13
	lda FoodPosX,y	; 17
	
	sec		; 19
.DivideLoop
	sbc #15		; 21
	bcs .DivideLoop	; 23
	
	sta RESP1	; 26
	
	eor #7
	adc #1
	asl
	asl
	asl
	asl
	sta HMP1	; 41/66
	
	rts		; 47/72