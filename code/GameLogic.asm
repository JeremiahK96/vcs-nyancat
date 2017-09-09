; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Waste time to finish the frame
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #OVERSCAN_TIMER
    sta TIM64T



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
    lda INTIM
    bne OverscanTimerLoop

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
    
    lda #VBLANK_TIMER
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

; Increment the frame number
    inc Frame
    
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
    lda Frame
    and #%00000000
    beq .SkipScoreInc

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
; Load Scoreboard
;
; Get graphics data for the scoreboard and push it onto the stack
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SUBROUTINE

    lda #7		; start with bottom of digit graphics
    sta TempLoop
.Loop
    ldx #5		; start with rightmost digit
    			; (we must push to stack in reverse of drawing order)
.DigitLoop
    cpx #2		; if this is not the 4th iteration of X loop
    bne .NotLevel	; then don't push level counter graphics
			; else, do push level counter graphics
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
.NotLevel
    ldy BCDOffset,x	; get byte offset for current BCD value
    txa			; get current digit
    lsr			; load bit 0 into carry flag to check if even/odd
    bcs .Odd		; branch if A was odd
;Even
    lda BCDScore,y	; get current BCD value (contains 2 digits)
    and #$F0		; isolate left nybble/digit
    lsr			; digit value * 8
    bcc .GetGfx		; always taken
.Odd
    lda BCDScore,y	; get current BCD value (contains 2 digits)
    and #$0F		; isolate right nybble/digit
    asl
    asl
    asl			; digit value * 8
    
.GetGfx
    			; no need to clc, carry will always be clear
    adc TempLoop
    tay
    lda ScoreGfx,y
    pha
    
    dex
    bpl .DigitLoop
    
    dec TempLoop
    bpl .Loop
    
    SUBROUTINE
    


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Vertical Blanking
;
; Loop until the end of vertical blanking
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

VblankTimerLoop
    lda INTIM
    bne VblankTimerLoop
