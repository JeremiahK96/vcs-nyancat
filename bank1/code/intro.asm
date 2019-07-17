; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Intro music sequence
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Intro

	lda #250
	sta MusicNote

.IntroOscan
	SET_OSCAN_TIMER
	TIMER_LOOP

	VERT_SYNC

	lda MusicNote
	bpl .IntroMusic

	ldx #8
	cmp #252
	beq .IntroClick
	dex
	cmp #253
	beq .IntroClick

	lda #0
	sta AUDV0
	beq .NoEcho

.IntroClick
	lda #$1F
	sta AUDV0
	lda #$8
	sta AUDC0
	stx AUDF0
	bne .NoEcho

.IntroMusic
	lda #>IntroSeq
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
.IntroLoop
	dex
	sta WSYNC
	bne .IntroLoop

	lda MusicNote
	cmp #32
	beq .IntroEnd
	jmp .IntroOscan

.IntroEnd
	stx MusicNote

