; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	sta WSYNC

	include bank1/code/menuscore.asm

	include bank1/code/menucat_prep.asm

	lda MenuCatFrame
	asl
	cmp #4
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
	asl
	cmp #4
	bpl .LoCat
	sta WSYNC
	sta WSYNC
	sta WSYNC
.LoCat	sta WSYNC

	include bank1/code/menu_bottom.asm

	jmp MenuOverScan

