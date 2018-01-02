; Draw all the rows below the cat's two rows.

LoRows:		SUBROUTINE
    
    sta WSYNC

    ; Output 4 lines, drawing the rest of the "throb" line, while preparing
    ; player 1 for the next row's food items.
    
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
    sta WSYNC
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    
    ldy CurrentRow	; 11
    
    lda FoodItemL,y	; 15
    and #$F0		; 17
    sta FoodGfxPtr1	; 20
    tax			; 22
    lda FoodGfx+15,x	; 26
    sta FoodColor1	; 29
    
    lda FoodItemR,y	; 33
    and #$F0		; 36
    sta FoodGfxPtr2	; 38
    tax			; 40
    lda FoodGfx+15,x	; 44
    sta FoodColor2	; 47
    
    lda FoodPosX,y	; 51
    sta Temp		; 54
    
    
    
    ; Output 14 lines to draw a row, exactly the same as in HiRows.
    ; It may be possible to code this as a subroutine to save ROM space.
    
    jsr DrawFoodRow
    
    sta WSYNC
    
    ; Lastly, output a single line for the next "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is not the last row, loop to LoRows for the next row.
    
    lda ThrobColor+0
    sta COLUBK
    sta COLUPF
    lda #0
    sta GRP0
    sta GRP1
    
    dec CurrentRow
    bpl LoRows
    
    ldx #$FF
    txs
    
    sta WSYNC
    SLEEP 2
