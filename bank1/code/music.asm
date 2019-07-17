; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Music Engine
;
; Handles the main music melody
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; set bass frequency
	lax MusicNote
	asr #%00011110
	lsr
	tay
	lda BassSeq,y
	sta AUDF1
	lda #6
	ldy #7
	bcs .Loud
	ldy #3
.Loud	sta AUDC1
	sty AUDV1

	; get current note offset and store in Y
	txa
	lsr
	lsr
	lsr
	lsr
	tay
	txa
	and #$F
	clc
	adc MusicSeqs,y
	tay

	lda #>MusicSeq0
	sta MusicPtr+1
	lda #<MusicSeq0
	sta MusicPtr
	ldx #0
	jsr SetNote2
	lda #<MusicVlm
	sta MusicPtr
	jsr SetVolume
	
	jsr UpdateNote

