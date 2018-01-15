; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; This macro looks at the background's rainbow color for this scanline,
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
; This macro looks at the playfield's rainbow color for this scanline,
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
