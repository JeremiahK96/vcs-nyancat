; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:
	
	inc Frame	; increment the frame number
	
	lda #OVERSCAN_TIMER
	sta WSYNC
	sta TIM64T	; 3



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Update Score
;
; Add to the score
;
; Takes 45 cycles to complete
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	lda BCDScoreAdd+1
	ldx BCDScoreAdd
	
	sed
	
	clc
	sta Temp
	lda BCDScore+2
	adc Temp
	sta BCDScore+2
	stx Temp
	lda BCDScore+1
	adc Temp
	sta BCDScore+1
	lda #$00
	sta Temp
	lda BCDScore+0
	adc Temp
	sta BCDScore+0
	
	cld



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Proccess Joysticks
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	lda #0
	sta SWACNT	; set all I/O pins to input for joystick reading
	
	lda SWCHA	; get joystick position for this frame ONLY ONCE
	sta Temp	; save joystick position for consistency

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
	stx CatRow
	jmp .Skip

.NoDown
	asl	; check joystick up
	bcs .Skip
	
	ldx CatRow
	beq .Skip	; If already at the top row, don't move up
	
	dex
	stx CatRow



.Skip



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Caclulate cat's position data
	
	SUBROUTINE
	
	lda CatRow
	and #$07
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
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
	lda INTIM
	bne OverscanTimerLoop
