; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Prep
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw the giant Nyan Cat display on the menu
; Uses ? bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SLEEP 13		; 15
	lda #$10		; 17
	sta HMP1		; 20
	asl			; 22
	sta HMBL		; 25
	sta HMM1		; 28
	lda #$80		; 30
	sta HMP0		; 33
	lda #$90		; 35

	sta RESBL		; 38
	sta HMM0		; 41
	sta RESP0		; 44
	sta RESM0		; 47
	sta RESM1		; 50
	sta RESP1		; 53

	lda #QUAD_SIZE		; 55
	sta NUSIZ0		; 58
	lda #DOUBLE_SIZE | MSL_SIZE_2
				; 60
	sta NUSIZ1		; 63
	lda #$31		; 65
	sta CTRLPF		; 68
	sta VDELP0		; 71
	sta HMOVE		; 74

	lda #$60
	ldx #$E0
	ldy #$80
	sta HMP0
	stx HMM0
	stx HMP1
	stx HMM1
	sty HMBL
