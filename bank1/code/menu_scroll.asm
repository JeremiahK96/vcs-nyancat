;

	SUBROUTINE

	lda CursorPos
	asl
	asl
	adc CursorPos
	asl
	asl
	adc CursorPos		; multiply by 21
	
	cmp MenuPos
	beq .NoMove
	bmi .MoveUp

.MoveDn	sec
	sbc MenuPos
	lsr
	adc MenuPos
	bne .Update

.MoveUp	sta MenuTemp
	lda MenuPos
	sec
	sbc MenuTemp
	lsr
	clc
	adc MenuTemp

.Update	sta MenuPos
.NoMove

