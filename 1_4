; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Kernel (Blocks 1-3)
;
; This kernel draws blocks 1-3 of the cat in the menu display.
;
; 70 bytes
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; 16 bytes
	sta WSYNC		;	2
	lda #QUAD_SIZE		; 02	2
	sta.w NUSIZ0		; 06	3
	ldy #11			; 08	2
.LP	dey			; 59	1
	cpy #3			; 61	2
	bne .LP			; 63	2
	SLEEP 2			; 65	1
	jmp .Enter1_3		; 68	2

.Loop

	sta COLUBK		; 56	2
	sta WSYNC		; 00	2
	
	SLEEP 4			; 04	2
	bne .Skip		; 07	2

MenuCatKernel1_3

	; 10 bytes
	SLEEP 3			; 68	2
.Enter1_3
	sty ENABL		; 71	2
	ldx #3			; 73	2
	sta HMOVE		; 00	2
	
	; 4 bytes
	lda MenuCatTopGfxL,y	; 04	2
	sta GRP0		; 07	2

.Skip

	; 8 bytes
	lda RamBowColorsBk+16,y	; 11	2
	sta COLUBK		; 14	2
	lda (BowColorsPfPtr),y	; 19	2
	sta COLUPF		; 22	2
	
	; 8 bytes
	lda MenuCatTopGfxR,y	; 26	2
	sta GRP1		; 29	2
	lda MenuCatTopPf,y	; 33	2
	sta PF2			; 36	2
	
	; 17 bytes
	lda CatTartColor	; 39	2
	sta COLUBK		; 42	2
	lda MenuBgColor		; 45	2
	sta COLUPF		; 48	2
	dex			; 50	1
	bne .Loop		; 53/52	2
	ldx #DOUBLE_SIZE | MSL_SIZE_4
				; 54	2
	sta COLUBK		; 57	2
	stx NUSIZ0		; 60	2
	
	; 5 bytes
	dey			; 62	1
	bne MenuCatKernel1_3	; 65/64	2


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Kernel (Block 4)
;
; This kernel draws block 4 of the cat in the menu display.
;
; ? bytes
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ldx #3			; 66	2
	
	lda MenuCatTopGfxL	; 69	2
	sta GRP0		; 72	2
	sta.w HMOVE		; 00	3
	
	SLEEP 3			; 03	2
.Loop4
	lda RamBowColorsBk+16	; 06	2
	sta COLUBK		; 09	2
	lda (BowColorsPfPtr),y	; 14	2
	sta COLUPF		; 17	2
	
	lda MenuCatTopGfxR	; 20	2
	sta GRP1		; 23	2
	
	stx HMP0		; 26	2
	stx HMBL		; 29	2
	
	SLEEP 6			; 36	4
	
	lda CatTartColor	; 39	2
	sta COLUBK		; 42	2
	lda MenuBgColor		; 45	2
	sta COLUPF		; 48	2
	
	sec			; 50	1
	dex			; 52	1
	
	sta.w COLUBK		; 56	3
	
	beq .Exit4		; 59/58	2
	sta WSYNC		; 00	2
	bne .Loop4		; 03	2

.Exit4
