; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync and Logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	VERT_SYNC

	lda #$A4		; 05
	sta MenuBgColor		; 08
	lda #$5A		; 10
	sta CatTartColor	; 13
	lda #QUAD_SIZE		; 15
	sta NUSIZ0		; 18
	lda #DOUBLE_SIZE | MSL_SIZE_2	; 20
	sta NUSIZ1		; 23

	lda #$31		; 25
	sta CTRLPF		; 28
	sta VDELP0		; 31
	asl			; 33
	sta RESBL
	SLEEP 3
	sta.w RESP0
	sta RESM1
	sta RESM0
	sta RESP1

	lda #$40
	sta HMBL
	lda #$D0
	sta HMP0
	lda #$E0
	sta HMM1
	lda #$70
	sta HMM0
	lda #$60
	sta HMP1

	sta WSYNC
	sta HMOVE
	sta WSYNC
	sta HMCLR

	lda #$60
	sta HMP0
	lda #$E0
	sta HMM0
	sta HMP1
	sta HMM1
	lda #$80
	sta HMBL

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

	lda #$44
	pha
	pha
	pha
	lda #$38
	pha
	pha
	pha
	lda #$1C
	pha
	pha
	pha
	lda #$CA
	pha
	pha
	pha
	lda #$A8
	pha
	pha
	pha
	lda #$76
	pha
	pha
	pha

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
