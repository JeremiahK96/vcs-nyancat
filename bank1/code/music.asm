; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Music Engine
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Handles the main music melody, using voice 0
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; NoteData:	-----xxx	frames left in note
	;		xxxxx---	note length table offset

	; MusicNote:	----xxxx	current note in sequence
	;		xxxx----	current sequence table

	; write audio registers for music
	
	; volume
	; frequency and voice
	
	; get current note offset and store in Y
	lax MusicNote
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

	; set note volume and frequency
	lda #$C
	ldx MusicSeq0,y
	beq .Hold
	bpl .HiNote
	lda #$4
.HiNote	sta AUDC0
	stx AUDF0
.Hold

	; set note volume
	lda NoteData
	lsr
	lsr
	lsr
	tay

	lda NoteData
	and #7
	
	dex
	inx
	bne .NoHold
	clc
	adc NoteLengths-1,y
.NoHold	tax
	lda VlmEnvelope,x
	lsr
	sta AUDV0

	; update music state for next frame
	inc NoteData
	lda NoteData
	and #7
	cmp NoteLengths,y
	bne .Same

	lda NoteData	
	and #$F8
	clc
	adc #1<<3
	cmp #18<<3
	bne .NoRoll
	lda #0
.NoRoll
	sta NoteData

	inc MusicNote
.Same

