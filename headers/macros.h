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
	jmp SystemClear

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
; Uses 7 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SET_OSCAN_TIMER

	lda #OVERSCAN_TIMER
	sta WSYNC
	sta TIM64T		; set overscan timer

	ENDM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Performs a vertical sync, and starts the timer for vertical blanking
; Also clears any values in the HMOVE registers
;
; Uses 22 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC VERT_SYNC

	lda #2
	sta WSYNC
	sta VSYNC		; enable VSYNC
	sta WSYNC
	ldx #VBLANK_TIMER
	sta WSYNC
	stx TIM64T		; set VBLANK timer
	sta HMCLR
	lsr
	sta WSYNC
	sta VSYNC		; 03 disable VSYNC

;	lda #%1110
;	ldx #VBLANK_TIMER
;.VsyncLoop
;	sta WSYNC
;	sta VSYNC		; enable VSYNC
;	stx TIM64T		; set VBLANK timer
;	lsr
;	bne .VsyncLoop

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

.TimerLoop
	lda INTIM
	bne .TimerLoop		; loop until end of vertical blanking

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
	bne .Rainbow		; 5/6
	stx COLUBK		; 8
	beq .End		; 11
.Rainbow
	sta COLUBK		; 9
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
	bne .Rainbow		; 5/6
	stx COLUPF		; 8
	beq .End		; 11
.Rainbow
	sta COLUPF		; 9
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
; Skip Word
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Gives a name to opcode $0C, which is a 4-cycle nop,
; skipping the next two bytes of ROM.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	MAC SKIP_WORD
	HEX 0C
	ENDM
