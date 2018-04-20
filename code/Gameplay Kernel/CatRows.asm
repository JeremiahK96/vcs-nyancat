; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Cat Row Kernel
;
; This is the kernel that is used to draw the two rows containing the cat.
; It also draw the throbbing line between the cat's rows.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

CatRows:

	SUBROUTINE
    
	sta WSYNC
	
	; Output a line to finish the bottom of a "throb" line, like in HiRows.
	
	ldx ThrobColor+0	; 03
	stx COLUBK		; 06
	stx COLUPF		; 09
	
	ldy #13			; 11
	lda (TartGfxPtr1),y	; 16
	sta PF1			; 19
	
	SLEEP 3			; 22
	lda CatTartColor	; 25
	sta COLUPF		; 28
	SLEEP 2			; 30
	stx COLUPF		; 33
	
	SUBROUTINE
	
	ldx CurrentRow		; 36
	lda FoodPosX,x		; 40
	
	jmp .Align2		; 43
	ALIGN $100
.Align2
	
	SLEEP 5			; 48
	
	ldx FoodColor2		; 51
	txs			; 53
	
	cmp #48			; 55
	
	ldx #0			; 57
	
	; Then output the 14 lines to draw a single row. This will include drawing
	; the rainbow, the pop-tart, the head and face or paws, and the food items.
	; All graphics will be updated every line.
	
	bcs .RightEntrance	; 60/59
	bcc .LeftEntrance	; 62
	
	; 14 bytes into the page

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the right edge of the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.RightLoop
	
	; 8 cycles
	lda (CatGfxPtr1),y	; 49 - set cat's head gfx
	sta GRP0		; 52
	
	; 9 cycles
	stx GRP1		; 55 - set 2nd food item's gfx no sooner than cycle 55
	tsx			; 57 - load 2nd food item's color
	stx COLUP1		; 60 - set 2nd food item's color no later than cycle 60
	
.RightEntrance			; enter loop here
	
	; 2 cycles
	ldx #0			; 62 - X register must be set to 0 (black)
	
	; 8 cycles
	lda (TartGfxPtr1),y	; 67 - load cat's tart gfx
	sta PF1			; 70 - set cat's tart gfx
	
	; 8 cycles
	lda (FoodGfxPtr1),y	; 75 - set 1st food item's gfx
	sta GRP1		; 02
	
	; 7 cycles
	lda RamBowColors+19,y	; 06 - set playfield's rainbow color
	sta COLUBK		; 09
	
	; 7 cycles
	lda RamBowColors+20,y	; 13 - set background's rainbow color
	sta COLUPF		; 16
	
	; 6 cycles
	lda FoodColor1		; 19 - set 1st food item's color
	sta COLUP1		; 22
	
	; 8 cycles
	lda CatTartColor	; 25
	sta COLUPF		; 28 - MUST set tart color at cycle 28
	stx COLUBK		; 31 - MUST set face/bg color to black at cycle 31
	stx COLUPF		; 34 - don't draw rainbow/tart on right side
	
	; 5 cycles
	lax (FoodGfxPtr2),y	; 39 - load 2nd food item's gfx before dey
	
	; 2 cycles
	dey			; 41
	bpl .RightLoop		; 44/43
	
	ldy #18			; 45
	lda (TartGfxPtr2),y	; 50
	
	SLEEP 2			; 52
	
	stx GRP1		; 55 - set 2nd food item's gfx no sooner than cycle 55
	tsx			; 57 - load 2nd food item's color
	stx COLUP1		; 60 - set 2nd food item's color no later than cycle 60
	
	bcs .End		; 63

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the left edge of the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.LeftLoop
	
	; 8 cycles
	lda (CatGfxPtr1),y	; 54 - set cat's head gfx
	sta GRP0		; 57
	
	; 5 cycles
	ldx #0			; 59 - X must be set to 0 (black)
	stx COLUPF		; 62 - don't draw rainbow/tart on right side

.LeftEntrance			; enter loop here
	
	; 8 cycles
	lda (TartGfxPtr1),y	; 67 - load cat's tart gfx
	sta PF1			; 70 - set cat's tart gfx
	
	; 8 cycles
	lda (FoodGfxPtr1),y	; 75 - load 1st food item's gfx
	sta GRP1		; 02 - set 1st food item's gfx
	
	; 7 cycles
	lda RamBowColors+19,y	; 06 - set rainbow colors
	sta COLUBK		; 09
	
	; 7 cycles
	lda RamBowColors+20,y	; 13
	sta COLUPF		; 16
	
	; 6 cycles
	lda FoodColor1		; 19 - set 1st food item's color
	sta COLUP1		; 22
	
	; 8 cycles
	lda CatTartColor	; 25
	sta COLUPF		; 28 - MUST set tart color at cycle 28
	stx COLUBK		; 31 - MUST set face/bg color to black at cycle 31
	
	; 13 cycles
	lda (FoodGfxPtr2),y	; 36 - load 2nd food item's gfx
	tsx			; 38 - load 2nd food item's color
	sta GRP1		; 41 - MUST set 2nd food item's gfx at cycle 41
	stx COLUP1		; 44 - MUST set 2nd food item's color at cycle 44
	
	; 5 cycles
	dey			; 46
	bpl .LeftLoop		; 49/48
	
	ldx #0			; 50
	stx COLUPF		; 53
	
	ldy #18			; 55
	lda (TartGfxPtr2),y	; 60
	
	stx GRP1		; 63

.End



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Then output the 5 lines to draw a "throb" line, but also draw the entire
; cat with the rainbow. In order to align player 1 for the next row's
; food items, it will be neccesary to have three versions of this kernel,
; one for each of the three 60-color-clock spaced positions to reset.
; HMOVE will be written to on the first four scanlines. With a maximum
; movement of 15 color-clocks per scanline, this will allow a movement of
; up to 60 color clocks. With three versions of the kernel, it should be
; possible to put player 1 anywhere on the screen.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw throb line #1
	
	sta PF1			; 66
	
	lda (CatGfxPtr2),y	; 71
	sta GRP0		; 74
	
	ldx ThrobColor+0	; 01
	
	THROB_RAINBOW_BK 18	; 12
	
	lda CatThrobPF		; 15
	sta COLUPF		; 18
	stx.w COLUP1		; 22
	
	lda CatTartColor	; 25
	sta COLUPF		; 28
	stx COLUBK		; 31
	
	dey			; 33
	sta RESP1		; 36
	stx COLUPF		; 39
	
	lda (CatGfxPtr2),y	; 44
	sta GRP0		; 47
	
	lda (TartGfxPtr2),y	; 52
	sta PF1			; 55
	
	dec CurrentRow		; 60
	ldx #0			; 62
	stx GRP1		; 65

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw throb line #2
	
	lda CatRowHmove+2	; 68
	sta HMP1		; 71
	SLEEP 2			; 73
	
	ldx ThrobColor+1	; 00
	THROB_RAINBOW_BK 17	; 11
	THROB_RAINBOW_PF 18	; 22
	
	lda CatTartColor	; 25
	sta COLUPF		; 28
	stx COLUBK		; 31
	stx COLUPF		; 34
	
	dey			; 36
	
	ldx CurrentRow		; 39
	lda FoodPosX,x		; 43
	cmp #45			; 45
	bpl .RightSide		; 48/47
	SKIP_WORD		; 51
.RightSide
	sta RESP1		; 51
	
	lda (CatGfxPtr2),y	; 56
	sta GRP0		; 59
	
	lda (TartGfxPtr2),y	; 64
	sta PF1			; 67
	SLEEP 3			; 70
	sta HMOVE		; 73

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw throb line #3
	
	ldx ThrobColor+2	; 00
	THROB_RAINBOW_BK 16	; 11
	THROB_RAINBOW_PF 17	; 22
	
	lda CatTartColor	; 25
	sta COLUPF		; 28
	stx COLUBK		; 31
	stx COLUPF		; 34
	
	dey			; 36
	
	lda (CatGfxPtr2),y	; 41
	sta GRP0		; 44
	
	lda (TartGfxPtr2),y	; 49
	sta PF1			; 52
	
	lda CatRow2FoodL	; 55
	sta FoodGfxPtr1		; 58
	lda CatRow2FoodR	; 61
	sta FoodGfxPtr2		; 64
	
	lda CatRowHmove+1	; 67
	sta HMP1		; 70
	
	sta HMOVE		; 73

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw throb line #4
	
	ldx ThrobColor+1	; 00
	THROB_RAINBOW_BK 15	; 11
	THROB_RAINBOW_PF 16	; 22
	
	lda CatTartColor	; 25
	sta COLUPF		; 28
	stx COLUBK		; 31
	stx COLUPF		; 34
	
	dey			; 36
	
	lda (CatGfxPtr2),y	; 41
	sta GRP0		; 44
	
	lda (TartGfxPtr2),y	; 49
	sta PF1			; 52
	
	lda CatRow2Color1	; 55
	sta FoodColor1		; 58
	ldx.w CatRow2Color2	; 55
	txs			; 58
	
	lda CatRowHmove+0	; 67
	sta HMP1		; 70
	
	sta HMOVE		; 73

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Draw throb line #5
	
	SUBROUTINE
	
	ldx ThrobColor+0	; 00
	THROB_RAINBOW_BK 14	; 11
	THROB_RAINBOW_PF 15	; 22
	
	lda CatTartColor	; 25
	sta COLUPF		; 28
	stx COLUBK		; 31
	stx COLUPF		; 34
	
	dey			; 36
	
	lda (CatGfxPtr2),y	; 41
	sta GRP0		; 44
	
	ldx CurrentRow		; 47
	lda FoodPosX,x		; 51
	cmp #48			; 53
	
	ldx #0			; 55
	nop			; 57
	
	; Then output the 14 lines to draw a single row. This will include drawing
	; the rainbow, the pop-tart, the head and face or paws, and the food items.
	; All graphics will be updated every line.
	
	bcs .RightEntrance	; 60/59
	bcc .LeftEntrance	; 62
	
	; 14 bytes into the page

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the right edge of the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.RightLoop
	
	; 8 cycles
	lda (CatGfxPtr2),y	; 49 - set cat's head gfx
	sta GRP0		; 52
	
	; 9 cycles
	stx GRP1		; 55 - set 2nd food item's gfx no sooner than cycle 55
	tsx			; 57 - load 2nd food item's color
	stx COLUP1		; 60 - set 2nd food item's color no later than cycle 60
    
.RightEntrance			; enter loop here
	
	; 2 cycles
	ldx #0			; 62 - X register must be set to 0 (black)
	
	; 8 cycles
	lda (TartGfxPtr2),y	; 67 - load cat's tart gfx
	sta PF1			; 70 - set cat's tart gfx
	
	; 8 cycles
	lda (FoodGfxPtr1),y	; 75 - set 1st food item's gfx
	sta GRP1		; 02
	
	; 7 cycles
	lda RamBowColors,y	; 06 - set playfield's rainbow color
	sta COLUBK		; 09
	
	; 7 cycles
	lda RamBowColors+1,y; 13 - set background's rainbow color
	sta COLUPF		; 16
	
	; 6 cycles
	lda FoodColor1		; 19 - set 1st food item's color
	sta COLUP1		; 22
	
	; 8 cycles
	lda CatTartColor	; 25
	sta COLUPF		; 28 - MUST set tart color at cycle 28
	stx COLUBK		; 31 - MUST set face/bg color to black at cycle 31
	stx COLUPF		; 34 - don't draw rainbow/tart on right side
	
	; 5 cycles
	lax (FoodGfxPtr2),y	; 39 - load 2nd food item's gfx before dey
	
	; 2 cycles
	dey			; 41
	bpl .RightLoop		; 44/43
	
	ldy #18			; 45
	lda (TartGfxPtr2),y	; 50
	
	SLEEP 2			; 52
	
	stx GRP1		; 55 - set 2nd food item's gfx no sooner than cycle 55
	tsx			; 57 - load 2nd food item's color
	stx COLUP1		; 60 - set 2nd food item's color no later than cycle 60
	
	bcs .End		; 63

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the left edge of the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.LeftLoop
	
	; 8 cycles
	lda (CatGfxPtr2),y	; 54 - set cat's head gfx
	sta GRP0		; 57
	
	; 5 cycles
	ldx #0			; 59 - X must be set to 0 (black)
	stx COLUPF		; 62 - don't draw rainbow/tart on right side

.LeftEntrance			; enter loop here
	
	; 8 cycles
	lda (TartGfxPtr2),y	; 67 - load cat's tart gfx
	sta PF1			; 70 - set cat's tart gfx
	
	; 8 cycles
	lda (FoodGfxPtr1),y	; 75 - load 1st food item's gfx
	sta GRP1		; 02 - set 1st food item's gfx
	
	; 7 cycles
	lda RamBowColors,y	; 06 - set rainbow colors
	sta COLUBK		; 09
	
	; 7 cycles
	lda RamBowColors+1,y	; 13
	sta COLUPF		; 16
	
	; 6 cycles
	lda FoodColor1		; 19 - set 1st food item's color
	sta COLUP1		; 22
	
	; 8 cycles
	lda CatTartColor	; 25
	sta COLUPF		; 28 - MUST set tart color at cycle 28
	stx COLUBK		; 31 - MUST set face/bg color to black at cycle 31
	
	; 13 cycles
	lda (FoodGfxPtr2),y	; 35 - load 2nd food item's gfx
	tsx			; 38 - load 2nd food item's color
	sta GRP1		; 41 - MUST set 2nd food item's gfx at cycle 41
	stx COLUP1		; 44 - MUST set 2nd food item's color at cycle 44
	
	; 5 cycles
	dey			; 46
	bpl .LeftLoop		; 49/48
	
	ldx #0			; 50
	stx COLUPF		; 53
	
	ldy #18			; 55
	lda (TartGfxPtr2),y	; 60

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

.End
	
	ldx #$FF		; 65
	txs			; 67
	
	ldx #0
	
	; Lastly, output only one line (not four) to draw the top of a "throb" line.
	; Use this time to prepare the next row's food item pointers (unless this is
	; the last row). If this is the last row, skip over LoRows.
	
	sta WSYNC
	lda ThrobColor+0
	sta COLUBK
	sta COLUPF
	stx GRP1
	SLEEP 18
	stx GRP0
	
	dec CurrentRow
	bmi .GpEnd
	
	; If the cat is at the very bottom of the screen, don't disable the
	; missile/player graphics until after they are drawn, so they don't get
	; clipped at the bottom of the screen. An easy way to do this would be to
	; simply disable them after they would have been drawn, whether they are
	; already disabled or not.
	
	jmp LoRows
    
.GpEnd
	jmp GameplayEnd
	
	ALIGN $100
	
	include subroutines/DrawFoodRow.asm
    
