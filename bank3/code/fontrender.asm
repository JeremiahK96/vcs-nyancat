; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 8-Char Kernel Prep
;
; Prepare for 8-character kernel
; Uses 103 bytes, taking 479 cycles from CharPreload, or 461 from CharLoad
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE
CharPreload
	ldx #>FontGfx0
	stx CharPtr0+1		; set page for pointer 0
	inx
	stx CharPtr1+1		; set page for pointer 1
	inx
	stx CharPtr2+1		; set pages for pointers 2 and 3
	stx CharPtr3+1
CharLoad
	lda FontText+0,y	; set offsets for pointers
	sta CharPtr0		; Y holds the offset in the char table
	lda FontText+1,y
	sta CharPtr1
	lda FontText+2,y
	sta CharPtr2
	lda FontText+3,y
	sta CharPtr3
	sty TempY		; save Y for later

	ldy #6			; preload left half of gfx data
.CharLoadLoop
	lax (CharPtr1),y
	and #%00000011
	ora (CharPtr0),y
	sta CharGfx0,y		; save gfx data for sprite 0
	txa
	ora #%00001111
	tax
	lda (CharPtr2),y
	lsr
	lsr
	ora #%11100000
	sax CharGfx1,y		; save gfx data for sprite 1
	arr #0
	ora (CharPtr3),y
	sta CharGfx2,y		; save gfx data for sprite 2
	dey
	bpl .CharLoadLoop

	ldy TempY		; recover Y value for last 4 chars
	lda FontText+4,y	; set new offsets for pointers
	sta CharPtr0
	lda FontText+5,y
	sta CharPtr1
	lda FontText+6,y
	sta CharPtr2
	lda FontText+7,y
	sta CharPtr3

	ldy MenuTemp
	sty TempY		; prepare kernel counter
	lda (CharPtr1),y
	and #%00000011
	ora (CharPtr0),y
	sta CharBuf0		; prepare gfx buffer for sprite 3

	rts



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 8-Char Kernel
;
; Uses 156 bytes, taking 1081 cycles
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	; 8 bytes / 14 cycles
.CharKernelLoop
	ldy TempY		; 2	65
	lda (TextColorPtr),y	; 2	70
	sta COLUP0		; 2	73
	sta COLUP1		; 2	00

	; 15 bytes / 21 cycles
	lda CharGfx0+1,y	; 3	04
	sta GRP0		; 2	07
	lda CharGfx1+1,y	; 3	11
	sta GRP1		; 2	14
	lda CharGfx2+1,y	; 3	18
	sta GRP0		; 2	21

	; 10 bytes / 18 cycles
	lda (CharPtr1),y	; 2	26
	and #%00000011		; 2	28
	ora (CharPtr0),y	; 2	33
	ldy CharBuf0		; 2	36
	sta CharBuf0		; 2	39

	; 10 bytes / 15 cycles
	lda CharBuf1		; 2	42
	sty GRP1		; 2	45
	sta GRP0		; 2	48
	stx GRP1		; 2	51
	stx GRP0		; 2	54

	; 2 bytes / 3 cycles
CharKernel
	ldy TempY		; 2	57

	; 15 bytes / 21 cycles
	lda CharGfx0,y		; 3	61
	sta GRP0		; 2	64
	lda CharGfx1,y		; 3	68
	sta GRP1		; 2	71
	lda CharGfx2,y		; 3	75
	sta GRP0		; 2	02

	; 14 bytes / 25 cycles
	lda (CharPtr1),y	; 2	07
	and #%11100000		; 2	09
	sta CharBuf1		; 2	12
	lda (CharPtr2),y	; 2	17
	lsr			; 1	19
	lsr			; 1	21
	ora CharBuf1		; 2	24
	sta CharBuf1		; 2	27

	; 5 bytes / 9 cycles
	arr #0			; 2	29
	ora (CharPtr3),y	; 2	34
	tax			; 1	36

	; 12 bytes / 18 cycles
	ldy CharBuf0		; 2	39
	lda CharBuf1		; 2	42
	sty GRP1		; 2	45
	sta GRP0		; 2	48
	stx GRP1		; 2	51
	stx GRP0		; 2	54

	; 4 bytes / 8/7 cycles
	dec TempY		; 2	59
	bpl .CharKernelLoop	; 2	61

	; 9 bytes / 18 cycles
	lda TextColorPtr	; 2	64
	sec			; 1	66
	sbc #10			; 2	68
	sta WSYNC		; 2	00
	sta TextColorPtr	; 2	03

	; 9 bytes / 14 cycles
	ldy #9			; 2	05
	lda (TextColorPtr),y	; 2	10
	sta COLUP0		; 2	13
	sta.w COLUP1		; 3	17

	; 12 bytes / 18 cycles
	lda CharGfx0		; 2	20
	sta GRP0		; 2	23
	lda CharGfx1		; 2	26
	sta GRP1		; 2	29
	lda CharGfx2		; 2	32
	sta GRP0		; 2	35

	; 12 bytes / 18 cycles
	ldy CharBuf0		; 2	38
	lda CharBuf1		; 2	41
	sty GRP1		; 2	44
	sta GRP0		; 2	47
	stx GRP1		; 2	50
	stx GRP0		; 2	53

	; 8 bytes / 11 cycles
	ldx #0			; 2	55
	stx GRP0		; 2	58
	stx GRP1		; 2	61
	stx GRP0		; 2	64

	; 10 cycles / 16 cycles
	ldy #6			; 2	66
	sty MenuTemp		; 2	69
	lda (TextColorPtr),y	; 2	74
	sta COLUP0		; 2	01
	sta COLUP1		; 2	04

	; 1 byte / 6 cycles
Slp12_3	rts			; 1	10

