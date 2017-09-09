; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:

    lda #OVERSCAN_TIMER
    sta WSYNC
    sta TIM64T
    
    
    inc Frame		; increment the frame number
    
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
    
; Set object positions for scoreboard kernel (extremely inefficiently)
    sta WSYNC
    lda #$B0
    sta HMP0
    lda #$C0
    sta HMP1
    SLEEP 14
    sta RESP0
    sta RESP1
    SLEEP 11
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
    lda Frame
    and #%00000111
    bne .SkipScoreInc

    lda #$21		; we are adding 21
    ldx #$00
    ldy #$00
    
    sed			; enable BCD mode
    clc
    sta Temp
    lda BCDScore+2
    adc Temp
    sta BCDScore+2
    stx Temp
    lda BCDScore+1
    adc Temp
    sta BCDScore+1
    sty Temp
    lda BCDScore+0
    adc Temp
    sta BCDScore+0
    
    clc
    lda BCDLevel
    adc #1
    sta BCDLevel
    
    cld		; disable BCD mode
.SkipScoreInc



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
    lda INTIM
    bne OverscanTimerLoop


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
;
; Do the vertical sync and start the vertical blanking timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #2
    sta WSYNC
    sta VSYNC	; enable VSYNC
    
    lda #VBLANK_TIMER
    sta WSYNC
    sta CXCLR
    sta WSYNC
    sta TIM64T	; start VBLANK timer
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Blank
;
; Do the vertical blanking and game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE

    lda #6		; start with bottom of digit graphics data
    sta TempLoop

.Loop

; push level counter graphics data
    lda BCDLevel	; get level counter
    and #$0F		; isolate left nybble/digit
    asl
    asl
    asl			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda LevelGfx,y
    pha
    
    ldx #2		; start with rightmost BCD score value
    			; (we must push to stack in reverse of drawing order)
.DigitLoop

; right nybble
    lda BCDScore,x	; get current BCD value (contains 2 digits)
    and #$0F		; isolate right nybble/digit
    asl
    asl
    asl			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda ScoreGfx,y
    pha
    
; left nybble
    lda BCDScore,x	; get current BCD value (contains 2 digits)
    and #$F0		; isolate left nybble/digit
    lsr			; digit value * 8
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda ScoreGfx,y
    pha

    dex
    bpl .DigitLoop
    
    dec TempLoop
    bpl .Loop



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
