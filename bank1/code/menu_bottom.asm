
	SET_OSCAN_TIMER 53

	bit Variation
	bvs DrawMenu
	jmp MenuBottom

DrawMenu
	lda CtrlType
	and #%00100000
	beq .NoGnd
	ldy #$80
	sty VBLANK	; ground paddle caps if controller detected
	sta VBLANK

.NoGnd	lda #>MenuTxtClr
	sta TextColorPtr+1

	ldy MenuTxtDelay
	lda MenuTxtDlyTbl,y
	lsr
	bcc .Add30
	ldx #<MenuTxtClr+19
	SKIP_WORD
.Add30	ldx #<MenuTxtClr+30
	stx TextColorPtr

	tya
	lsr
	clc
	adc TextColorPtr
	sta TextColorPtr

	ldx #0
	stx GRP0
	dex
	txs

	lda #3
	sta WSYNC
	stx HMP0

	sta NUSIZ0
	sta NUSIZ1
	sta VDELP0
	sta VDELP1

	lda MenuTxtDlyTbl,y
	lsr
	tax
	and #7
	sta MenuTemp
	txa
	lsr
	lsr
	lsr
	tax

	sta RESP0	; 41
	sta RESP1	; 44

	jmp JmpMenuTxtBtm
			; 47

MenuBottom

