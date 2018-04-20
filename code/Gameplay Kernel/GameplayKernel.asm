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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
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
	
	jmp .Align1
	
	ALIGN $100
    
.Align1

PreKernel:
	
	sta WSYNC
	
	lda RamBowColors+19
	bne .SetCatThrobPF
	lda ThrobColor+0
.SetCatThrobPF
	sta CatThrobPF
	
	sta WSYNC
	
	SLEEP 2
	
	lda #$90		; 04
	sta HMP0		; 07
	
	lda #PF_REFLECT		; 09
	sta CTRLPF		; 12
	
	lda Rainbow		; 15
	sta PF0			; 18
	
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
	
	
	include code/Gameplay Kernel/HiRows.asm
	include code/Gameplay Kernel/CatRows.asm
	include code/Gameplay Kernel/LoRows.asm
