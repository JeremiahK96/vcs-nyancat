;

	ldy #1			; 66	2

MenuCatKernel19_20

	lda RamMenuCatGfxL,y	; 70	3
	sta GRP0		; 73	2
	sta HMOVE		; 00	2
	lda RamMenuCatGfxR,y	; 04	3
	sta GRP1		; 07	2
	
	lda RamBowColorsBk,y	; 11	3
	sta COLUBK		; 14	2
	lda (BowColorsPfPtr),y	; 19	2
	sta COLUPF		; 22	2
	lda RamMenuCatPfL,y	; 26	3
	sta PF2			; 29	2
	SLEEP 2			; 31	1
	
	lda #COL_CAT_FACE	; 33	2
	ldx MenuBgColor		; 36	2
	sta COLUBK		; 39	2
	stx.w COLUPF		; 43	3
	lda RamMenuCatPfR,y	; 47	3
	sta PF2			; 50	2
	
	sta HMCLR		; 53	2
	SLEEP 2			; 55	1
	
	stx COLUBK		; 58	2
	sta WSYNC		; 00	2
	
	lda RamBowColorsBk,y	; 04	3
	sta COLUBK		; 07	2
	lda (BowColorsPfPtr),y	; 12	2
	sta COLUPF		; 15	2
	lda RamMenuCatPfL,y	; 19	3
	sta PF2			; 22	2
	
	lda #$00		; 24	2
	sta HMP0		; 27	2
	sta.w HMP1		; 31	3
	
	lda #COL_CAT_FACE	; 33	2
	ldx MenuBgColor		; 36	2
	sta COLUBK		; 39	2
	stx.w COLUPF		; 43	3
	lda RamMenuCatPfR,y	; 47	3
	sta PF2			; 50	2
	
	lda #$20		; 52	2
	sta HMM0		; 55	2
	
	stx COLUBK		; 58	2
	sta WSYNC		; 00	2
	
	lda RamBowColorsBk,y	; 04	3
	sta COLUBK		; 07	2
	lda (BowColorsPfPtr),y	; 12	2
	sta COLUPF		; 15	2
	lda RamMenuCatPfL,y	; 19	3
	sta PF2			; 22	2
	
	lda #$E0		; 24	2
	sta HMM1		; 27	2
	SLEEP 4			; 31	5
	
	lda #COL_CAT_FACE	; 33	2
	ldx MenuBgColor		; 36	2
	sta COLUBK		; 39	2
	stx.w COLUPF		; 43	3
	lda RamMenuCatPfR,y	; 47	3
	sta PF2			; 50	2
	
	SLEEP 5			; 55	3
	
	stx.w COLUBK		; 59	3
	
	dey			; 61	1
	bmi .Exit19_20		; 64/63	2
	jmp MenuCatKernel19_20	; 66	2

.Exit19_20

	lda #0
	sta GRP0
	sta GRP1
	sta ENAM0
	sta ENAM1
