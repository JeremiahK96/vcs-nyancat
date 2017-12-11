; Draw all the rows above the cat's two rows
HiRows:

    ; First, output a single-color line to draw the bottom of a "throb" line.
    ; This will probably be a good time to prepare the pointers for the
    ; food items' graphics, as well as loading the colors for the food items.
    
    lda ThrobColor+0	; 02
    sta COLUBK		; 05
    
    ldy CurrentRow	; 08
    lda FoodItemL,y	; 12
    and #$F0		; 14
    sta FoodGfxPtr1	; 17
    tax			; 19
    lda FoodGfx+14,x	; 23
    sta FoodColor1	; 26
    
    lda FoodItemR,y	; 30
    and #$F0		; 32
    sta FoodGfxPtr2	; 35
    tax			; 37
    lda FoodGfx+14,x	; 41
    sta FoodColor2	; 44
    
    
    sta WSYNC
    
    ; After that, output 14 lines to draw a single row with food items,
    ; but without drawing the cat. The food graphics will be updated every line,
    ; but there will probably not be enough time to also update the food colors
    ; every line throughout the kernel.
    
    lda #COL_BACKGROUND
    sta COLUBK
    
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
