DrawFoodRow:
			; 69
    ldy #13		; 71
    
.FoodLoop
    lda #COL_BACKGROUND	; 73
    sta WSYNC		; 00
    
.EnterHere
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
    
    lda (FoodGfxPtr2),y ; 49
    ldx FoodColor2	; 52
    sta GRP1		; 55
    stx COLUP1		; 58
    
    dey			; 60
    bpl .FoodLoop	; 62
    
Sleep12
    rts			; 68
