; Draw all the rows above the cat's two rows
HiRows:		SUBROUTINE

    sta WSYNC
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF

    ; First, output a single-color line to draw the bottom of a "throb" line.
    ; This will probably be a good time to prepare the pointers for the
    ; food items' graphics, as well as loading the colors for the food items.
    
    ; After that, output 14 lines to draw a single row with food items,
    ; but without drawing the cat. The food graphics will be updated every line,
    ; but there will probably not be enough time to also update the food colors
    ; every line throughout the kernel.
    
    jsr DrawFoodRow	; 46
    
    sta WSYNC
    
    
    ; Lastly, output four single-color lines to draw most of a "throb" line,
    ; while setting the position of player 1 to draw the next set of food items.
    
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    lda #0
    sta GRP0
    sta GRP1
    sta WSYNC
    
    lda ThrobColor+1	; 03
    sta COLUBK		; 06
    sta COLUPF		; 09
    
    ldy CurrentRow	; 12 - get the row we are drawing
    lda FoodPosX,y	; 16 - get the food's position for this row
    
    sec			; 18
.DivideLoop
    sbc #15		; 20
    bcs .DivideLoop	; 22
    
    sta.w RESP1		; 26
    
    eor #7
    adc #1
    asl
    asl
    asl
    asl
    sta HMP1

    sta WSYNC
    
    lda ThrobColor+2	; 03
    sta COLUBK		; 06
    sta COLUPF		; 09
    
    jsr Sleep12
    jsr Sleep12
    jsr Sleep12
    jsr Sleep12
    jsr Sleep12		; 69
    
    sta.w HMOVE		; 73
    
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta COLUPF
    
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
    
    dec PreCatRows
    bne HiRows
    
    sta WSYNC
    
    SLEEP 2
    
    ; If this is not the last row before drawing the cat's rows,
    ; loop back to HiRows to draw the next row.
