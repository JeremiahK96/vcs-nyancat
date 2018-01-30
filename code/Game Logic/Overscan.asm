; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Overscan
;
; Start the overscan timer and do game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Overscan:
	
	inc Frame	; increment the frame number
	
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

	lda BCDScoreAdd+1
	ldx BCDScoreAdd
	
	sed
	
	clc
	sta Temp
	lda BCDScore+2
	adc Temp
	sta BCDScore+2
	stx Temp
	lda BCDScore+1
	adc Temp
	sta BCDScore+1
	lda #$00
	sta Temp
	lda BCDScore+0
	adc Temp
	sta BCDScore+0
	
	cld



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Finish Overscan
;
; Loop until the end of overscan
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

OverscanTimerLoop
	lda INTIM
	bne OverscanTimerLoop
