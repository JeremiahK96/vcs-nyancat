; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Scoreboard Display
;
; Draw the 6-digit score and level counter.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE
	
	lda #$13
	sta NUSIZ0
	
	lda #%00100000
	sta PF0
	
	lda #%00110101
	sta CTRLPF
	
	lda BCDLevel
	lsr
	lsr
	lsr
	sta ENAM1
	sta ENAM0
	
	lda #0
	sta COLUP0
	sta COLUP1
	sta GRP0
	
	lda #$FF
	sta ENAM0
	sta ENABL
	sta VDELP0
	sta VDELP1
	
	lda #8
	sta TIM64T
	ldy #5
	
	sta WSYNC
    
ScoreboardLoop
	
	lda LevelGfx,y	; 04
	sta.w NUSIZ1	; 08
	
	pla		; 12
	sta GRP1	; 15
	pla		; 19
	sta GRP0	; 22
	
	pla		; 26
	sta GRP1	; 29
	pla		; 33
	sta GRP0	; 36
	
	lda #3		; 38
	sta NUSIZ1	; 41
	
	pla		; 45
	tax		; 47
	pla		; 51
	tay		; 53
	pla		; 57
	
	stx GRP1	; 60
	sty GRP0	; 63
	sta GRP1	; 66
	sta GRP0	; 69
	
	ldy INTIM		; 73
	bpl ScoreboardLoop	; 00/75
	
	
	lda #0		; 01
	sta GRP0	; 04
	sta GRP1	; 07
	sta VDELP1	; 10
	sta VDELP0	; 13
	sta ENABL	; 16
	sta ENAM0	; 19
	sta ENAM1	; 22
