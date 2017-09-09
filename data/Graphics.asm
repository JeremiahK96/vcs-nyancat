; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ALIGN $100	; align to page

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Digit graphics for the scoreboard
;
; This data is right-side up, NOT upside-down. Since the program reads the data
; in bottom-to-top order and then pushes it to the stack, it gets flipped back
; to normal when it is pulled from the stack.
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

ScoreGfx

    .byte %00011100	; digit 0
    .byte %00100110
    .byte %01100011
    .byte %01100011
    .byte %01100011
    .byte %00110010
    .byte %00011100
    .byte %00000000

    .byte %00011000	; digit 1
    .byte %00111000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %01111110
    .byte %00000000

    .byte %00111110	; digit 2
    .byte %01100011
    .byte %00000111
    .byte %00011110
    .byte %00111100
    .byte %01110000
    .byte %01111111
    .byte %00000000

    .byte %01111111	; digit 3
    .byte %00000110
    .byte %00001100
    .byte %00011110
    .byte %00000011
    .byte %01100011
    .byte %00111110
    .byte %00000000

    .byte %00001110	; digit 4
    .byte %00011110
    .byte %00110110
    .byte %01100110
    .byte %01111111
    .byte %00000110
    .byte %00000110
    .byte %00000000

    .byte %01111110	; digit 5
    .byte %01100000
    .byte %01111110
    .byte %00000011
    .byte %00000011
    .byte %01100011
    .byte %00111110
    .byte %00000000

    .byte %00011110	; digit 6
    .byte %00110000
    .byte %01100000
    .byte %01111110
    .byte %01100011
    .byte %01100011
    .byte %00111110
    .byte %00000000

    .byte %01111111	; digit 7
    .byte %00000011
    .byte %00000110
    .byte %00001100
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00000000

    .byte %00111100	; digit 8
    .byte %01100010
    .byte %01110010
    .byte %00111100
    .byte %01000011
    .byte %01000011
    .byte %00111110
    .byte %00000000

    .byte %00111110	; digit 9
    .byte %01100011
    .byte %01100011
    .byte %00111111
    .byte %00000011
    .byte %00000110
    .byte %00111100
    .byte %00000000

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; NUSIZx and ENAMx data for level counter graphics
;
; This table enables or disables each missile and adjusts the left missile's
; size in the scoreboard kernel line-by-line to draw the level counter's
; left digit. (The right digit is drawn with the ball.)
; Bit-1 is used to enable or disable the left missile,
; and bit-0 is used to enable or disable the right missile.
; The leftmost 6 bits are shifted right twice to get a value for NUSIZx.
; Therefore, bits 6-7 are used to control the size of the left missile,
; bit-5 is not used, and bits 4-2 are always "011" to keep the player copies
; correct for the score display.
;
; This data is right-side up, NOT upside-down. Since the program reads the data
; in bottom-to-top order and then pushes it to the stack, it gets flipped back
; to normal when it is pulled from the stack.
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

LevelGfx

	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 0
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001101	; digit 1
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 2
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 3
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %01001111	; digit 4
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %01001101
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 5
    .byte %01001110
    .byte %01001110
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 6
    .byte %01001110
    .byte %01001110
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 7
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 8
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %00000000
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %10001111	; digit 9
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %00000000
