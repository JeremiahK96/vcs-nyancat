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
    
    lda Frame
    and #%00001000
    beq .Rainbow1
    
    lda #%01010000
    bne .Rainbow2
    
.Rainbow1
    lda #%10100000

.Rainbow2
    sta PF0
    
    lda #COL_CAT_FACE
    sta COLUP0
    
    lda Frame
    and #%00111111
    
    dec FoodPosX
    bpl .NoReset
    lda #88
    sta FoodPosX
.NoReset
    
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


    include code/Gameplay Kernel/HiRows.asm
    include code/Gameplay Kernel/CatRows.asm
    include code/Gameplay Kernel/LoRows.asm
