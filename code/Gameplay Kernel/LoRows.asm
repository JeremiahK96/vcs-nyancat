; Draw all the rows below the cat's two rows.
LoRows:

    ; Output 4 lines, drawing the rest of the "throb" line, while preparing
    ; player 1 for the next row's food items.
    
    lda ThrobColor+1
    sta COLUBK
    sta WSYNC
    
    lda ThrobColor+2
    sta COLUBK
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta WSYNC
    
    lda ThrobColor+0
    sta COLUBK
    sta WSYNC
    
    ; Output 14 lines to draw a row, exactly the same as in HiRows.
    ; It may be possible to code this as a subroutine to save ROM space.
    
    lda #COL_BACKGROUND
    sta COLUBK
    
    ldy 14
.Loop4
    sta WSYNC
    dey
    bne .Loop4
    
    ; Lastly, output the a single line for the next "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is not the last row, loop to LoRows for the next row.
    
    lda ThrobColor+0
    sta COLUBK
    
    dec PostCatRows
    sta WSYNC
    bne LoRows
