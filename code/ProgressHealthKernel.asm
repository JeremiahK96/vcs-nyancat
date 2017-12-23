    lda ThrobColor+1
    sta COLUBK
    lda #0
    sta PF0
    sta CTRLPF
    lda #COL_CAT_FACE
    sta COLUPF
    
    SLEEP 32	; 53
    
    lda #$20	; 55
    sta HMP0	; 58
    lda #$B0	; 60
    sta HMP1	; 63
    
    sta RESP0	; 66
    sta RESP1	; 69
    
    lda #$00	; 71
    
    sta HMOVE	; 74
    
    sta COLUP0
    sta COLUP1
    
    lda #COL_SCORE
    sta COLUBK
    
    lda #DOUBLE_SIZE	; 08
    sta NUSIZ0
    sta NUSIZ1

    lda #REFP_TRUE
    sta REFP1
    
    SUBROUTINE
    
    ldy #4
    sta WSYNC

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.HealthTop	; draw top of health

    ldx #3

.Loop
    sta WSYNC	
    
    lda HealthTopGfx,y	; 04
    sta GRP0		; 07
    sta GRP1		; 10
    lda #$00		; 12
    sta PF2		; 15
    SLEEP 26		; 37
    lda HealthBgGfx+8,y ; 41
    sta PF2		; 44	
    
    dex
    bne .Loop
    
    dey
    bpl .HealthTop
    
    
    SUBROUTINE
    
    
    ldy #3
    ldx #3
    stx Temp
    
    jmp .HealthMiddle
    
    ALIGN $100	; align to page
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.HealthMiddle	; draw middle of health, with progress bar

    sta WSYNC
.Loop
    lda ProgressBar+0	; 03 - get the 1st playfield register value
    sta PF0		; 06 - for the progress bar and set it
    
    lda ProgressBar+1	; 09 - get the 2nd playfield register value
    sta PF1		; 12 - for the progress bar and set it
    
    lda ProgressBar+2	; 15 - get the 3rd playfield register value
    sta PF2		; 18 - for the progress bar and set it
    
    lda PgBarColor	; 21 - get the progress bar color
    sta COLUBK		; 24 - and set it at cycle 24
    
    lda ProgressBar+3	; 27 - get the 4th playfield register value
    sta PF0		; 30 - for the progress bar and set it
    
    lda (HthGfxLPtr),y	; 35 - get/set the graphics
    sta GRP0		; 38 - for the left half of health
    lda (HthGfxRPtr),y	; 43 - get/set the graphics
    sta GRP1		; 46 - for the right half of health
    
    lda ProgressBar+4	; 49 - get the 5th playfield register value
    sta PF1		; 52 - for the progress bar and set it
    lda #%01111111	; 54 - get the 6th playfield register value
    sta.w PF2		; 58 - for the health background and set it
    
    lda #COL_SCORE	; 60 - get the color for the background
    sta.w COLUBK	; 64 - and set it at cycle 64
    
    dex			; 66
    bne .HealthMiddle	; 68
    
    ldx Temp		; 71
    
    dey			; 73
    bpl .Loop		; 76 / 00
    
    
    
    
    
    
    
    
    
    SUBROUTINE
    
    
    lda #0
    sta PF0
    sta PF1
    
    ldy #7

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
.HealthBottom	; draw bottom of health

    ldx #3
.Loop
    lda (HthGfxLPtr),y
    sta GRP0
    lda (HthGfxRPtr),y
    sta GRP1
    lda #$00
    sta PF2
    
    SLEEP 14
    
    lda HealthBgGfx-4,y
    sta PF2
    sta WSYNC
    
    dex
    bne .Loop
    
    dey
    cpy #3
    bne .HealthBottom
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
    lda #$00
    sta GRP0
    sta GRP1
    sta REFP0
    sta REFP1
    sta PF2
    
    sta WSYNC
    