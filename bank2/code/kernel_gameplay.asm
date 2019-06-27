; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Output 4 blank scanlines, while setting up the graphics objects.
; CPU is at cycle 33
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Clear last 34 bytes of RAM for rainbow colors - 126 cycles
	ldx #$FF
	txs

	ldy #17
.ClearRainbow
	pha
	pha
	dey
	bne .ClearRainbow

; Load rainbow colors into RAM - 65 cycles
	lda #20
	sbc CatPosition	; carry is assumed to be set
	and #%00011111
	clc
	adc #RamBowColors+13
	tax
	txs

	ldy #5
.LoadRainbow
	lda RainbowColors,y
	pha
	pha
	dey
	bpl .LoadRainbow

	lda #ONE_COPY
	sta NUSIZ0
	lda #TWO_WIDE
	sta NUSIZ1
	lda #6
	sta CurrentRow
	sta WSYNC

	lda ScoreColor
	sta COLUBK
	ldx #GAMEPLAY_STACK
	txs
	jsr SetFoodPosition
	sta WSYNC

	NEXT_PAGE

PreKernel
	sta WSYNC

	lda RamBowColors+19
	bne .SetCatThrobPF
	lda ThrobColor+0
.SetCatThrobPF
	sta CatThrobPF

	lda Frame
	and #%00001000
	lsr
	lsr
	lsr
	tay
	lda RainbowGfx,y
	sta PF0

	sta WSYNC

	SLEEP 8			; 08
	lda #$90		; 10
	sta HMP0		; 13
	lda #PF_REFLECT		; 15
	sta CTRLPF		; 18
	lda #COL_CAT_FACE	; 20
	sta COLUP0		; 23

	lda FoodItemL+6		; 26
	sta RESP0		; 29
	and #$F0		; 31
	sta FoodGfxPtr1		; 34
	tax			; 36
	lda FoodGfx+15,x	; 40
	sta FoodColor1		; 43

	lda FoodItemR+6		; 46
	and #$F0		; 48
	sta FoodGfxPtr2		; 51
	tax			; 53
	lda FoodGfx+15,x	; 57
	sta FoodColor2		; 60

	lda FoodPosX+6		; 63
	sta Temp		; 66
	SLEEP 4			; 70
	sta HMOVE		; 73

	lda ThrobColor+1	; 03
	sta COLUBK		; 06
	sta COLUPF		; 09
	lda #$80		; 11
	sta HMP0		; 14

	lda PreCatRows
	bne HiRows
	jmp CatRows

	; If any part of the cat needs to be drawn in the top row,
	; skip straight to CatRows.

	include bank2/code/kernel_hi_rows.asm
	include bank2/code/kernel_cat_rows.asm
	include bank2/code/kernel_lo_rows.asm
