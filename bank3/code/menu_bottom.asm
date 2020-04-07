MenuTxtBtm

	ldy #6
	lda (TextColorPtr),y
	sta.w COLUP0
	sta COLUP1
	ldy MenuTxtField+0
	sta HMOVE	; 75
	txa

	beq StartMenuText
	
MenuTextDelayLoop
	dex
	sta WSYNC
	bne MenuTextDelayLoop
	SLEEP 2

StartMenuText
	jsr CharPreload
	jsr CharKernel

	pha		; sleep for 9 cycles
	pla
	nop

	ldy MenuTxtField+1
	jsr CharLoad
	jsr CharKernel

	pha		; sleep for 9 cycles
	pla
	nop

	ldy MenuTxtField+2
	jsr CharLoad
	jsr CharKernel

	pha		; sleep for 7 cycles
	pla

	stx COLUP0
	stx COLUP1
	stx VDELP0
	stx VDELP1

	jmp JmpMenuOverScan

