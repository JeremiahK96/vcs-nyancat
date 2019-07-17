; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Music Engine
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

SetNote

; set voice and frequency
	ldy MusicNote
SetNote2
	lda (MusicPtr),y	; get current note
	sta TempNote		; save current note for later
	beq .Hold		; keep voice and frequency if note hold
	sta AUDF0,x		; set new frequency for voice X
	bpl .HiNote
	lda #$4			; voice for low notes
	SKIP_WORD
.HiNote	lda #$C			; voice for high notes
	sta AUDC0,x		; set new voice for voice X
.Hold	rts



SetVolume

; set volume
	stx TempX		; save voice number
	lax NoteData		; get note data
	lsr
	lsr
	lsr
	tay			; save in Y for offset
	txa			; recover note data
	and #7
	ldx TempNote		; recover current note
	bne .NoHold		; reset envelope if no note hold
	clc			; otherwise...
	adc NoteLenNTSC-1,y	; add last note's length to envelope offset
.NoHold	tay
	lda (MusicPtr),y	; get new volume for voice X
	ldx TempX		; recover voice number
	sta AUDV0,x		; set new volume for voice X
	rts



UpdateNote

	inc NoteData		; move to the next step of this note
	lda NoteData
	and #7
	tay
	bit Variation
	bpl .PAL
	cmp NoteLenNTSC,y	; check for end of note in NTSC mode
	bne .Same
	beq .NTSC
.PAL	cmp NoteLenPAL,y	; check for end of note in PAL mode
	bne .Same		; branch if note not over yet
.NTSC	lda NoteData		; otherwise...
	and #$F8		; reset 3 low bits of NoteData
	clc
	adc #1<<3		; step forward to the next note length
	cmp #18<<3
	bne .NoRoll
	lda #0			; roll note length counter after 18 notes
.NoRoll	sta NoteData
	inc MusicNote		; step forward to the next note
.Same	rts

