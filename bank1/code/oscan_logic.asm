; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan logic for menu
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuOverScan:
	SET_OSCAN_TIMER

	lda #2			; temp menu bypass
	bit SWCHB
	bne .NoResetPress
	jmp JmpGamePlay
.NoResetPress

	inc Frame		; next frame

	TIMER_LOOP

