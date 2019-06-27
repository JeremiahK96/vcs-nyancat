
				; 59
	sty ENAM0		; 62	2
	lda RamMenuCatGfx	; 65	2
	sta GRP1		; 68	2
	lda #$60		; 70	2
	sta HMP1		; 73	2
	sta HMOVE		; 00	2
	
	lda #DOUBLE_SIZE | MSL_SIZE_2
				; 02	2
	sta NUSIZ0		; 05	2

	lda RamBowColorsBk+2	; 08	2
	sta COLUBK		; 11	2
	sta COLUPF		; 14	2
	
	ldy #2			; 16	2
	nop			; 18	1
	ldx MenuBgColor		; 21	2
	txs			; 23	1

.Loop18
	
	lda RamMenuCatPfL+2	; 26	2
	sta PF2			; 29	2

	lda #COL_CAT_FACE	; 31	2
	ldx #0			; 33	2
	stx ENABL		; 36	2
	sta COLUBK		; 39	2
	stx COLUPF		; 42	2
	sta RESM0		; 45	2
	lda RamMenuCatPfR+2	; 48	2
	sta PF2			; 51	2
	tsx			; 53	1
	stx COLUPF		; 56	2
	stx COLUBK		; 59	2
	dey			; 61	1
	beq .Exit18		; 64/63	2
	
	SLEEP 8			; 71	2

	lda RamBowColorsBk+2	; 74	2
	sta COLUBK		; 01	2
	sta COLUPF		; 04	2
	
	sty RainbowColorBk	; 07
	ldy #13			; 09
	lda (MenuCatHmvPtrP),y	; 14
	sta HMP1		; 17
	ldy RainbowColorBk	; 20
	
	bne .Loop18		; 23	2

.Exit18				; 64

	sta WSYNC		; 00
	
	lda RamBowColorsBk+2	; 03
	sta COLUBK		; 06
	sta COLUPF		; 09
	
	lda BowColorsPfPtr	; 12
	sec			; 14
	sbc #3			; 16
	sta BowColorsPfPtr	; 19
	SLEEP 4			; 23
	
	lda RamMenuCatPfL+2	; 26	2
	sta PF2			; 29	2

	lda #COL_CAT_FACE	; 31	2
	ldx #0			; 33	2
	stx ENABL		; 36	2
	sta COLUBK		; 39	2
	stx COLUPF		; 42	2
	sta RESM0		; 45	2
	lda RamMenuCatPfR+2	; 48	2
	sta PF2			; 51	2
	tsx			; 53	1
	stx COLUPF		; 56	2
	stx COLUBK		; 59	2
	
	SLEEP 5			; 64
