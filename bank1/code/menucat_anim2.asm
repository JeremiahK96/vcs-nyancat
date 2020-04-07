
	SUBROUTINE

	lda Frame
	and #%00000011
	bne .Same
	inc MenuCatFrame
	lda MenuCatFrame
	cmp #6
	bne .Same
	lda #0
	sta MenuCatFrame
.Same

