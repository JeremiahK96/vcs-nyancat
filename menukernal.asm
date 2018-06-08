; first 4 pixels

	sta HMCLR
	ldy #19

.MenuCatKernel1_4

	sta WSYNC
	sta HMOVE		; 03
	
	lda RamBowColors+1,y	; 07
	sta COLUPF		; 10
	lda RamBowColors+0,y	; 14
	sta COLUBK		; 17
	
	lda MenuCatTopGfxL,y	; 21
	sta GRP1		; 24
	sta GRP1		; 27
	
	lda MenuCatTopPf,y	; 31
	sta PF2			; 34
	lda CatTartColor	; 37
	sta COLUPF		; 40
	
	ldx #3			; 42
	
.Loop
	sta WSYNC
	
	lda RamBowColors+1,y	; 04
	sta COLUPF		; 07
	lda RamBowColors+0,y	; 11
	sta COLUBK		; 14
	
	SLEEP 19		; 33
	
	lda CatTartColor	; 36
	sta COLUPF		; 39
	
	SLEEP 6			; 45
	
	lda MenuBgColor		; 48
	dex			; 50
	sta COLUBK		; 53
	sta COLUPF		; 56
	bne .Loop		; 58
	
	dey			; 60
	
	lda MenuCatTopGfxR,y	; 64
	sta GRP0		; 67
	
	cpy #15			; 69
	bne .MenuCatKernel1_4	; 71

; next 1 pixel

	stx HMP1		; 74

; next 12 pixels

.MenuCatKernel6_17
				; 58
	; 19 cycles
	lda RainbowBkColor	; 3
	sta RainbowPfColor	; 3
	sta COLUPF		; 3
	lda RamBowColors,y	; 4
	sta RainbowBkColor	; 3
	sta COLUBK		; 3
	
	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	stx.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	sta PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2
	
	
	
	; 19 cycles
	lda RainbowBkColor	; 3
	sta RainbowPfColor	; 3
	sta COLUPF		; 3
	lda RamBowColors,y	; 4
	sta RainbowBkColor	; 3
	sta COLUBK		; 3
	
	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	stx.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	sta PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2

.MenuCatKernel6_17

; draw 1st scanline for this "pixel"
	;	20 cycles	12 bytes
	ldx RamBowColors,y	; 67	2
	lda RamBowColors-1,y	; 71	2
	stx RainbowPfColor	; 74	2
	stx COLUPF		; 01	2
	sta RainbowBkColor	; 04	2
	sta COLUBK		; 07	2
	
	;	16 cycles	8 bytes
	lda (MenuCatGfxPtrL),y	; 12	2
	sta GRP0		; 15	2
	lda (MenuCatGfxPtrR),y	; 20	2
	sta MenuCatGfxR		; 23	2
	
	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	sta.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	stx PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2
	;	72 cycles	43 bytes

; draw 2nd scanline for this "pixel"
	;	8 cycles	4 bytes
	lda (MenuCatPfPtrR),y	; 64	2
	sta MenuCatPfR		; 67	2
	
	;	12 cycles	8 bytes
	ldx RainbowPfColor	; 70	2
	lda RainbowBkColor	; 73	2
	stx COLUPF		; 00	2
	sta COLUBK		; 03	2
	
	;	20 cycles	11 bytes
	lda (MenuHmoveP),y	; 08	2
	sta HMP0		; 11	2
	asl			; 13	1
	asl			; 15	1
	asl			; 17	1
	asl			; 19	1
	sta.w HMP1		; 23	3
	
	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	sta.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	stx PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2
	;	76 cycles	46 bytes

; draw 3rd scanline for this "pixel"
	;	8 cycles	4 bytes
	lda (MenuMissilePtr),y	; 64	2
	sta MenuMissile		; 67	2
	
	;	12 cycles	8 bytes
	ldx RainbowPfColor	; 70	2
	lda RainbowBkColor	; 73	2
	stx COLUPF		; 00	2
	sta COLUBK		; 03	2
	
	;	20 cycles	11 bytes
	lda (MenuHmoveM),y	; 08	2
	sta HMM0		; 11	2
	asl			; 13	1
	asl			; 15	1
	asl			; 17	1
	asl			; 19	1
	sta.w HMM1		; 23	3
	
	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	sta.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	stx PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2
	;	76 cycles	46 bytes

; draw 4th scanline for this "pixel"
	;	6 cycles	4 bytes
	lda MenuCatGfxR		; 62	2
	sta GRP1		; 65	2
	
	;	14 cycles	10 bytes
	lda MenuMissile		; 71	2
	sta ENAM0		; 74	2
	and #%11111101		; 00	2
	sta HMOVE		; 03	2
	sta NUSIZ0		; 06	2
	
	;	12 cycles	8 bytes
	ldx RainbowPfColor	; 09	2
	lda RainbowBkColor	; 12	2
	stx COLUPF		; 15	2
	sta COLUBK		; 18	2
	
	;	5 cycles	3 bytes
	ldx MenuCatPfR		; 21	2
	txs			; 23	1

	;	36 cycles	23 bytes
	lda (MenuCatPfPtrL),y	; 28	2
	sta PF2			; 31	2
	lda CAT_FACE_COLOR	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUPF		; 39	2
	sta.w COLUBK		; 43	3
	tsx			; 45	1
	nop			; 47	1
	stx PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUBK		; 56	2
	sta COLUPF		; 59	2
	;	76 cycles	50 bytes
	
; handle loop
	;	4 cycles	3 bytes
	dey			; 61	1
	bne .MenuCatKernel6_17	; 63/64	2
	;	4 cycles	3 bytes
	
	;	304 cycles	188 bytes

; next 1 pixel
; next 3 pixels
