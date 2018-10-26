; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Prep
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Positions the graphics objects for the giant Nyan Cat display on the menu.
;
; Uses 64 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SLEEP 13		; 15

	lda #$10		; 17
	sta HMP1		; 20	left 9 clocks
	asl			; 22	A = #$20
	sta HMBL		; 25	left 10 clocks
	sta HMM1		; 28	left 10 clocks
	ldy #$80		; 30
	sty HMP0		; 33	no movement
	lda #$90		; 35

	sta RESBL		; 38
	sta HMM0		; 41	left 1 clock
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
	sta VDELP0		; 71	enable VDELP0
	sta HMOVE		; 74	cycle 74!

	nop			; 00
	asl			; 02	A = #$62
	ldx #$E0		; 04
	sta HMP0		; 07	left 6 clocks
	stx HMM0		; 10	right 2 clocks
	stx HMP1		; 13	right 2 clocks
	stx HMM1		; 16	right 2 clocks
	sty HMBL		; 19	no movement
