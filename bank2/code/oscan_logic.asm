; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:	SUBROUTINE

	inc Frame	; increment the frame number
	SET_OSCAN_TIMER 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Proccess Joysticks
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	lda #0
	sta SWACNT	; set all I/O pins to input for joystick reading
	lda SWCHA	; get joystick position for this frame ONLY ONCE
	sta Temp	; save joystick position for consistency
	and #$30	; check left stick's up/down bit states
	cmp #$30	; to see if they are both HI (joystick centered)
	bne .NotCenter	; if not, skip ahead
	lda JoyCenter	; otherwise set rightmost bit of JoyCenter
	ora #1		; (to signify that the joystick HAS been re-centered
	sta JoyCenter	; before the cat's next movement)
.NotCenter
	lda INPT4	; if the left fire button is pressed,
	bpl .CheckPos	; skip the check for a previously centered joystick
	lda JoyCenter	; otherwise, check if the joystick has been centered
	and #1
	beq .Skip	; if it hasn't, don't make a movement
.CheckPos
	lda CatPosition	; get cat's position
	and #$1F	; check right 5 bits only
	beq .ReadJoy	; if zero, we are centered on a row (read joystick)
	cmp #19		; or if 19, we are centered on the bottom row
	bne .Skip	; if not centered, skip reading joystick
.ReadJoy
	lda Temp
	asl	; ignore joystick right
	asl	; ignore joystick left
	asl	; check joystick down
	bcs .NoDown
	
	; Now that we know the player is pressing the joystick down, we need to
	; decide if the cat should be moved down a row.
	
	ldx CatRow
	cpx #6
	beq .Skip	; If already at the bottom row, don't move down
	inx
	bne .ChangeRow

.NoDown
	asl	; check joystick up
	bcs .Skip
	ldx CatRow
	beq .Skip	; If already at the top row, don't move up
	dex
.ChangeRow
	stx CatRow
	lda JoyCenter
	and #$FE
	sta JoyCenter	; clear rightmost bit in JoyCenter
.Skip


; Caclulate cat's position data
	SUBROUTINE

	lda CatRow
	and #7
	tax
	lda RowPosition,x
	cmp CatPosY
	beq .NoMove
	bmi .MoveUp
.MoveDown
	sec
	sbc CatPosY
	lsr
	adc CatPosY
	bne .UpdatePos
.MoveUp
	lda CatPosY
	sec
	sbc RowPosition,x
	lsr
	clc
	adc RowPosition,x
.UpdatePos
	sta CatPosY
.NoMove
	ldx #0
.DivideLoop
	sec
	inx
	sbc #19
	bcc .AddBack
	
	cpx #5
	bne .DivideLoop
	inx
	bne .SetCatPos
.AddBack
	adc #19
.SetCatPos
	sta CatPosition
	txa
	asl
	asl
	asl
	asl
	asl
	adc CatPosition
	sta CatPosition
	dex
	stx PreCatRows

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	TIMER_LOOP
