; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables
;
; All the data in these tables is upside-down,
; i.e. the last byte in each section is the first byte of information
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ALIGN $100	; align to page

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Digit graphics for the scoreboard
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

ScoreGfx

    .byte %00000000
    .byte %00011100	; digit 0
    .byte %00110010
    .byte %01100011
    .byte %01100011
    .byte %01100011
    .byte %00100110
    .byte %00011100

    .byte %00000000
    .byte %01111110	; digit 1
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00111000
    .byte %00011000

    .byte %00000000
    .byte %01111111	; digit 2
    .byte %01110000
    .byte %00111100
    .byte %00011110
    .byte %00000111
    .byte %01100011
    .byte %00111110

    .byte %00000000
    .byte %00111110	; digit 3
    .byte %01100011
    .byte %00000011
    .byte %00011110
    .byte %00001100
    .byte %00000110
    .byte %01111111

    .byte %00000000
    .byte %00000110	; digit 4
    .byte %00000110
    .byte %01111111
    .byte %01100110
    .byte %00110110
    .byte %00011110
    .byte %00001110

    .byte %00000000
    .byte %00111110	; digit 5
    .byte %01100011
    .byte %00000011
    .byte %00000011
    .byte %01111110
    .byte %01100000
    .byte %01111110

    .byte %00000000
    .byte %00111110	; digit 6
    .byte %01100011
    .byte %01100011
    .byte %01111110
    .byte %01100000
    .byte %00110000
    .byte %00011110

    .byte %00000000
    .byte %00011000	; digit 7
    .byte %00011000
    .byte %00011000
    .byte %00001100
    .byte %00000110
    .byte %01100011
    .byte %01111111

    .byte %00000000
    .byte %00111110	; digit 8
    .byte %01000011
    .byte %01000011
    .byte %00111100
    .byte %01110010
    .byte %01100010
    .byte %00111100

    .byte %00000000
    .byte %00111100	; digit 9
    .byte %00000110
    .byte %00000011
    .byte %00111111
    .byte %01100011
    .byte %01100011
    .byte %00111110

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Nusiz data for level counter graphics
;
; This table controls the leftmost missile's width in the level counter
; line-by-line. The rightmost missile's width is not changed.
; In each byte, the right nybble controls the number of player copies,
; and the left nybble controls the width of the missile.
; The right nybble is always $3 to keep the score graphics correct.
;
; Table takes up $50 (80) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

LevelGfx

	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 0
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 1
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 2
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 3
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 4
    .byte %01001101
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %01001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 5
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 6
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001110
    .byte %01001110
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 7
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001101
    .byte %01001101
    .byte %01001101
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 8
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111
    
	; %nnnnnnEe	n=NUSIZ0 E=ENAM0 e=ENAM1
	; ^^^^^^^^^
    .byte %00000000	; digit 9
    .byte %10001111
    .byte %01001101
    .byte %01001101
    .byte %10001111
    .byte %01001111
    .byte %01001111
    .byte %10001111

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Enam0 and Enam1 data for level counter graphics
;
; This table enables or disables each missile in the level counter line-by-line.
; Only bits 1 and 0 are used.
; Bit 1 is used for the leftmost missile,
; and bit 0 is used for the rightmost missile.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Animated graphics for the throbbing lines
