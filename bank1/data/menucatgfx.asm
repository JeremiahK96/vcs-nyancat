; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Graphics
;
; Graphics for drawing the menu cat display
;
; Uses 1 page + 173 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ALIGN $100

MenuCatGfxPage1


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Top Playfield Graphics
;
; Graphics used for PF2 in the top 4 blocks of the menu cat display.
;
; 3 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatTopPf

	.byte %00000111	; PF2 gfx block 4
	.byte %00000111
	.byte %00000111
;	.byte %11111111	; PF2 gfx block 1 (shared with MenuCatGfxR)

; 3 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Right Player Graphics
;
; Graphics used for GRP1 in blocks 5-18 of the menu cat display.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 42 bytes of ROM (14 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatGfxR

; frames 1/5
	.byte %11111111	; GRP1 gfx block 18
	.byte %00000100
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %00100010
	.byte %00110010
	.byte %00101100
	.byte %00100000	; GRP1 gfx block 5

; frames 2/3/4
	.byte %11111111	; GRP1 gfx block 18
	.byte %00000100
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %01100010
	.byte %01010010
	.byte %01001100
	.byte %01000000	; GRP1 gfx block 5

; frame 6
	.byte %11110100	; GRP1 gfx block 18
	.byte %11111000
	.byte %00000100
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %00100010
	.byte %00110010
	.byte %00101100	; GRP1 gfx block 5

; 45 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Top Right Player Graphics
;
; Graphics used for GRP1 in the top 4 blocks of the menu cat display.
;
; 4 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatTopGfxR

	.byte %00100000	; GRP1 gfx block 4
	.byte %00010000
	.byte %00010000
	.byte %00010000	; GRP1 gfx block 1

; 49 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Top Left Player Graphics
;
; Graphics used for GRP0 in the top 4 blocks of the menu cat display.
;
; 3 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatTopGfxL

	.byte %00000001	; GRP0 gfx block 4
	.byte %00001000
	.byte %00100000
;	.byte %11111111	; GRP0 gfx block 1 (shared with MenuCatPfL)

; 52 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Left Playfield Graphics
;
; Graphics used for left copy of PF2 in blocks 6-20 of the menu cat display.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 84 bytes of ROM (14 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatPfL

; frame 1
	.byte %11111111	; PF2(L) gfx block 20
	.byte %10010011
	.byte %11110011
	.byte %10111111
	.byte %10111111
	.byte %00111111
	.byte %00111111
	.byte %00111111
	.byte %00111011
	.byte %00111001
	.byte %10111101
	.byte %10111100
	.byte %10111111
	.byte %10111111
	.byte %11111111	; PF2(L) gfx block 6

; frame 2
;	.byte %11111111	; PF2(L) gfx block 20 (shared with frame 1)
	.byte %10010111
	.byte %11110111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111011
	.byte %10111001
	.byte %10111100
	.byte %10111100
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %11111111	; PF2(L) gfx block 6

; frame 3
;	.byte %11111111	; PF2(L) gfx block 20 (shared with frame 2)
	.byte %10100111
	.byte %11110111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111100
	.byte %10111001
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %11111111	; PF2(L) gfx block 6

; frame 4
;	.byte %11111111	; PF2(L) gfx block 20 (shared with frame 3)
	.byte %10010111
	.byte %11110111
	.byte %10111111
	.byte %10111111
	.byte %10111100
	.byte %10111100
	.byte %10111001
	.byte %10111011
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %11111111	; PF2(L) gfx block 6

; frame 5
;	.byte %11111111	; PF2(L) gfx block 20 (shared with frame 4)
	.byte %11001011
	.byte %11110011
	.byte %10111111
	.byte %10111111
	.byte %00111111
	.byte %00111111
	.byte %00111111
	.byte %00111011
	.byte %00111000
	.byte %10111100
	.byte %10111111
	.byte %10111111
	.byte %10111111
	.byte %11111111	; PF2(L) gfx block 6

; frame 6
;	.byte %11111111	; PF2(L) gfx block 20 (shared with frame 5)
	.byte %11001011
	.byte %11110011
	.byte %10111011
	.byte %10111111
	.byte %10111111
	.byte %00111111
	.byte %00111111
	.byte %00111011
	.byte %00111001
	.byte %00111100
	.byte %10111100
	.byte %10111111
	.byte %10111111
;	.byte %10111111	; PF2(L) gfx block 6 (shared with MenuCatPfR)

; 136 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Right Playfield Graphics
;
; Graphics used for right copy of PF2 in blocks 6-18 of the menu cat display.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 37 bytes of ROM (12 per frame + 1)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatPfR

; frames 1/5
	.byte %10111111	; PF2(R) gfx block 18
	.byte %10000001
	.byte %10000001
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000001
	.byte %10011001
	.byte %10011001
	.byte %10111101
;	.byte %11111111	; PF2(R) gfx block 6 (shared with frames 2/3/4)

; frames 2/3/4
	.byte %11111111	; PF2(R) gfx block 18
	.byte %11000001
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10001000
	.byte %10011100
	.byte %10011100
;	.byte %11111111	; PF2(R) gfx block 6 (shared with frame 6)

; frame 6
	.byte %11111111	; PF2(R) gfx block 18
	.byte %11111111
	.byte %10000001
	.byte %10000001
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000001
	.byte %10011001
	.byte %10011001
	.byte %10111101	; PF2(R) gfx block 6
; 173 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Player Hmove Graphics
;
; Graphics used for HMP0 in blocks 6-18 and HMP1 in block 19.
; The frame's graphics will be accessed through a pointer.
;
; 70 bytes of ROM (14 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatHmoveP

; frame 1
	.byte $00	; P0 gfx block 18
	.byte $A0
	.byte $C0
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00	; P0 gfx block 6
	
	.byte $20	; P1 gfx block 19

; frame 2
	.byte $00	; P0 gfx block 18
	.byte $A0
	.byte $A0
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00	; P0 gfx block 6
	
	.byte $20	; P1 gfx block 19

; frame 3
	.byte $00	; P0 gfx block 18
	.byte $80
	.byte $A0
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00	; P0 gfx block 6
	
	.byte $00	; P1 gfx block 19

; frame 4
	.byte $00	; P0 gfx block 18
	.byte $80
	.byte $C0
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00	; P0 gfx block 6
	
	.byte $20	; P1 gfx block 19

; frames 5/6
	.byte $00	; P0 gfx block 18
	.byte $C0
	.byte $C0
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00	; P0 gfx block 6
	
	.byte $40	; P1 gfx block 19

; 243 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Missile Graphics
;
; Graphics used to control the size and enable for M0 in blocks 6-17 of the
; menu cat display.
; The frame's graphics will be accessed through a pointer that is offset by -1.
; Because of that, this table cannot be at the start of a page.
;
; 13 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatMslGfx

; frame 6
	.byte DOUBLE_SIZE | MSL_SIZE_8 | ENA_TRUE	; missile gfx block 17

; frames 5/4/3/2/1
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_FALSE	; missile gfx block 16/17
	.byte DOUBLE_SIZE | MSL_SIZE_8 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_FALSE
	.byte DOUBLE_SIZE | MSL_SIZE_4 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_FALSE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_FALSE
	.byte DOUBLE_SIZE | MSL_SIZE_4 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_TRUE
	.byte DOUBLE_SIZE | MSL_SIZE_2 | ENA_TRUE	; missile gfx block 6/7

	.byte DOUBLE_SIZE | MSL_SIZE_4 | ENA_TRUE	; missile gfx block 6

; all 256 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; PAGE BOUNDARY
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatGfxPage2


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Left Player Graphics
;
; Graphics used for GRP0 in blocks 7-20 of the menu cat display.
; The graphics for blocks 5-6 are the same as block 4 from MenuCatTopGfxL.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 84 bytes of ROM (14 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatGfxL

; frame 1
	.byte %01110001	; GRP0 gfx block 20
	.byte %10011010
	.byte %10001111
	.byte %01110000
	.byte %00000100
	.byte %00000001
	.byte %00000011
	.byte %00001111
	.byte %00011001
	.byte %00110011
	.byte %01100111
	.byte %01001101
	.byte %01111001
	.byte %00000001	; GRP0 gfx block 7

; frame 2
	.byte %01100011	; GRP0 gfx block 20
	.byte %10010100
	.byte %10011111
	.byte %01100000
	.byte %00001000
	.byte %00000001
	.byte %00000111
	.byte %00011001
	.byte %00100001
	.byte %01001111
	.byte %01001001
	.byte %00110001
	.byte %00000001
	.byte %00000001	; GRP0 gfx block 7

; frame 3
	.byte %01100011	; GRP0 gfx block 20
	.byte %10010100
	.byte %10111111
	.byte %11000000
	.byte %00001000
	.byte %00111101
	.byte %01000111
	.byte %01100001
	.byte %00011111
	.byte %00000011
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001	; GRP0 gfx block 7

; frame 4
	.byte %01100011	; GRP0 gfx block 20
	.byte %10010100
	.byte %10011111
	.byte %01100000
	.byte %11000100
	.byte %01001001
	.byte %01001111
	.byte %00100001
	.byte %00011001
	.byte %00000111
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001	; GRP0 gfx block 7

; frame 5
	.byte %01100011	; GRP0 gfx block 20
	.byte %10010100
	.byte %10001111
	.byte %01111000
	.byte %00001100
	.byte %00000001
	.byte %00000001
	.byte %00000111
	.byte %00111101
	.byte %11000011
	.byte %10001111
	.byte %01111001
	.byte %00000001
	.byte %00000001	; GRP0 gfx block 7

; frame 6
	.byte %01100011	; GRP0 gfx block 20
	.byte %10010100
	.byte %10001111
	.byte %01011000
	.byte %00001100
	.byte %00000001
	.byte %00000001
	.byte %00000111
	.byte %00011001
	.byte %00100001
	.byte %01001111
	.byte %01001001
	.byte %00110001
	.byte %00000001	; GRP0 gfx block 7

; 84 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Lower Right Player Graphics
;
; Graphics used for GRP1 in blocks 19-20 of the menu cat display.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 12 bytes of ROM (2 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatLowGfxR

; frame 1
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; frame 2
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; frame 3
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; frame 4
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; frame 5
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; frame 6
	.byte %00101001	; GRP1 gfx block 19
	.byte %11000110	; GRP1 gfx block 20

; 96 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Lower Right Playfield Graphics
;
; Graphics used for right copy of PF2 in blocks 19-20 of the menu cat display.
; The frame's graphics will be pushed onto the stack and read from RAM.
;
; 12 bytes of ROM (2 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatLowPfGfxR

; frame 1
	.byte %01010011	; PF2(R) gfx block 19
	.byte %01111111	; PF2(R) gfx block 20

; frame 2
	.byte %11001011	; PF2(R) gfx block 19
	.byte %11111111	; PF2(R) gfx block 20

; frame 3
	.byte %11101001	; PF2(R) gfx block 19
	.byte %11111111	; PF2(R) gfx block 20

; frame 4
	.byte %11001011	; PF2(R) gfx block 19
	.byte %11111111	; PF2(R) gfx block 20

; frame 5
	.byte %00010111	; PF2(R) gfx block 19
	.byte %01111111	; PF2(R) gfx block 20

; frame 6
	.byte %00010111	; PF2(R) gfx block 19
	.byte %01111111	; PF2(R) gfx block 20

; 108 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Cat Missile Hmove Graphics
;
; Graphics used for HMM0 and HMM1 in lines 6-18.
; The left nybble is used for HMM0, and the right is for HMM1.
; The frame's graphics will be accessed through a pointer.
;
; 65 bytes of ROM (13 per frame)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatHmoveM

; frames 1/2
	.byte $DF	; HMMx gfx block 18
	.byte $0E
	.byte $0E
	.byte $E0
	.byte $00
	.byte $20
	.byte $20
	.byte $02
	.byte $00
	.byte $E0
	.byte $E0
	.byte $C2
	.byte $00	; HMMx gfx block 6

; frame 3
	.byte $BE	; HMMx gfx block 18
	.byte $0E
	.byte $0E
	.byte $E0
	.byte $00
	.byte $20
	.byte $20
	.byte $02
	.byte $00
	.byte $E0
	.byte $E0
	.byte $C2
	.byte $00	; HMMx gfx block 6

; frame 4
	.byte $DF	; HMMx gfx block 18
	.byte $0E
	.byte $0E
	.byte $E0
	.byte $00
	.byte $20
	.byte $20
	.byte $02
	.byte $00
	.byte $E0
	.byte $E0
	.byte $C2
	.byte $00	; HMMx gfx block 6

; frame 5
	.byte $00	; HMMx gfx block 18
	.byte $0E
	.byte $0E
	.byte $E0
	.byte $00
	.byte $20
	.byte $20
	.byte $02
	.byte $00
	.byte $E0
	.byte $E0
	.byte $C2
	.byte $00	; HMMx gfx block 6

; frame 6
	.byte $11	; HMMx gfx block 18
	.byte $2E
	.byte $0E
	.byte $0E
	.byte $E0
	.byte $00
	.byte $20
	.byte $20
	.byte $02
	.byte $00
	.byte $E0
	.byte $E0
	.byte $C2	; HMMx gfx block 6

; 173 bytes used in page


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Offset Tables
;
; Tables of offsets to the correct data for frames that can share graphics.
;
; 12 bytes of ROM (6 bytes per table)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

MenuCatOffsetGfx
	.byte <MenuCatGfxR+0
	.byte <MenuCatGfxR+14
	.byte <MenuCatGfxR+14
	.byte <MenuCatGfxR+14
	.byte <MenuCatGfxR+0
	.byte <MenuCatGfxR+28

MenuCatOffsetPf
	.byte <MenuCatPfR+0
	.byte <MenuCatPfR+12
	.byte <MenuCatPfR+12
	.byte <MenuCatPfR+12
	.byte <MenuCatPfR+0
	.byte <MenuCatPfR+24
