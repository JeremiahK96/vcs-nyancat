; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Health Display
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw the health indicator and progress bar
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

	sta WSYNC
	lda ThrobColor+1	; 03	
	sta COLUBK		; 06

	lda #0			; 08
	sta PF0			; 11
	sta CTRLPF		; 14
	sta COLUP0		; 17
	sta COLUP1		; 20

	lda #DOUBLE_SIZE	; 22
	sta NUSIZ0		; 25
	sta NUSIZ1		; 28
	lda #$80 + REFP_TRUE	; 30
	sta REFP1		; 33
	sta HMP1		; 36
	ldx #$FF		; 38
	stx HMP0		; 41

	stx ProgressBar+1	; 44
	stx ProgressBar+2	; 47
	stx ProgressBar+3	; 50
	dex			; 52
	stx ProgressBar+4	; 55
	ldx #$E0		; 57
	stx ProgressBar+0	; 60

	lda #COL_CAT_FACE	; 62
	sta RESP0		; 65
	sta RESP1		; 68
	sta COLUPF		; 71
	sta HMOVE		; 74

	lda ScoreColor		; 01
	sta COLUBK		; 04

; Load RAM for progress bar display (28-53 cycles)

	lda Progress		; 3 - get amount of progress

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; The level progress bar uses the following playfield bits:
; (note that PF0 and PF2 are NOT reversed in this diagram)
;
; *PF0*  *PF1*    *PF2*  *PF0*  *PF1*
; ^^^^ ^^^^^^^^ ^^^^^^^^ ^^^^ ^^^^^^^^	X = bit used
; oXXX XXXXXXXX XXXXXXXX XXXX XXXXXXXo	o = bit not used
;
; When the progress bar is empty, every bit labeled "X" above should be
; set (1), and when it is full, every "X" bit should be cleared (0).
; The bits labeled "o" must ALWAYS be cleared.
;
; The leftmost playfield value (the 1st PF0) will be calculated first,
; and then each playfield value to the right until the 2nd PF1
; will be calculated.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ldy #%00000000	; 2 - value to store when a playfield byte is full

	sec		; 2
	sbc #3		; 3 - 3 PF bits in 1st PF0 are used, so subtract 3
	bmi .Underflow1	; 2/3
	sty ProgressBar	; 3 - this playfield byte is full

	sbc #8		; 3 - 8 PF bits in 1st PF1 are used, so subtract 8
	bmi .Underflow2	; 2/3
	sty ProgressBar+1	; 3 - this playfield byte is full

	sbc #8		; 3 - 8 PF bits in PF2 are used, so subtract 8
	bmi .Underflow3	; 2/3
	sty ProgressBar+2	; 3 - this playfield byte is full

	sbc #4		; 3 - 4 PF bits in 2nd PF1 are used, so subtract 4
	bmi .Underflow4	; 2/3
	sty ProgressBar+3	; 3 - this playfield byte is full

	tax		; 2
	lda PgBarGfx+1,x; 4 - load from normal set of playfield graphics
	asl		; 2
	sta ProgressBar+4	; 3
	jmp .Finish	; 3

.Underflow1	; for 1st PF0
	adc #3			; 3 - add back the 3
	tax			; 2
	lda PgBarGfxR+5,x	; 4 - load from reversed set of playfield graphics
	sta ProgressBar		; 3
	jmp .Finish		; 3

.Underflow2	; for 1st PF1
	adc #8			; 3 - add back the 8
	tax			; 2
	lda PgBarGfx,x		; 4 - load from normal set of playfield graphics
	sta ProgressBar+1	; 3
	jmp .Finish		; 3

.Underflow3	; for PF2
	adc #8			; 3 - add back the 8
	tax			; 2
	lda PgBarGfxR,x		; 4 - load from reversed set of playfield graphics
	sta ProgressBar+2	; 3
	jmp .Finish		; 3

.Underflow4	; for 2nd PF0
	adc #4			; 3 - add back the 4
	tax			; 2
	lda PgBarGfxR+4,x	; 4 - load from reversed set of playfield graphics
	sta ProgressBar+3	; 3

.Finish				; 57

	ldy #4
	sta WSYNC

; draw top of health
.HealthTop	
	ldx #3			; 02
.Loop
	sta WSYNC
	lda HealthTopGfx,y	; 04
	sta GRP0		; 07
	sta GRP1		; 10
	lda #$00		; 12
	sta PF2			; 15

; Set the pointers for health graphics - 26 cycles
	clc			; 17
	lda #>HealthLeftGfx	; 19
	sta HthGfxLPtr+1	; 22
	sta HthGfxRPtr+1	; 25
	lda #<HealthLeftGfx	; 27
	adc Health		; 30
	sta HthGfxLPtr		; 33
	lda #<HealthRightGfx	; 35
	adc Health		; 38
	sta HthGfxRPtr		; 41
	lda HealthBgGfx+8,y	; 45
	sta PF2			; 48

	dex			; 50
	bne .Loop		; 52

	dey			; 54
	bpl .HealthTop		; 56

	SUBROUTINE

	ldy #3			; 58
	ldx #3			; 60
	stx Temp		; 63

	jmp .HealthMiddle	; 66
	ALIGN $100		; align to page
    
; draw middle of health, with progress bar
.HealthMiddle
	sta WSYNC
.Loop
	lda ProgressBar+0	; 03 - get the 1st playfield register value
	sta PF0			; 06 - for the progress bar and set it
	lda ProgressBar+1	; 09 - get the 2nd playfield register value
	sta PF1			; 12 - for the progress bar and set it
	lda ProgressBar+2	; 15 - get the 3rd playfield register value
	sta PF2			; 18 - for the progress bar and set it
	lda PgBarColor		; 21 - get the progress bar color
	sta COLUBK		; 24 - and set it at cycle 24
	lda ProgressBar+3	; 27 - get the 4th playfield register value
	sta PF0			; 30 - for the progress bar and set it
	lda (HthGfxLPtr),y	; 35 - get/set the graphics
	sta GRP0		; 38 - for the left half of health
	lda (HthGfxRPtr),y	; 43 - get/set the graphics
	sta GRP1		; 46 - for the right half of health
	lda ProgressBar+4	; 49 - get the 5th playfield register value
	sta PF1			; 52 - for the progress bar and set it
	lda #%01111111		; 54 - get the 6th playfield register value
	sta PF2			; 57 - for the health background and set it
	lda ScoreColor		; 60 - get the color for the background
	sta.w COLUBK		; 64 - and set it at cycle 64

	dex			; 66
	bne .HealthMiddle	; 68

	ldx Temp		; 71
	dey			; 73
	bpl .Loop		; 76 / 00

	SUBROUTINE

	lda #0
	sta PF0
	sta PF1
	ldy #7

; draw bottom of health
.HealthBottom
	ldx #3
.Loop
	lda (HthGfxLPtr),y
	sta GRP0
	lda (HthGfxRPtr),y
	sta GRP1
	lda #$00
	sta PF2
	SLEEP 14
	lda HealthBgGfx-4,y
	sta PF2
	sta WSYNC

	dex
	bne .Loop

	dey
	cpy #3
	bne .HealthBottom

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	stx GRP0
	stx GRP1
	stx REFP1
	stx PF2

	sta WSYNC
