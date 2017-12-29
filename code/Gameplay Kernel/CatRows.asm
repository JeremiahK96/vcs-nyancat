; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Cat Row Kernel
;
; This is the subroutine that is used to draw the two gameplay kernel rows
; containing the cat. It does not draw the throbbing line between the two rows,
; it only draws a single, 14-scanline row with the cat and food items.
; This subroutine is called twice in the kernel, once for each of the two rows
; containing the cat.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

CatRows:	SUBROUTINE
    
    sta WSYNC

    ; Output a line to finish the bottom of a "throb" line, like in HiRows.
    ; If the cat is at the very top of the row, draw the top of the pop-tart.
    
    lda ThrobColor+0	; 03
    sta COLUBK		; 06
    sta COLUPF		; 09

    ldx FoodColor2	; 12
    txs			; 14
    
    SLEEP 27		; 41
    
    jmp .OnTheBed	; 44
    
    ALIGN $100
    
.OnTheBed
    ldy CurrentRow	; 47
    lda FoodPosX,y	; 51
    cmp #48		; 53
    
    ldx #0		; 55
    ldy #13		; 57
    
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
    
.RightEntrance		; enter loop here
    
    ; 2 cycles
    ldx #0		; 62 - X register must be set to 0 (black)
    
    ; 8 cycles
    lda (TartGfxPtr1),y	; 67 - load cat's tart gfx
    sta PF1		; 70 - set cat's tart gfx
    
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
    lda FoodColor1	; 19 - set 1st food item's color
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
    bpl .RightLoop	; 44/43
    
    ldy #18		; 45
    lda (TartGfxPtr2),y	; 50
    
    SLEEP 2		; 52
    
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
    ldx #0		; 59 - X must be set to 0 (black)
    stx COLUPF		; 62 - don't draw rainbow/tart on right side

.LeftEntrance		; enter loop here
    
    ; 8 cycles
    lda (TartGfxPtr1),y	; 67 - load cat's tart gfx
    sta PF1		; 70 - set cat's tart gfx
    
    ; 8 cycles
    lda (FoodGfxPtr1),y	; 75 - load 1st food item's gfx
    sta GRP1		; 02 - set 1st food item's gfx
    
    ; 7 cycles
    lda RamBowColors,y	; 06 - set rainbow colors
    sta COLUBK		; 09
    
    ; 7 cycles
    lda RamBowColors+1,y; 13
    sta COLUPF		; 16
    
    ; 6 cycles
    lda FoodColor1	; 19 - set 1st food item's color
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
    bpl .LeftLoop	; 49/48
    
    ldx #0		; 50
    stx COLUPF		; 53
    
    ldy #18		; 55
    lda (TartGfxPtr2),y	; 60
    
    stx GRP1		; 63

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

.End

    sta PF1		; 66
    
    lda (CatGfxPtr2),y	; 71
    sta GRP0		; 74



    ; Then output the 5 lines to draw a "throb" line, but also draw the entire
    ; cat with the rainbow. In order to align player 1 for the next row's
    ; food items, it will be neccesary to have three versions of this kernel,
    ; one for each of the three 60-color-clock spaced positions to reset.
    ; HMOVE will be written to on the first four scanlines. With a maximum
    ; movement of 15 color-clocks per scanline, this will allow a movement of
    ; up to 60 color clocks. With three versions of the kernel, it should be
    ; possible to put player 1 anywhere on the screen.
    
    ldx ThrobColor+0	; 01
    
    lda RamBowColors+0	; 04
    bne .DrawRainbowBK	; 06/07
    stx COLUBK		; 09
    beq .AfterBK	; 12
.DrawRainbowBK
    sta COLUBK		; 10
    SLEEP 2		; 12
.AfterBK
    
    lda CatThrobPF	; 15
    sta COLUPF		; 18
    
    SLEEP 4		; 22
    
    lda CatTartColor	; 25
    sta COLUPF		; 28
    stx COLUBK		; 31
    stx COLUPF		; 34
    
    ldx #0
    stx GRP1
    
    ldx #GAMEPLAY_STACK
    txs
    
    inc CurrentRow
    
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta COLUPF
    sta WSYNC
    
    lda ThrobColor+2
    sta COLUBK
    sta COLUPF
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta COLUPF
    sta WSYNC
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    sta WSYNC
    
    ; Then output 14 lines to draw the next row, exactly the same way as the
    ; previous one. It will be neccesary to have multiple versions of this, as well,
    ; since GRP1 needs to be updated at the correct time depending on the position
    ; of player 1.
    
    lda #COL_BACKGROUND
    sta COLUBK
    sta.w COLUPF
    
    ldy #14
.LoopdyLoop
    dey
    sta WSYNC
    bne .LoopdyLoop
    
    
    
    ; Lastly, output only one line (not four) to draw the top of a "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is the last row, skip over LoRows.
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    
    ; If the cat is at the very bottom of the screen, don't disable the
    ; missile/player graphics until after they are drawn, so they don't get
    ; clipped at the bottom of the screen. An easy way to do this would be to
    ; simply disable them after they would have been drawn, whether they are
    ; already disabled or not.
    
    jmp LoRows
    
    
    ALIGN $100
    
    include subroutines/DrawFoodRow.asm
    
