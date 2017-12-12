; Draw all the rows below the cat's two rows.
LoRows:		SUBROUTINE

    ; Output 4 lines, drawing the rest of the "throb" line, while preparing
    ; player 1 for the next row's food items.
    
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
    
    ; Output 14 lines to draw a row, exactly the same as in HiRows.
    ; It may be possible to code this as a subroutine to save ROM space.
    
    lda #COL_BACKGROUND	; 02
    sta COLUBK		; 05
    sta COLUPF		; 08
    
    ldy CurrentRow	; 11
    
    lda FoodItemL,y	; 15
    and #$F0		; 17
    sta FoodGfxPtr1	; 20
    tax			; 22
    lda FoodGfx+14,x	; 26
    sta FoodColor1	; 29
    
    lda FoodItemR,y	; 33
    and #$F0		; 36
    sta FoodGfxPtr2	; 38
    tax			; 40
    lda FoodGfx+14,x	; 44
    sta FoodColor2	; 47
    
    lda FoodPosX,y	; 51
    sta Temp		; 54
    
    ldy #13		; 56
    
.FrootLoop
    lda #COL_BACKGROUND
    sta WSYNC
    
    
    ; After that, output 14 lines to draw a single row with food items,
    ; but without drawing the cat. The food graphics will be updated every line,
    ; but there will probably not be enough time to also update the food colors
    ; every line throughout the kernel.
    
    
    sta COLUBK		; 03
    sta COLUPF		; 06
    
    lda (FoodGfxPtr1),y	; 11
    sta GRP1		; 14
    lda FoodColor1	; 17
    sta COLUP1		; 20
    
    lda Temp		; 23
    
    sec			; 25
.WaitLoop
    sbc #23		; 27
    bcs .WaitLoop	; 29
    
    lda (FoodGfxPtr2),y ; 34
    ldx FoodColor2	; 37
    sta GRP1		; 40
    stx COLUP1		; 43
    
    dey
    bpl .FrootLoop
    
    inc CurrentRow
    
    sta WSYNC
    
    ; Lastly, output the a single line for the next "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is not the last row, loop to LoRows for the next row.
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    
    dec PostCatRows
    sta WSYNC
    bne LoRows
