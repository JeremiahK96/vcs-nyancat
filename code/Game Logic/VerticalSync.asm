; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync
;
; Do the vertical sync and start the vertical blanking timer
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #2
    sta WSYNC
    sta VSYNC	; enable VSYNC
    
    sta WSYNC
    lda #VBLANK_TIMER
    sta WSYNC
    sta TIM64T	; start VBLANK timer
    
    sta HMCLR	; clear HMOVE offsets
    sta CXCLR	; clear collision latches
    
    lda #0
    sta WSYNC
    sta VSYNC	; disable VSYNC
