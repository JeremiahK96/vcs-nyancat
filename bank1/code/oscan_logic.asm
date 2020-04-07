; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan logic for menu
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuOverScan:	SUBROUTINE

	TIMER_LOOP

	lda #21
	sta TIM64T

	ldx #0
	lda Variation
	and #%00010000
	beq .GetPdl
	inx
	bit CtrlType
	bmi .GetPdl
	inx
.GetPdl
	lda INPT0,x

	inc Frame		; next frame

	TIMER_LOOP

