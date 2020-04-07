; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Clear system registers and RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Uses 20 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

InitSystem:

; clear CPU and zeropage
	cld
	lxa #0
	tay
.ClearStack
	dex
	txs
	pha
	bne .ClearStack

	sta SWACNT
	sta SWBCNT

; check for forced 50hz mode
	lsr SWCHB	; reset switch state -> carry flag
	ror Variation	; write to D7

