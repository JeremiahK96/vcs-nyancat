; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Animation Management
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

	lax MenuCatTiming
	and #7
	bne .Same
	txa
	clc
	adc #1<<3
	cmp #27<<3
	bne .NoRoll
	lda #0
.NoRoll	sta MenuCatTiming

	lsr
	lsr
	lsr
	tay
	bit Variation
	bpl .PAL
	lda CatTimingNTSC,y
	bne .NTSC
.PAL	lda CatTimingPAL,y
.NTSC	adc MenuCatTiming
	sta MenuCatTiming
	inc MenuCatFrame

	lda MenuCatFrame
	cmp #6
	bne .Chk86
	lda #$80
	bne .NewMCF

.Chk86	cmp #$86
	bne .Same
	lda #0
.NewMCF	sta MenuCatFrame

.Same	dec MenuCatTiming

