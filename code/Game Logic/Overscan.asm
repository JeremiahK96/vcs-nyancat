; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:

    lda #OVERSCAN_TIMER
    sta WSYNC
    sta TIM64T	; 3



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Update Score
;
; Add to the score
;
; Takes 45 cycles to complete
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda BCDScoreAdd+1	; 3
    ldx BCDScoreAdd	; 3
    
    sed			; 2 - enable BCD mode
    
    clc			; 2
    sta Temp		; 3
    lda BCDScore+2	; 3
    adc Temp		; 3
    sta BCDScore+2	; 3
    stx Temp		; 3
    lda BCDScore+1	; 3
    adc Temp		; 3
    sta BCDScore+1	; 3
    lda #$00		; 2
    sta Temp		; 3
    lda BCDScore+0	; 3
    adc Temp		; 3
    sta BCDScore+0	; 3
    
    cld			; 2 - disable BCD mode



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
    lda INTIM
    bne OverscanTimerLoop
