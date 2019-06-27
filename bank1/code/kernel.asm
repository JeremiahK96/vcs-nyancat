; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	sta WSYNC

	include bank1/code/menuscore.asm

	include bank1/code/menucat_prep.asm

	lda MenuCatFrame
	cmp #2
	bmi .HiCat
	sta WSYNC
	sta WSYNC
	sta WSYNC
.HiCat	sta WSYNC
	nop			; 02

	NEXT_PAGE

	include bank1/code/menucat1_4.asm
	include bank1/code/menucat5.asm
	include bank1/code/menucat6_17.asm
	include bank1/code/menucat18.asm
	include bank1/code/menucat19_20.asm

	lda MenuCatFrame
	cmp #2
	bpl .LoCat
	sta WSYNC
	sta WSYNC
	sta WSYNC
.LoCat	sta WSYNC

	ldy #62
.Loop8
	dey
	sta WSYNC
	bne .Loop8

	jmp MenuOverScan

