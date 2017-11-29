; Draw the two rows that contain the cat.
CatRows:

    ; Output a line to finish the bottom of a "throb" line, like in HiRows.
    ; If the cat is at the very top of the row, draw the top of the pop-tart.
    
    lda ThrobColor+0
    sta COLUBK
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Cat Row Kernel
;
; This is the subroutine that is used to draw the two gameplay kernel rows
; containing the cat. It does not draw the throbbing line between the two rows,
; it only draws a single, 14-scanline row with the cat and food items.
; This subroutine is called twice in the kernel, once for each of the two rows
; containing the cat.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

DrawCatRow:	SUBROUTINE
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ldx FoodColor2
    txs
    
    ldx #COL_BACKGROUND
    
    ; Then output the 14 lines to draw a single row. This will include drawing
    ; the rainbow, the pop-tart, the head and face or paws, and the food items.
    ; All graphics will be updated every line.
    
    ldy #13
    
    ;17
    
    lda #%11100000
    sta PF1
    
    SLEEP 30
    ;jmp .KernelLoop2
    
    dec TartGfxPtr
    dec CatGfxPtr
    SLEEP 6
    jmp .KernelLoop1

    ALIGN $100
    
.KernelLoop1
    
    ; 7 cycles to prepare PF rainbow colors
    lda RamBowColors+1,y; 75
    sta COLUPF		; 02
    
    ; 7 cycles to prepare BK rainbow colors
    lda RamBowColors,y	; 06
    sta COLUBK		; 09
    
    ; 14 cycles to prepare 1st food item's graphics
    lda (FoodGfxPtr1),y	; 14
    sta GRP1		; 17
    lda FoodColor1	; 20
    sta COLUP1		; 23

    ; 5 cycles to set tart color
    lda #COL_CAT_TART	; 25
    sta COLUPF		; 28
    
    ; 3 cycles to clear BK color to black
    ; x is pre-loaded with 0, the color black
    stx COLUBK		; 31
    
    ; 8 cycles to prepare cat face graphics
    lda (CatGfxPtr),y	; 36
    sta GRP0		; 39
    
    ; 8 cycles to prepare tart graphics
    lda (TartGfxPtr),y	; 44
    sta PF1		; 47
    
    ; 13 cycles to prepare 2nd food item's graphics
    lda (FoodGfxPtr2),y	; 52
    tsx			; 54
    sta GRP1		; 57
    stx COLUP1		; 60
    
    ; 6 cycles to clear PF color to black
    ldx #COL_BACKGROUND	; 62
    stx.w COLUPF	; 66
    
    ; 5 cycles to finish the loop mechanism
    dey			; 68
    bpl .KernelLoop1	; 71/70
    
    ; exactly 76 cycles total
    
    jmp .Nanny
    
    



.KernelLoop2
    
    ; 8 cycles to prepare cat face graphics
    lda (CatGfxPtr),y	; 60
    sta GRP0		; 63
    
    ; 14 cycles to prepare 1st food item's graphics
    lda (FoodGfxPtr1),y	; 68
    sta GRP1		; 71
    lda FoodColor1	; 74
    sta COLUP1		; 01
    
    ; 7 cycles to prepare PF rainbow colors
    lda RamBowColors+1,y; 05
    sta COLUPF		; 08
    
    ; 7 cycles to prepare BK rainbow colors
    lda RamBowColors,y	; 12
    sta COLUBK		; 15
    
    ; 8 cycles to prepare tart graphics
    lda (TartGfxPtr),y	; 20
    sta PF1		; 23
    
    ; 5 cycles to set tart color
    lda #COL_CAT_TART	; 25
    sta COLUPF		; 28
    
    ; 3 cycles to clear BK color to black
    ; x is pre-loaded with 0, the color black
    stx COLUBK		; 31
    
    ; 13 cycles to prepare 2nd food item's graphics
    lda (FoodGfxPtr2),y	; 36
    tsx			; 38
    sta GRP1		; 41
    stx COLUP1		; 44
    
    ; 6 cycles to clear PF color to black
    ldx #COL_BACKGROUND	; 46
    stx.w COLUPF	; 50
    
    ; 5 cycles to finish the loop mechanism
    dey			; 52
    bpl .KernelLoop2	; 55/54
    
    ; exactly 76 cycles total
    
.Nanny

    sta WSYNC
    
    inc CurrentRow
    
    stx GRP1

    


    ; Then output the 5 lines to draw a "throb" line, but also draw the entire
    ; cat with the rainbow. In order to align player 1 for the next row's
    ; food items, it will be neccesary to have three versions of this kernel,
    ; one for each of the three 60-color-clock spaced positions to reset.
    ; HMOVE will be written to on the first four scanlines. With a maximum
    ; movement of 15 color-clocks per scanline, this will allow a movement of
    ; up to 60 color clocks. With three versions of the kernel, it should be
    ; possible to put player 1 anywhere on the screen.
    
    lda ThrobColor+0
    sta COLUBK
    ldx #0
    stx GRP0
    stx GRP1
    
    ldx #$FF
    txs
    
    sta WSYNC
    
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
    
    ; Then output 14 lines to draw the next row, exactly the same way as the
    ; previous one. It will be neccesary to have multiple versions of this, as well,
    ; since GRP1 needs to be updated at the correct time depending on the position
    ; of player 1.
    
    lda #COL_BACKGROUND
    sta COLUBK
    
    ldy #14
.Loop3
    sta WSYNC
    dey
    bne .Loop3
    
    ; Lastly, output only one line (not four) to draw the top of a "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is the last row, skip over LoRows.
    
    lda ThrobColor+0
    sta COLUBK
    sta WSYNC
    
    ; If the cat is at the very bottom of the screen, don't disable the
    ; missile/player graphics until after they are drawn, so they don't get
    ; clipped at the bottom of the screen. An easy way to do this would be to
    ; simply disable them after they would have been drawn, whether they are
    ; already disabled or not.



