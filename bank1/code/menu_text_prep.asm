; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Prepare variables for menu text display
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; adjust menu position smoothly to where the cursor points
	ldx CursorPos
	lda MenuPos
	cmp Mult21,x
	bmi .TooSml
	asl
	adc MenuPos
	adc Mult21,x
	ror
	lsr
	jmp .SetMP
.TooSml	asl
	adc MenuPos
	adc Mult21,x
	ror
	adc #0
	lsr
	adc #0
.SetMP	sta MenuPos

; prepare variables for menu position
	ldx #255
	txs
	sec
.SbcLoop
	inx
	sbc #21
	bpl .SbcLoop
	adc #21
	sta MenuTxtDelay
	tay
	lda MenuTxtDlyTbl,y
	lsr
	php
	bcc .SkipThat
	inx
.SkipThat

; set text to be displayed in fields
	jsr GetTxtField
	sta MenuTxtField+0
	jsr GetTxtField
	sta MenuTxtField+1
	jsr GetTxtField
	sta MenuTxtField+2

