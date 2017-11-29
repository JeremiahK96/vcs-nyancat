; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; We are currently at cycle 47 in the current scanline.



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Output 4 blank scanlines, while setting up the graphics objects.

PreKernel:

    sta CurrentRow
    
    lda PF_REFLECT
    sta CTRLPF
    
    lda #>FoodGfx
    sta FoodGfxPtr1+1
    sta FoodGfxPtr2+1
    
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
    
    lda #$50
    sta FoodItemL
    lda #$90
    sta FoodItemR
    
    lda #<CatFaceGfx
    sta CatGfxPtr
    lda #>CatFaceGfx
    sta CatGfxPtr+1
    
    lda #%10100000
    sta PF0
    
    lda #COL_CAT_FACE
    sta COLUP0
    
    lda Frame
    and #%00111111
    
    lda #88
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
    adc #1
    asl			; 17
    asl			; 19
    asl			; 21
    
    sta RESP1		; 26
    
    asl			; 23
    
    sta HMP1		; 29
    
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    
    lda #ONE_COPY
    sta NUSIZ0
    lda #TWO_WIDE
    sta NUSIZ1
    
    SLEEP 54
    
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
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    
    dec PreCatRows
    sta WSYNC
    bne HiRows
    
    ; If this is not the last row before drawing the cat's rows,
    ; loop back to HiRows to draw the next row.



    include code/Gameplay Kernel/CatRowKernel.asm



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
    
