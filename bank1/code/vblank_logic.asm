; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync and Logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	VERT_SYNC		; 11

	ldx #RamBowColorsBk+19
	lda Frame
	and #%00001000
	bne .Rainbow1
	lda #%11100000
	sta PF0
	lda #%11000001
	sta PF1
	lda #RamBowColorsBk+17
	sta BowColorsPfPtr
	jmp .Rainbow2
.Rainbow1
	dex
	lda #%11000000
	sta PF0
	lda #%11100000
	sta PF1
	lda #RamBowColorsBk+15
	sta BowColorsPfPtr
.Rainbow2
	lda #0
	sta BowColorsPfPtr+1

	lda MenuBgColor
	sta RamBowColorsBk-1
	sta RamBowColorsBk
	sta RamBowColorsBk+1
	sta RamBowColorsBk+18
	sta RamBowColorsBk+19
	sta RamBowColorsBk+20
	
	lda MenuCatFrame
	cmp #2
	bpl .Jmp2
	dex
.Jmp2
	txs

	ldx #0
	lda #%1000
	bit SWCHB
	bne .NtscMode
	ldx #8
.NtscMode

	lda MenuColors,x
	sta MenuBgColor
	inx
	lda MenuColors,x
	sta CatTartColor

	ldy #6
.SetBowColors
	lda MenuColors+1,x
	pha
	pha
	pha
	inx
	dey
	bne .SetBowColors

	ldx #RamMenuCatGfxR+15
	txs

; push graphics for GRP1
	lda #>MenuCatGfxPage1	; get 1st page of menu cat gfx
	sta MenuCatRamPtr+1	; and set pointer to this page
	ldx MenuCatFrame	; get animation frame
	lda MenuCatOffsetGfx,x	; get offset within page
	sta MenuCatRamPtr	; and set pointer address

	ldy #13
.LoopGfxR
	lda (MenuCatRamPtr),y	; get next byte of gfx
	pha			; and push to RAM
	dey
	bpl .LoopGfxR

	txa			; get animation frame
	asl			; multiply by 2
	tay
	lda MenuCatLowGfxR,y
	pha
	iny
	lda MenuCatLowGfxR,y
	pha

; push graphics for right copies of PF2
	lda MenuCatOffsetPf,x
	sta MenuCatRamPtr

	ldy #12
.LoopPfR
	lda (MenuCatRamPtr),y	; get next byte of gfx
	pha			; and push to RAM
	dey
	bpl .LoopPfR

	txa			; get animation frame
	asl			; multiply by 2
	tay
	lda MenuCatLowPfGfxR,y
	pha
	iny
	lda MenuCatLowPfGfxR,y
	pha
	sta MenuCatShift	; use highest bit for cat face shift

; push graphics for left copies of PF2
	txa			; get animation frame
	asl
	asl
	asl
	sec
	sbc MenuCatFrame
	asl			; multiply by 14 (clears carry flag)
	sta MenuCatFrameX14	; save to reuse later
	adc #<MenuCatPfL	; add graphics table offset
	sta MenuCatRamPtr	; and set pointer address

	ldy #14
.LoopPfL
	lda (MenuCatRamPtr),y
	pha
	dey
	bpl .LoopPfL

; push graphics for GRP0
	lda #>MenuCatGfxPage2	; get 2nd page of menu cat gfx
	sta MenuCatRamPtr+1	; and set pointer to this page
	lda MenuCatFrameX14	; get animation frame times 14
	sta MenuCatRamPtr	; and set pointer address

	ldy #13
.LoopGfxL
	lda (MenuCatRamPtr),y
	pha
	dey
	bpl .LoopGfxL

; prepare graphics pointers for kernel
	lda #>MenuCatGfxPage1
	sta MenuCatHmvPtrP+1
	sta MenuCatMslPtr+1
	lda #>MenuCatGfxPage2
	sta MenuCatHmvPtrM+1

	lda MenuCatFrameX14	; get animation frame times 14
	cpx #5
	bne .NotFrame5
	sec
	sbc #14
.NotFrame5
	clc
	adc #<MenuCatHmoveP
	sta MenuCatHmvPtrP
	lda MenuCatFrameX14	; get animation frame times 14
	sec
	sbc MenuCatFrame	; adjust to times 13
	cpx #0
	beq .Frame0
	sec
	sbc #13
.Frame0
	clc
	adc #<MenuCatHmoveM
	sta MenuCatHmvPtrM
	ldy #<MenuCatMslGfx
	cpx #5
	bne .Not5
	dey
.Not5
	sty MenuCatMslPtr

	TIMER_LOOP
