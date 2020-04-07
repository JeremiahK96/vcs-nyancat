GetTxtField
	inx
	lda Variation

	cpx #2
	bne .Try3
	asl
	asl
	asl
	bpl .Plr1
	lda #17
	rts
.Plr1	bcs .TwoPlr
	lda #175
	rts
.TwoPlr	lda #183
	rts

.Try3	cpx #3
	bne .Try4
	and #%00110000
	beq .Start
	cmp #%00110000
	beq .Start
	lda #23
	rts
.Start	lda #66
	rts

.Try4	cpx #4
	bne .Try5
	tay
	and #%00010000
	bne .Plr2
	tya
	lsr
	lsr
	SKIP_BYTE
.Plr2	tya
	and #3
	tay
	lda DifTxtOffset,y
	rts

.Try5	cpx #5
	bne .Try6
	lda #73
	rts

.Try6	cpx #6
	bne .Blank
	lda #80
	rts

.Blank
	lda #0
	rts



DifTxtOffset
	.byte 29
	.byte 108
	.byte 191
	.byte 115

