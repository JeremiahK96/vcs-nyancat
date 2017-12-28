; Stack pointer is pre-loaded with 2nd food item's color
; Playfield must be set to MIRRORED mode

			; 47
    lda FoodPosX,y	; 51
    cmp #48		; 53
    
    ldx #0		; 55
    ldy #13		; 57
    
    bcc .RightEntrance	; 60/59
    bcs .LeftEntrance	; 62

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the right edge of the screen
; 51 bytes
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.RightLoop
    
    ; 8 cycles
    lda (CatGfxPtr),y	; 49 - set cat's head gfx
    sta GRP0		; 52
    
    ; 9 cycles
    stx GRP1		; 55 - set 2nd food item's gfx no sooner than cycle 55
    tsx			; 57 - load 2nd food item's color
    stx COLUP1		; 60 - set 2nd food item's color no later than cycle 60
    
.RightEntrance		; enter loop here
    
    ; 2 cycles
    ldx #0		; 62 - X register must be set to 0 (black)
    
    ; 8 cycles
    lda (CatTartGfx),y	; 67 - load cat's tart gfx
    sta PF1		; 70 - set cat's tart gfx
    
    ; 8 cycles
    lda (FoodGfxPtr1),y	; 75 - set 1st food item's gfx
    sta GRP1		; 02
    
    ; 7 cycles
    lda RamBowColors+1,y; 06 - set playfield's rainbow color
    sta COLUPF		; 09
    
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
    
    lda (FoodGfxPtr2),y	; 48
    ldx #0		; 50
    beq .End		; 53

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel used when food items are closer to the left edge of the screen
; 47 bytes
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
.LeftLoop
    
    ; 8 cycles
    lda (CatGfxPtr),y	; 54 - set cat's head gfx
    sta GRP0		; 57
    
    ; 5 cycles
    ldx #0		; 59 - X must be set to 0 (black)
    stx COLUPF		; 62 - don't draw rainbow/tart on right side

.LeftEntrance		; enter loop here
    
    ; 8 cycles
    lda (TartGfxPtr),y	; 67 - load cat's tart gfx
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

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

.End
