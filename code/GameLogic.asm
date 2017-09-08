; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Waste time to finish the frame
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:

    ldy #29
FinishFrame
    sta WSYNC
    
    dey
    bne FinishFrame



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
;
; Do the vertical sync and start the vertical blanking timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #2
    sta WSYNC
    sta VSYNC	; enable VSYNC
    
    lda #45	; for the VBLANK timer
    sta WSYNC
    sta WSYNC
    sta TIM64T	; start VBLANK timer
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Prepare the NUSIZx, VDELPx and COLUPx values for the 6-digit score

    lda #THREE_CLOSE | MSL_SIZE_2
    sta NUSIZ0
    sta NUSIZ1
    
    lda #VDEL_TRUE
    sta VDELP0
    sta VDELP1
    
    lda #COL_SCORE
    sta COLUP0
    sta COLUP1
    sta COLUPF
    sta COLUBK
    
; Set player positions for 6-digit score (extremely inefficiently)
    sta WSYNC
    SLEEP 25
    sta RESP0
    sta RESP1
    lda #$F0
    sta HMP0
    SLEEP 4
    lda #$80
    sta HMBL
    lda #$80
    sta HMM0
    lda #$D0
    sta HMM1
    sta RESBL
    sta RESM0
    sta RESM1
    sta WSYNC
    sta HMOVE
    sta WSYNC
    sta HMCLR
    lda #$B0
    sta HMBL
    sta WSYNC
    sta HMOVE
    sta WSYNC
    sta HMCLR

; Increment the score
    inc TempLoop
    lda TempLoop
    and #%00000111
    bne .SkipScoreInc

    lda #$21		; we are adding 54,321
    ldx #$43
    ldy #$05
    
    sed			; enable BCD mode
    clc
    sta Temp
    lda BCDScore
    adc Temp
    sta BCDScore
    stx Temp
    lda BCDScore+1
    adc Temp
    sta BCDScore+1
    sty Temp
    lda BCDScore+2
    adc Temp
    sta BCDScore+2
    
    clc
    lda BCDLevel
    adc #1
    sta BCDLevel
    
    cld		; disable BCD mode
.SkipScoreInc

; Prepare gfx pointers for 6-digit score
    SUBROUTINE
    
    ldx #0		; leftmost bitmap pointer
    ldy #2		; start with most-significant BCD value
.Loop
    lda BCDScore,y	; get BCD value
    and #$F0		; isolate high nybble
    lsr			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>ScoreGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    lda BCDScore,y	; get BCD value (again)
    and #$0F		; isolate low nybble
    asl
    asl
    asl			; value * 8
    sta DigitPtr0,x	; store low byte
    lda #>ScoreGfx
    sta DigitPtr0+1,x	; store high byte
    inx
    inx			; next bitmap pointer
    dey
    bpl .Loop		; next BCD value

; Prepare gfx pointer for level counter
    lda BCDLevel
    and #$0F		; isolate right nybble
    asl
    asl
    asl
    clc
    adc #<LevelGfx
    sta LvlGfxPtr	; store low byte
    lda #>LevelGfx
    sta LvlGfxPtr+1	; store high byte

; Load stack with the gfx for the 6-digit score and level counter
    SUBROUTINE
    
    ldy #0
.LoadStack
    lda (DigitPtr3),y
    pha
    lda (DigitPtr4),y
    pha
    lda (DigitPtr5),y
    pha
    lda (LvlGfxPtr),y
    pha
    lda (DigitPtr2),y
    pha
    lda (DigitPtr1),y
    pha
    lda (DigitPtr0),y
    pha
    iny
    cpy #8
    bne .LoadStack
    
; Loop until the end of vertical blanking
VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
