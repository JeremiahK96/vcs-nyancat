; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #0
    sta WSYNC
    sta VBLANK	; enable display

    
    lda #PF_REFLECT | PF_PRIORITY | BALL_SIZE_2
    sta CTRLPF
    lda #$FF
    sta PF0
    lda #$C0
    sta PF1
    
    ldy #6
KernelLoop1
    sta WSYNC
    
    dey
    bne KernelLoop1
    
    
; Draw ball?
    SUBROUTINE
    
    lda #COL_SCOREBOARD
    sta COLUBK
    
    sta WSYNC
    lda #$80
    sta PF1
    sta WSYNC
    
    lda BCDLevel
    lsr
    lsr
    lsr
    sta ENABL	; draw ball if bit 4 is set (if level > 9)
    
    SLEEP 33

; 6-digit score and level counter display
    SUBROUTINE
.Loop
    pla			; 49 load B0 (1st sprite byte)
    sta GRP0		; 52 B0 -> [GRP0]
    pla			; 56 load B1 -> A
    sta GRP1		; 59 B1 -> [GRP1], B0 -> GRP0
    pla			; 63 load B2 -> A
    sta GRP0		; 66 B2 -> [GRP0], B1 -> GRP1
    
    pla			; 70
    tax			; 72
    lsr			; 74
    lsr			; 76
    hex	8D 04 00	; 04 means "sta NUSIZ0" (NUSIZ0 = $04 in zero page)
    			;    (force absolute addressing to waste 1 extra cycle)
    txa			; 06
    sta ENAM0		; 09
    asl			; 11
    sta ENAM1		; 14
    
    pla			; 18 load B3 -> A
    tay			; 20 B3 -> Y
    pla			; 24 load B4
    tax			; 26 -> X
    pla			; 30 load B5 -> A
    sty GRP1		; 33 B3 ->[GRP1], B2 -> GRP0
    stx GRP0		; 36 B4 -> [GRP0], B3 -> GRP1
    sta GRP1		; 39 B5 -> [GRP1], B4 -> GRP0
    sta GRP0		; 42 ?? -> [GRP0], B5 -> GRP1
    
    bne .Loop		; 45 next line
    
    SUBROUTINE
    
    
    lda #0
    sta GRP0
    sta GRP1
    sta GRP0
    sta GRP1
    sta ENABL
    sta ENAM0
    sta ENAM1
    
    sta WSYNC
    sta PF1
    sta WSYNC
    sta PF0
    
    ldy #8
KernelLoop3
    sta WSYNC
    
    dey
    bne KernelLoop3
    
    lda #$00
    sta PF0
    sta PF1



    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$94
    sta COLUBK
    sta WSYNC
    
    

    ldx #7
KernelLoopA
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC
    sta WSYNC

    dey
    bne KernelLoopC
    

    lda #$94
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$9E
    sta COLUBK
    sta WSYNC
    lda #$9A
    sta COLUBK
    sta WSYNC
    lda #$94
    sta COLUBK
    sta WSYNC


    dex
    bne KernelLoopA


    lda #COL_BACKGROUND
    sta COLUBK

    ldy #31
KernelLoopE
    sta WSYNC
    
    dey
    bne KernelLoopE
    
    
    
    lda #2
    sta VBLANK	; disable display
    
    jmp Overscan
