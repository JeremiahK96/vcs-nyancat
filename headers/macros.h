; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Start Bank
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Takes an integer for the bank
;
; Placed at the start of each bank
; Sets the bank's ROM location, and adds the global jump table
;
; Uses 18 bytes of ROM for the jump table
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
	jmp GameplayInit
JmpMenuTxtBtm
	nop SelectBank3
	jmp MenuTxtBtm
JmpMenuBottom
	nop SelectBank1
	jmp MenuBottom

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End Bank
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Takes an integer for the bank
;
; Placed at the end of each bank
; Pads the remaining space in the 4K bank, and defines the system vectors
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC END_BANK
	ORG [{1} - 1] * $1000 + $0FFA

	.word JmpInitSystem	; NMI
	.word JmpInitSystem	; RESET
	.word JmpInitSystem	; IRQ

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Set Overscan Timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Sets and starts the timer for the overscan
;
; Uses 13 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SET_OSCAN_TIMER
	SUBROUTINE

	lda #OSCAN_PAL + {1}
	bit Variation
	bpl .PAL
	lda #OSCAN_NTSC + {1}
.PAL	sta WSYNC
	sta TIM64T		; set overscan timer

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Performs a vertical sync, and starts the timer for vertical blanking
;
; Uses 22 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC VERT_SYNC
	SUBROUTINE

	ldx #VBLANK_PAL		; TIM64T value for PAL mode
	bit Variation
	bpl .PAL
	ldx #VBLANK_NTSC	; TIM64T value for NTSC mode
.PAL	lda #%1110
.Loop	sta WSYNC
	sta VSYNC
	sta VBLANK
	stx TIM64T
	lsr
	bne .Loop

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Timer Loop
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Loops until the timer runs down
; Used to finish vertical blanking and overscan
;
; Uses 5 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC TIMER_LOOP
	SUBROUTINE

.Loop	lda INTIM
	bne .Loop		; loop until end of vertical blanking

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Throb Rainbow Background
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Checks the background color, and if black, the throb color is used instead
; The throb color must be pre-loaded into the X register
;
; Uses 11 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC THROB_RAINBOW_BK
	SUBROUTINE
.X	SET {1}

	lda RamBowColors+.X	; 3
	bne .Rbow		; 5/6
	stx COLUBK		; 8
	beq .End		; 11
.Rbow	sta COLUBK		; 9
	nop			; 11
.End
	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Throb Rainbow Playfield
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Checks the playfield color, and if black, the throb color is used instead
; The throb color must be pre-loaded into the X register
;
; Uses 11 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC THROB_RAINBOW_PF
	SUBROUTINE
.X	SET {1}

	lda RamBowColors+.X	; 3
	bne .Rbow		; 5/6
	stx COLUPF		; 8
	beq .End		; 11
.Rbow	sta COLUPF		; 9
	nop			; 11
.End
	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Jump to Next Page
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Jumps to the beginning of the next page, padding the end of the current one
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC NEXT_PAGE
	SUBROUTINE

	jmp .NextPage
	ALIGN $100
.NextPage

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Skip Byte
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Gives a name to the opcode $08, which is a 2-cycle nop,
; skipping the next byte of ROM.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SKIP_BYTE
	HEX 80
	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Skip Word
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Gives a name to opcode $0C, which is a 4-cycle nop,
; skipping the next two bytes of ROM.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SKIP_WORD
	HEX 0C
	ENDM
