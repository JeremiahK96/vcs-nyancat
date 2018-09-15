; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Kernel (Blocks 6-17)
;
; This kernel draws blocks 6-17 of the cat in the menu display.
; Every 3 scanlines, P0, M0, and M1 are moved, M0 is resized and either enabled
; or disabled, GRP0 and GRP1 are updated, and both rainbow colors are changed.
;
; 179 bytes
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ALIGN $100

MenuCatKernel6_17

	; 24 bytes
	lda RamMenuCatPfL+4,y	; 28	3 - get left PF2 copy gfx
	sta PF2			; 31	2 - set PF2
	lda #COL_CAT_FACE	; 33	2 - get cat face/tail/paws color
	ldx CatTartColor	; 36	2 - get cat body color
	sta COLUBK		; 39	2 - set cat face/tail/paws color
	stx.w COLUPF		; 43	3 - set cat body color
	lda RamMenuCatPfR+4,y	; 47	3 - get right PF2 copy gfx
	sta PF2			; 50	2 - set PF2
	lda MenuBgColor		; 53	2 - get BG color for palette (NTSC/PAL)
	sta COLUPF		; 56	2 - set both colors
	sta.w COLUBK		; 60	3 - to BG color

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

.Enter6_17	; enter sandman

	; 14 bytes
	lda RamMenuCatGfx	; 63	2 - get preloaded gfx
	sta GRP1		; 66	2 - use for P1
	lda RamMenuCatMissile	; 69	2 - get preloaded data
	sta ENAM0		; 72	2 - use bit #1 for M0 enable/disable
	sta HMOVE		; 75	2 - move objects
	and #%11111101		; 01	2 - clear bit 1 for correct NUSIZ value
	sta NUSIZ0		; 04	2 - set size of M0 (double player size)
	
	; 12 bytes
	lda RamBowColorsBk+3,y	; 08	3 - get this block's rainbow BG color
	sta COLUBK		; 11	2 - set BG color
	sta RainbowColorBk	; 14	2 - save for later
	lax (BowColorsPfPtr),y	; 19	2 - get this block's rainbow PF color
	stx COLUPF		; 22	2 - set PF color
	txs			; 24	1 - save for later

	; 26 bytes
	lda RamMenuCatPfL+3,y	; 28	3
	sta PF2			; 31	2
	lda #COL_CAT_FACE	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUBK		; 39	2
	stx.w COLUPF		; 43	3
	lda RamMenuCatPfR+3,y	; 47	3
	sta PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUPF		; 56	2
	sta.w COLUBK		; 60	3

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; 10 bytes
	lda (MenuCatHmvPtrM),y	; 65	2 - get next block's missile HMOVE data
	sta HMM0		; 68	2 - use left nybble for HMM0
	asl			; 70	1
	asl			; 72	1
	asl			; 74	1
	asl			; 00	1
	sta HMM1		; 03	2 - use right nybble for HMM1

	; 7 bytes
	lda RainbowColorBk	; 06	2 - recover BG rainbow color
	sta COLUBK		; 09	2 - set COLUBK
	tsx			; 11	1 - recover PF rainbow color
	stx COLUPF		; 14	2 - set COLUPF
	
	; 5 bytes
	lda (MenuCatHmvPtrP),y	; 19	2 - get next block's player HMOVE data
	sta HMP0		; 22	2 - set HMP0 (P1 isn't moved in kernel)
	nop			; 24	1

	; 26 bytes
	lda RamMenuCatPfL+3,y	; 28	3
	sta PF2			; 31	2
	lda #COL_CAT_FACE	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUBK		; 39	2
	stx.w COLUPF		; 43	3
	lda RamMenuCatPfR+3,y	; 47	3
	sta PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUPF		; 56	2
	sta.w COLUBK		; 60	3

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; 14 bytes
	lda RamMenuCatGfxL+2,y	; 64	3 - get next block's P0 gfx
	sta GRP0		; 67	2 - set GRP0 (VDELP0 is on)
	lda RamMenuCatGfxR+2,y	; 71	3 - get next block's P1 gfx
	sta RamMenuCatGfx	; 74	2 - save in RAM
	lda (MenuCatMslPtr),y	; 03	2 - get next block's M0 size/enable data
	sta RamMenuCatMissile	; 06	2 - save in RAM
	
	; 7 bytes
	lda RainbowColorBk	; 09	2
	sta COLUBK		; 12	2
	tsx			; 14	1
	stx COLUPF		; 17	2
	
	; 6 bytes
	dey			; 19	1 - dec y for next kernel block
	bmi .Exit		; 22/21	2 - branch out if done
	jmp MenuCatKernel6_17	; 24	3 - branch back if not

.Exit

	; 25 bytes
	jmp .Align6_17		; 25	2

	ALIGN $100
.Align6_17

	lda RamMenuCatPfL+3	; 28	2
	sta PF2			; 31	2
	lda #COL_CAT_FACE	; 33	2
	ldx CatTartColor	; 36	2
	sta COLUBK		; 39	2
	nop			; 41	1
	stx COLUPF		; 44	2
	lda RamMenuCatPfR+3	; 47	2
	sta PF2			; 50	2
	lda MenuBgColor		; 53	2
	sta COLUPF		; 56	2
	sta COLUBK		; 59	2
