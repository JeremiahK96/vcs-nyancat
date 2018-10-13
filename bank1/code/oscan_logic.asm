; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan logic for menu
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuOverScan:
	SET_OSCAN_TIMER

	lda #1			; temp menu bypass
	bit SWCHB
	bne .NoResetPress
	jmp JmpGamePlay
.NoResetPress

	bmi .NoFrameInc

	inc Frame		; next frame
	lda Frame
	and #%00000011		; update animation every 4 frames
	bne .NoFrameInc

	bit SWCHB
	bvs .NoFrameInc

	ldx MenuCatFrame
	inx
	cpx #6
	bne .NoReset
	ldx #0
.NoReset
	stx MenuCatFrame
.NoFrameInc

	TIMER_LOOP
