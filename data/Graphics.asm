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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %00011000	; digit 1
    .byte %00111000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %01111110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %00111110	; digit 2
    .byte %01100011
    .byte %00000111
    .byte %00011110
    .byte %00111100
    .byte %01110000
    .byte %01111111
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %01111111	; digit 3
    .byte %00000110
    .byte %00001100
    .byte %00011110
    .byte %00000011
    .byte %01100011
    .byte %00111110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %00001110	; digit 4
    .byte %00011110
    .byte %00110110
    .byte %01100110
    .byte %01111111
    .byte %00000110
    .byte %00000110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %01111110	; digit 5
    .byte %01100000
    .byte %01111110
    .byte %00000011
    .byte %00000011
    .byte %01100011
    .byte %00111110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %00011110	; digit 6
    .byte %00110000
    .byte %01100000
    .byte %01111110
    .byte %01100011
    .byte %01100011
    .byte %00111110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %01111111	; digit 7
    .byte %00000011
    .byte %00000110
    .byte %00001100
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %00111100	; digit 8
    .byte %01100010
    .byte %01110010
    .byte %00111100
    .byte %01000011
    .byte %01000011
    .byte %00111110
    .byte %00000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
    
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



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Throbbing Line Graphics
;
; Graphics tables for the throbbing lines
;
; Table takes up $18 (24) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

ThrobGfx

    .byte LUM_0 + MODE_GREY	; frame 0
    .byte LUM_2 + MODE_GREY
    .byte LUM_4 + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_0 + MODE_GREY	; frame 1
    .byte LUM_4 + MODE_COLOR
    .byte LUM_6 + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_0 + MODE_GREY	; frame 2
    .byte LUM_6 + MODE_COLOR
    .byte LUM_8 + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_2 + MODE_GREY	; frame 3
    .byte LUM_8 + MODE_COLOR
    .byte LUM_C + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_4 + MODE_COLOR	; frame 4
    .byte LUM_A + MODE_COLOR
    .byte LUM_E + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_2 + MODE_GREY	; frame 5
    .byte LUM_8 + MODE_COLOR
    .byte LUM_C + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_0 + MODE_GREY	; frame 6
    .byte LUM_6 + MODE_COLOR
    .byte LUM_A + MODE_COLOR
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte LUM_0 + MODE_GREY	; frame 7
    .byte LUM_4 + MODE_COLOR
    .byte LUM_6 + MODE_COLOR



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Health Graphics
;
; All of these tables are upside-down, and they are supposed to be used with the
; left player not mirrored, and the right player mirrored. This makes it easier
; to draw the top 5 lines since they are always mirrored. Because of this, all
; the graphics for the lower right are flipped.
; The graphics tables for the lower 8 lines (HealthLeftGfx and HealthRightGfx)
; are set up in a confusing way. They are upside-down, but they are split
; into 2 sections. The first 4 bytes correspond to the UPPER 4 lines
; of graphics (upside-down), and the last 4 bytes correspond to the
; LOWER 4 lines of graphics (also upside-down).
; The last table (HealthBgGfx) is for the grey background of the
; health graphics drawn with the playfield.
;
; Table takes up $45 (69) bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

HealthTopGfx

    .byte %01000000	; graphics for left top of health
    .byte %01000011
    .byte %01000100
    .byte %01001000
    .byte %00110000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
HealthLeftGfx

    .byte %10000000	; left health full (upper)
    .byte %10001100
    .byte %10000100
    .byte %10000000
    .byte %00011111	; left health full (lower)
    .byte %00100000
    .byte %01000111
    .byte %10000100
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; left health medium (upper)
    .byte %10001100
    .byte %10000100
    .byte %10000000
    .byte %00011111	; left health medium (lower)
    .byte %00100000
    .byte %01000111
    .byte %10000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; left health low (upper)
    .byte %10001100
    .byte %10000100
    .byte %10000000
    .byte %00011111	; left health low (lower)
    .byte %00100000
    .byte %01000100
    .byte %10000111
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; left health empty (upper)
    .byte %10011100
    .byte %10000000
    .byte %10000000
    .byte %00011111	; left health empty (lower)
    .byte %00100000
    .byte %01000110
    .byte %10000001

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
HealthRightGfx

    .byte %10000000	; right health full (upper)
    .byte %10011010
    .byte %10010000
    .byte %10000000
    .byte %00011111	; right health full (lower)
    .byte %00100000
    .byte %01001111
    .byte %10001001
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; right health medium (upper)
    .byte %10011010
    .byte %10010000
    .byte %10000000
    .byte %00011111	; right health medium (lower)
    .byte %00100000
    .byte %01001111
    .byte %10000000
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; right health low (upper)
    .byte %10011010
    .byte %10001000
    .byte %10000000
    .byte %00011111	; right health low (lower)
    .byte %00100000
    .byte %01001000
    .byte %10001111
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    .byte %10000000	; right health empty (upper)
    .byte %10111010
    .byte %10000000
    .byte %10000000
    .byte %00011111	; right health empty (lower)
    .byte %00100000
    .byte %01001100
    .byte %10000011
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; 3 bytes left in this page

    ALIGN $100	; align to page
    
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
HealthBgGfx
; 13 bytes

    .byte %00000000
    .byte %00111110
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01111111
    .byte %01100011
    .byte %01100011
    .byte %00000000



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Progress Bar Graphics
;
; 
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

PgBarGfx
; 9 bytes

    .byte %11111111	; 1st PF1
    .byte %01111111	; 2nd PF1 (then 1 shift left)
    .byte %00111111
    .byte %00011111
    .byte %00001111
    .byte %00000111
    .byte %00000011
    .byte %00000001
    .byte %00000000

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
PgBarGfxR
; 8 bytes

    .byte %11111111	; PF2
    .byte %11111110
    .byte %11111100
    .byte %11111000
    .byte %11110000	; 2nd PF0
    .byte %11100000	; 1st PF0
    .byte %11000000
    .byte %10000000



FineHmove73

    HEX 70 60 50 40
    HEX 30 20 10 00
    HEX F0 E0 D0 C0
    HEX B0 A0 90 80



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Cat Rainbow Graphics
;
; 
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

RainbowGfx
; 4 bytes

    .byte %10100000	; rainbow PF0 gfx for moving straight, frame 0
    
    .byte %01010000	; rainbow PF0 gfx for moving straight, frame 1
    
    .byte %11000000	; rainbow PF0 gfx for moving up
    
    .byte %00110000	; rainbow PF0 gfx for moving down

    
    HEX 00000000000000000000000000000000000000000000	; 22 bytes

CatFaceGfx

    .byte %00110110
    .byte %00110110
    .byte %00000000
    .byte %01111110
    .byte %11000001
    .byte %11010101
    .byte %11111111
    .byte %11010101
    .byte %11011101
    .byte %11111111
    .byte %01100110
    .byte %01100110
    .byte %01000010
    
    HEX 000000000000000000000000000000000000000000	; 21 bytes
    ;140 bytes used in page

    ALIGN $100

FoodGfx

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 0 - blank

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    
    .byte $0E
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 1 - apple

    .byte %00110100
    .byte %01111110
    .byte %01111110
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %01111111
    .byte %01101010
    .byte %00001000
    .byte %00001100
    .byte %00000100
    
    .byte $46
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 2 - peach

    .byte %00111100
    .byte %01101110
    .byte %01101110
    .byte %11011111
    .byte %11011111
    .byte %10111111
    .byte %10111111
    .byte %10111111
    .byte %11011110
    .byte %01011110
    .byte %01101100
    .byte %00011000
    .byte %00010000
    .byte %00110000
    
    .byte $3A
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 3 - banana

    .byte %00111000
    .byte %01111100
    .byte %11111110
    .byte %11111110
    .byte %11111111
    .byte %11111111
    .byte %10001111
    .byte %00000111
    .byte %00000111
    .byte %00000011
    .byte %00000011
    .byte %00000010
    .byte %00000110
    .byte %00000110
    
    .byte $1E
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 4 - pear

    .byte %00111000
    .byte %01111100
    .byte %11111110
    .byte %11111110
    .byte %11111110
    .byte %11111110
    .byte %01111100
    .byte %01111100
    .byte %00111000
    .byte %00111000
    .byte %00110000
    .byte %00010000
    .byte %00011000
    .byte %00001000
    
    .byte $CC
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 5 - plum

    .byte %00111000
    .byte %01101100
    .byte %01101110
    .byte %11011110
    .byte %11011111
    .byte %10111111
    .byte %10111111
    .byte %10111111
    .byte %11011110
    .byte %11011110
    .byte %01011110
    .byte %00111100
    .byte %00100000
    .byte %01100000
    
    .byte $88
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 6 - grapes

    .byte %00011000
    .byte %00001000
    .byte %00110110
    .byte %00010010
    .byte %01101100
    .byte %00100100
    .byte %11011011
    .byte %01001001
    .byte %00110110
    .byte %00010010
    .byte %01101100
    .byte %00110100
    .byte %00010000
    .byte %00011000
    
    .byte $64
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 7 - broccoli

    .byte %00000000
    .byte %00000000
    .byte %00011000
    .byte %00011000
    .byte %00111110
    .byte %00101010
    .byte %11101010
    .byte %11011111
    .byte %11111111
    .byte %11111111
    .byte %01111110
    .byte %00011000
    .byte %00000000
    .byte %00000000
    
    .byte $C6
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 8 - cabbage

    .byte %00011000
    .byte %01110110
    .byte %01110110
    .byte %01111010
    .byte %11111001
    .byte %11111011
    .byte %11101101
    .byte %11011011
    .byte %11111011
    .byte %11101001
    .byte %01010110
    .byte %01110110
    .byte %01101110
    .byte %00011000
    
    .byte $DA
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 9 - celery

    .byte %11000000
    .byte %11100000
    .byte %01110000
    .byte %00110000
    .byte %00011000
    .byte %00011000
    .byte %00001100
    .byte %00001100
    .byte %00001110
    .byte %00000110
    .byte %00001101
    .byte %00001011
    .byte %00001101
    .byte %00000110
    
    .byte $D6
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; A - green pepper

    .byte %01101100
    .byte %01101100
    .byte %11111110
    .byte %11111110
    .byte %11110110
    .byte %11110110
    .byte %11110110
    .byte %11110110
    .byte %11110110
    .byte %11101100
    .byte %01111100
    .byte %00010000
    .byte %00011000
    .byte %00001000
    
    .byte $C8
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; B - potato

    .byte %00000000
    .byte %00000000
    .byte %00000000
    .byte %00011100
    .byte %01111110
    .byte %11111111
    .byte %11111111
    .byte %11101111
    .byte %11110110
    .byte %01111000
    .byte %00110000
    .byte %00000000
    .byte %00000000
    .byte %00000000
    
    .byte $F6
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; C - mushroom

    .byte %00000000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %00011000
    .byte %10011001
    .byte %11011011
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %01111110
    .byte %01111110
    .byte %00011000
    .byte %00000000
    
    .byte $08
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; D - key

    .byte %00010000
    .byte %00011110
    .byte %00011110
    .byte %00011000
    .byte %00011110
    .byte %00011110
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00010000
    .byte %00111000
    .byte %01101100
    .byte %01101100
    .byte %00111000
    
    .byte $2C
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; E - ring

    .byte %00000000
    .byte %00011000
    .byte %00111100
    .byte %01100110
    .byte %01000010
    .byte %01000010
    .byte %01000010
    .byte %01100110
    .byte %00111100
    .byte %00011000
    .byte %00011000
    .byte %00101100
    .byte %00011000
    .byte %00000000
    
    .byte $2C
    .byte 0

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; F - heart

    .byte %00000000
    .byte %00011000
    .byte %00011000
    .byte %00111100
    .byte %00111100
    .byte %01111110
    .byte %01111110
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %11100111
    .byte %11100111
    .byte %01000010
    .byte %00000000
    
    .byte $4A
    .byte 0

RainbowColors

    .byte $64
    .byte $88
    .byte $C8
    .byte $1E
    .byte $28
    .byte $44
    
    .byte 0

CatTartGfx

    .byte %00000000
    .byte %00000000
    .byte %11100000
    .byte %11000000
    .byte %11000000
    .byte %11000000
    .byte %11000000
    .byte %11000000
    .byte %11000000
    .byte %11100000
    .byte %11100000
    .byte %11100000
    .byte %11100000
    .byte %11100000
