; The rainbow will be drawn using both the playfield (PF0) and the background.

; The pop-tart will be a single-color rectangle drawn with PF1.

; The cat's head and front paws will be drawn with player 0.

; All the food items will be drawn with player 1. It's NUSIZ will be set to
; 2 copies wide, and it will use flicker to draw up to 4 food items per row,
; 2 for each frame.



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; We are currently at cycle 40 in the current scanline.



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Output 4 blank scanlines, while setting up the graphics objects.

PreKernel:

    sta CurrentRow	; 43 - reset row counter ('A' still contains zero)
    
    lda #>FoodGfx	; 45 - prepare MSB's for both food graphics pointers
    sta FoodGfxPtr1+1	; 48 - (the LSB's will be calculated later,
    sta FoodGfxPtr2+1	; 51 - before each row is drawn)
    
    lda #<CatTartGfx
    sta TartGfxPtr
    lda #>CatTartGfx
    sta TartGfxPtr+1
    
    ldx #<RainbowColors
    stx RbowColPtr1
    inx
    stx RbowColPtr2
    
    lda #>RainbowColors
    sta RbowColPtr1+1
    sta RbowColPtr2+1
    
    lda Frame
    ror
    bcs .Do1
    
    lda #0
    jmp .Do2
    
.Do1
    rol
    and #$F0

.Do2
    sta FoodItemL
    sta FoodItemR
    
    lda #<CatFaceGfx
    sta CatGfxPtr
    lda #>CatFaceGfx
    sta CatGfxPtr+1
    
    lda #%10100000
    sta PF0
    
    lda #COL_CAT_FACE
    sta COLUP0
    
    ;lda #88
    
    lda Frame
    and #%00111111
    clc
    adc #24
    
    sta FoodPosX
    
    lda #$80
    sta HMP0
    
    ; Player 0 is already aligned for drawing the cat's face.
    
    ; Align player 1 to draw the current frame's food items for the top row.
    
    ; food item can be placed anywhere from 0-88
    ; RESP1 can be strobed on cycle 27/32/37/42/47/52
    
    sta WSYNC
    
    ldy CurrentRow	; 03 - get the row we are drawing
    lda FoodPosX,y	; 07 - get the food's position for this row
    
    sec			; 09
.DivideLoop
    sbc #15		; 11
    bcs .DivideLoop	; 13
    
    eor #7		; 15
    asl			; 17
    asl			; 19
    asl			; 21
    asl			; 23
    
    sta RESP1		; 26
    sta HMP1		; 29
    
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    
    lda #ONE_COPY
    sta NUSIZ0
    lda #TWO_WIDE
    sta NUSIZ1
    
    SLEEP 51
    
    jmp .KJump
    
    ALIGN $100
.KJump
    sta HMOVE
    SLEEP 3
    
    ; If any part of the cat needs to be drawn in the top row,
    ; skip straight to CatRows.



; Draw all the rows above the cat's two rows.
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
    ldx #COL_BACKGROUND
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    
    dec PreCatRows
    sta WSYNC
    bne HiRows
    
    ; If this is not the last row before drawing the cat's rows,
    ; loop back to HiRows to draw the next row.



; Draw the two rows that contain the cat.
CatRows:

    ; Output a line to finish the bottom of a "throb" line, like in HiRows.
    ; If the cat is at the very top of the row, draw the top of the pop-tart.
    
    lda ThrobColor+0
    sta COLUBK
    ldy #13
    
    SLEEP 57
    
    ; Then output the 14 lines to draw a single row. This will include drawing
    ; the rainbow, the pop-tart, the head and face or paws, and the food items.
    ; All graphics will be updated every line.
    
.KernelLoop
    ; 16 cycles to prepare rainbow colors
    lda (RbowColPtr1),y	; 5
    sta COLUPF		; 3
    lda (RbowColPtr2),y	; 5
    sta COLUBK		; 3
    
    ; 8 cycles to prepare cat face graphics
    lda (CatGfxPtr),y	; 5
    sta GRP0		; 3
    
    ; 8 cycles to prepare tart graphics
    lda (TartGfxPtr),y	; 5
    sta PF1		; 3
    
    ; 5 cycles to set tart color
    lda #COL_CAT_TART	; 2 (25)
    sta COLUPF		; 3 (28) MUST end on cycle 28
    
    ; 6 cycles to clear PF/BK colors to black
    ; x is pre-loaded with 0, the color black
    stx COLUBK		; 3 (31) MUST end on cycle 31
    stx COLUPF		; 3 (34)
    
    ; 14 cycles to prepare 1st food item's graphics
    lda (FoodGfxPtr1),y	; 5
    sta GRP1		; 3
    lda FoodColor1	; 3
    sta COLUP1		; 3
    
    ; 14 cycles to prepare 2nd food item's graphics
    lda (FoodGfxPtr2),y	; 5
    sta GRP1		; 3
    lda FoodColor2	; 3
    sta COLUP1		; 3
    
    ; 5 cycles to finish the loop mechanism
    dey			; 2
    bpl .KernelLoop	; 3
    
    ; exactly 76 cycles total



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
    stx GRP0
    stx GRP1
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
    
    ldy 14
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
    
