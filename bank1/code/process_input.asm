; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Process player input
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

	lax CtrlType
	bit Variation
	bvs .NoSplash
	and #%11100000	; force directional input to be ignored
	tax
.NoSplash
	and #%00100000
	bne .Detected	; branch if controller has been detected
	jmp .NotDetected

.Detected
	ldy #0
	lda Variation
	and #%00010000
	beq .Plyr1
	iny
	txa
	asl
	SKIP_BYTE
.Plyr1	txa
	bmi .Paddle	; branch if paddle

	lda SWCHA
	cpy #1
	beq .Plyr2
	lsr
	lsr
	lsr
	lsr
.Plyr2	and #15
	sta CtrlType

	lda INPT4,y
	and #$80
	lsr
	lsr
	lsr
	ora CtrlType
	sta CtrlType
	txa
	and #%11100000
	ora CtrlType
	sta CtrlType
	bne .CheckInput

.Paddle	cpy #0
	beq .GetPaddleFire
	txa
	bmi .GetPaddleFire
	iny
.GetPaddleFire
	lda SWCHA
	and PdlFireMask,y
	beq .PaddleFire
	lda #%00011111
	SKIP_WORD
.PaddleFire
	lda #%00001111
	sta CtrlType
	txa
	and #%11100000
	ora CtrlType
	sta CtrlType

.CheckInput
	lda CtrlType
	lsr
	tay
	txa
	ror
	tax
	bmi .NoUp
	bcc .NoUp

	; joystick up
	lda CursorPos
	beq .NoUp
	dec CursorPos

.NoUp	tya
	lsr
	tay
	txa
	ror
	tax
	bmi .NoDown
	bcc .NoDown

	; joystick down
	lda CursorPos
	cmp #4
	beq .NoDown
	inc CursorPos

.NoDown	txa
	lsr
	lsr
	tax
	tya
	lsr
	lsr
	lsr
	txa
	ror
	bmi .NoFire
	lda Variation		; disable splash, enable menu
	ora #%01000000
	sta Variation
	bcc .NoFire

	; fire pressed
	tax
	ldy CursorPos
	bne .Not0
	and #%00010000
	bne .Back
	txa
	eor #%00100000
	sta Variation
	bcs .NoFire
.Back	txa
	and #%11101111
	bcs .SwpClr

.Not0	cpy #1
	bne .Not1
	asl
	asl
	asl
	bcs .Next
.Start	jmp JmpGamePlay
.Next	bmi .Start
	txa
	ora #%00010000
.SwpClr	sta Variation
	lda CtrlType
	and #%11011111
	ora #%00011111
	sta CtrlType
	ldy CatTartColor
	lda OtherTartColor
	sty OtherTartColor
	bcs .SetClr

.Not1	cpy #2
	bne .Not2
	and #%00010000
	beq .DifP1
	txa
	adc #0
	ora #%11111100
	sta Variation
	txa
	ora #%00000011
	jmp .NewVar
.DifP1	txa
	adc #3
	ora #%11110011
	sta Variation
	txa
	ora #%00001100
.NewVar	and Variation
	sta Variation
	jmp .NoFire

.Not2	lax CatTartColor
	clc
	cpy #4
	bne .Not4
	and #%11110000
	sta CatTartColor
	inx
	inx
	txa
	and #%00001111
	ora CatTartColor
	SKIP_WORD
.Not4	adc #$10
.SetClr	sta CatTartColor
.NoFire
.NotDetected

