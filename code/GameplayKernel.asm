    
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #$00
    ;sta PF0
    sta PF1

    ldx #6
KernelLoopA	; draw the gameplay display
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC	; draw a row
    sta WSYNC

    dey
    bne KernelLoopC
    
    ; draw a row seperator
    

    ldy ThrobFrame
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+2,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC


    dex
    bne KernelLoopA


    lda #COL_BACKGROUND
    sta COLUBK
    
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
