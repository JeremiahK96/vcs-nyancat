; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; We are currently at cycle 37 in the current scanline.



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Output 4 blank scanlines, while setting up the graphics objects.

PreKernel:

    sta.w CurrentRow	; 41
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Clear the RAM for the rainbow colors - 123 cycles

    ldy #4
.ClearRainbow
    pha
    pha
    pha
    pha
    pha
    pha
    pha
    pha
    
    dey
    bne .ClearRainbow
    
    pha
    pha		; 12
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load the rainbow colors into RAM - 65 cycles

    ldx #255-20
    txs
    
    lda RainbowColors+5
    pha
    pha
    lda RainbowColors+4
    pha
    pha
    lda RainbowColors+3
    pha
    pha
    lda RainbowColors+2
    pha
    pha
    lda RainbowColors+1
    pha
    pha
    lda RainbowColors+0
    pha
    pha			; 01



    ; Player 0 is already aligned for drawing the cat's face.
    
    ; Align player 1 to draw the current frame's food items for the top row.
    
    ; food item can be placed anywhere from 0-88
    ; RESP1 can be strobed on cycle 27/32/37/42/47/52
    
    ldy CurrentRow	; 04 - get the row we are drawing
    lda FoodPosX,y	; 08 - get the food's position for this row
    
    sec			; 10
.DivideLoop
    sbc #15		; 12
    bcs .DivideLoop	; 14
    
    eor #7		; 16
    adc #1		; 18
    asl			; 20
    asl			; 22
    asl			; 24
    
    sta RESP1		; 27
    
    asl			; 29
    
    sta HMP1		; 32
    
    lda #ONE_COPY
    sta NUSIZ0
    lda #TWO_WIDE
    sta NUSIZ1
    
    sta WSYNC
    
    lda ThrobColor+1
    sta COLUBK
    sta COLUPF



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 31 cycles

    lda PF_REFLECT
    sta CTRLPF
    
    lda Frame
    and #%00001000
    beq .Rainbow1
    
    lda #%01010000
    bne .Rainbow2
    
.Rainbow1
    SLEEP 2
    lda #%10100000

.Rainbow2
    sta PF0
    
    lda #COL_CAT_FACE
    sta COLUP0
    
    lda #$80
    sta HMP0
    
    SLEEP 30
    
    sta HMOVE
    
    SLEEP 3
    
    ; If any part of the cat needs to be drawn in the top row,
    ; skip straight to CatRows.


    include code/Gameplay Kernel/HiRows.asm
    include code/Gameplay Kernel/CatRows.asm
    include code/Gameplay Kernel/LoRows.asm
