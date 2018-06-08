; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Placed at the start of each bank
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC START_BANK
	
	SEG BANK_{1}
	
	ORG [{1} - 1] * $1000
	RORG $1000
	
	SUBROUTINE

JmpInitSystem
	nop SelectBank1
	jmp InitSystem
JmpMenuOverScan
	nop SelectBank1
	jmp MenuOverScan
JmpGamePlay
	nop SelectBank2
	jmp SystemClear
	
	ENDM



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Placed at the end of each bank to set the system vectors
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC END_BANK

	ORG [{1} - 1] * $1000 + $0FFA
	
	.word JmpInitSystem	; NMI
	.word JmpInitSystem	; RESET
	.word JmpInitSystem	; IRQ
	
	ENDM



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Checks the background's rainbow color for the current scanline,
; and if it is black, the throb color is instead used.
; The throb color must be pre-loaded into the X register.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC THROB_RAINBOW_BK
	SUBROUTINE
.X	SET {1}

	lda RamBowColors+.X	; 3
	bne .Rainbow		; 5/6
	
	stx COLUBK		; 8
	beq .End		; 11
    
.Rainbow
	sta COLUBK		; 9
	nop			; 11

.End
	ENDM
	
	

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Checks the playfield's rainbow color for the current scanline,
; and if it is black, the throb color is instead used.
; The throb color must be pre-loaded into the X register.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC THROB_RAINBOW_PF
	SUBROUTINE
.X	SET {1}
	
	lda RamBowColors+.X	; 3
	bne .Rainbow		; 5/6
	
	stx COLUPF		; 8
	beq .End		; 11
	
.Rainbow
	sta COLUPF		; 9
	nop			; 11
    
.End
	ENDM



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; This macro simply gives a name to opcode $0C, which is a 4-cycle nop,
; skipping the next two bytes of ROM.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SKIP_WORD
	
	HEX 0C
	
	ENDM
