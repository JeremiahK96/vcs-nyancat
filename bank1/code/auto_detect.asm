; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Automatically detect controllers
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

	lda CtrlType
	and #%00100000
	bne .EndCtrlDetect

	; Y selects controller to detect, 0=P1, 1=P2
	ldy #0
	lda #%00010000
	and Variation
	beq .Player1
	iny

.Player1
	; check for joystick up/down
	lda SWCHA
	ora JoyUpDnMask,y
	eor #$FF
	bne .SetTypeToJoy

	; check for joystick fire button
	lda INPT4,y
	bmi .NotJoyFire
.SetTypeToJoy
	lda SetJoyMask,y
	and CtrlType
	ora #%00100000
	sta CtrlType
	bne .NoInputDelay

.NotJoyFire
	tya
	tax
	beq .Plyr1Check
	bit CtrlType
	bpl .Plyr1Joy
	bit SWCHA
	bvs .EndCtrlDetect
	lda #%11100000	; both controls are paddle, ignore this first fire press
	bne .EndP1
.Plyr1Joy
	inx

.Plyr1Check
	lda INPT0,x
	bpl .NoPaddle
	
	lda #%00010000
	bit CtrlType
	beq .SetTypeToPdl
	ldy #$80
	sty VBLANK
	sta VBLANK
	lda INPT0,x
	bpl .NoPaddle

.SetTypeToPdl
	lda SetPdlMask,y
	ora CtrlType
	sta CtrlType
.NoInputDelay
	bit Variation
	bvc .EndCtrlDetect
	lda CtrlType
	ora #%00011111
	sta CtrlType
	bne .EndCtrlDetect

.NoPaddle
	lda CtrlType
	and #%11101111
.EndP1	sta CtrlType
.EndCtrlDetect

