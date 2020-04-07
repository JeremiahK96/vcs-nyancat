
	lda #1
	sta CursorPos
	lda #21
	sta MenuPos
	lda #%00010000
	sta CtrlType

	; set cat color
	lda #%1000
	and SWCHB
	tax
	lda MenuColors+1,x
	sta CatTartColor
	sta OtherTartColor

