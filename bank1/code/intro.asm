; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Intro music sequence
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

Intro
	lda #250
	sta MusicNote

.Oscan	SET_OSCAN_TIMER 0
	TIMER_LOOP
	VERT_SYNC

	lda MusicNote
	bpl .Music

	ldx #8
	cmp #252
	beq .Click
	dex
	cmp #253
	beq .Click

	lda #0
	sta AUDV0
	beq .NoEcho

.Click	lda #$1F
	sta AUDV0
	lda #$8
	sta AUDC0
	stx AUDF0
	bne .NoEcho

.Music	lda #>IntroSeq
	sta MusicPtr+1
	lda #<IntroSeq
	sta MusicPtr
	ldx #0
	jsr SetNote
	lda #<IntroVlm
	sta MusicPtr
	jsr SetVolume
	
	lda MusicNote
	cmp #2
	bmi .NoEcho

	lda #<IntroSeq-2
	sta MusicPtr
	ldx #1
	jsr SetNote
	lda #<IntroVlm
	sta MusicPtr
	jsr SetVolume
	lsr
	lsr
	sta AUDV1

.NoEcho	jsr UpdateNote

	TIMER_LOOP

	ldx #193
.Loop	dex
	sta WSYNC
	bne .Loop

	lda MusicNote
	cmp #32
	beq .End
	jmp .Oscan

.End	stx MusicNote

