; Draw all the rows above the cat's two rows
HiRows:

    ; First, output a single-color line to draw the bottom of a "throb" line.
    ; This will probably be a good time to prepare the pointers for the
    ; food items' graphics, as well as loading the colors for the food items.
    
    lda ThrobColor+0	; 02
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
    
    ldy #13		; 49
    lda #COL_BACKGROUND	; 51
    
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
    
    lda FoodPosX,y	; 24
    sec			; 26
    
    lda (FoodGfxPtr2),y ;5
    sta GRP1		;8
    lda FoodColor2	;11
    sta COLUP1		;14
    
    
    
    ldy 14
.Loop1
    sta WSYNC
    dey
    bne .Loop1
    
    ; Lastly, output four single-color lines to draw most of a "throb" line,
    ; while setting the position of player 1 to draw the next set of food items.
    
    lda ThrobColor+0
    sta COLUBK
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta WSYNC
    
    lda ThrobColor+2
    sta COLUBK
    ldx #0
    stx GRP0
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    
    dec PreCatRows
    sta WSYNC
    bne HiRows
    
    ; If this is not the last row before drawing the cat's rows,
    ; loop back to HiRows to draw the next row.
