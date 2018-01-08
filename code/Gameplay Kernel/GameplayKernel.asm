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

    lda #20
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
    
    SLEEP 2
    lda #$90
    sta HMP0

    lda #PF_REFLECT	; 09
    sta CTRLPF		; 12
    
    lda Rainbow		; 15
    sta PF0		; 18
    
    lda #COL_CAT_FACE	; 20
    sta COLUP0		; 23
    
    lda FoodItemL+6	; 26
    sta RESP0		; 29
    and #$F0		; 31
    sta FoodGfxPtr1	; 34
    tax			; 36
    lda FoodGfx+15,x	; 40
    sta FoodColor1	; 43
    
    lda FoodItemR+6	; 46
    and #$F0		; 48
    sta FoodGfxPtr2	; 51
    tax			; 53
    lda FoodGfx+15,x	; 57
    sta FoodColor2	; 60
    
    lda FoodPosX+6	; 63
    sta Temp		; 66
    
    ldx #GAMEPLAY_STACK	; 68
    txs			; 70
    
    sta HMOVE		; 73
    
    lda ThrobColor+1	; 03
    sta COLUBK		; 06
    sta COLUPF		; 09
    
    lda #$80		; 11
    sta HMP0		; 14
    
    lda PreCatRows
    bne HiRows
    jmp CatRows
    
    ; If any part of the cat needs to be drawn in the top row,
    ; skip straight to CatRows.


    include code/Gameplay Kernel/HiRows.asm
    include code/Gameplay Kernel/CatRows.asm
    include code/Gameplay Kernel/LoRows.asm
