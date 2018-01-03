; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Output 4 blank scanlines, while setting up the graphics objects.
; CPU is at cycle 33
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Clear last 34 bytes of RAM for rainbow colors - 126 cycles

    
    ldx #$FF
    txs
    
    ldy #17
.ClearRainbow
    pha
    pha
    
    dey
    bne .ClearRainbow
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load rainbow colors into RAM - 65 cycles

    lda #19
    sbc CatPosition	; carry is assumed to be set
    and #%00011111
    clc
    adc #RamBowColors+13
    tax
    txs
    
    ldy #5
    
.LoadRainbow
    lda RainbowColors,y
    pha
    pha
    
    dey
    bpl .LoadRainbow


    sta WSYNC
    
    lda ScoreColor
    sta.w COLUBK
    
    sta WSYNC
    
    SLEEP 4
    
    ; Player 0 is already aligned for drawing the cat's face.
    
    ; Align player 1 to draw the current frame's food items for the top row.
    
    ; food item can be placed anywhere from 0-88
    ; RESP1 can be strobed on cycle 27/32/37/42/47/52
    
    lda FoodPosX+6	; 07 - get the food's position for the top row
    
    sec			; 09
.DivideLoop
    sbc #15		; 11
    bcs .DivideLoop	; 13
    
    eor #7		; 15
    adc #1		; 17
    asl			; 19
    asl			; 21
    asl			; 23
    
    sta RESP1		; 26
    
    asl			; 53
    sta HMP1		; 56
    
    lda #ONE_COPY	; 58
    sta NUSIZ0		; 61
    lda #TWO_WIDE	; 63
    sta NUSIZ1		; 66
    
    lda #$80		; 68
    sta HMP0		; 71
    
    sta WSYNC
    
    jmp .Align1
    
    ALIGN $100
    
.Align1

PreKernel:
    ldx #6
    stx CurrentRow
        
    sta WSYNC
    
    lda RamBowColors+19
    bne .SetCatThrobPF
    lda ThrobColor+0
.SetCatThrobPF
    sta CatThrobPF
    
    sta WSYNC
    
    SLEEP 9

    lda #PF_REFLECT	; 11
    sta CTRLPF		; 14
    
    lda Rainbow		; 17
    sta PF0		; 20
    
    lda #COL_CAT_FACE	; 22
    sta COLUP0		; 25
    
    lda FoodItemL+6	; 28
    and #$F0		; 30
    sta FoodGfxPtr1	; 33
    tax			; 35
    lda FoodGfx+15,x	; 39
    sta FoodColor1	; 42
    
    lda FoodItemR+6	; 45
    and #$F0		; 47
    sta FoodGfxPtr2	; 50
    tax			; 52
    lda FoodGfx+15,x	; 56
    sta FoodColor2	; 59
    
    lda FoodPosX+6	; 62
    sta Temp		; 65
    
    ldx #GAMEPLAY_STACK	; 67
    txs			; 69
    
    sta.w HMOVE		; 73
    
    sta WSYNC
    
    lda ThrobColor+1	; 03
    sta COLUBK		; 06
    sta COLUPF		; 09
    
    lda PreCatRows
    bne HiRows
    jmp CatRows
    
    ; If any part of the cat needs to be drawn in the top row,
    ; skip straight to CatRows.


    include code/Gameplay Kernel/HiRows.asm
    include code/Gameplay Kernel/CatRows.asm
    include code/Gameplay Kernel/LoRows.asm
