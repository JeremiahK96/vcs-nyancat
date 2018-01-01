    MAC THROB_RAINBOW_BK
    
    SUBROUTINE

.X	SET {1}

    lda RamBowColors+.X	; 3
    bne .Rainbow	; 5/6
    
    stx COLUBK		; 8
    beq .End		; 11
    
.Rainbow
    sta COLUBK		; 9
    nop			; 11
    
.End

    ENDM

    MAC THROB_RAINBOW_PF
    
    SUBROUTINE

.X	SET {1}

    lda RamBowColors+.X	; 3
    bne .Rainbow	; 5/6
    
    stx COLUPF		; 8
    beq .End		; 11
    
.Rainbow
    sta COLUPF		; 9
    nop			; 11
    
.End

    ENDM
