; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80
    
RamStart

Frame		ds 1	; Current frame

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the score

BCDScore	ds 3	; 3-byte array for score value which will be stored as a
			; BCD encoded 6-digit number and used to control the
			; 6-digit score display

BCDScoreAdd	ds 2	; 2-byte array for the value to be added to the score
			; on the next frame (max of 9,999)

ScoreColor	ds 1	; color of the score text and scoreboard

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

BCDLevel	ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the progress bar

Progress	ds 1	; value for the level progress, which can be
			; from 0 to 30 and will be used to draw the progress bar

ProgressBar	ds 5	; array of the 5 values to be written to the playfield
			; registers when drawing the progress bar

PgBarColor	ds 1	; color for the full part of the progress bar

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the health display

Health		ds 1	; amount of health
			; 0=full 8=medium 16=low 24=empty

HthGfxLPtr	ds 2	; pointer for the left half of the health graphics
HthGfxRPtr	ds 2	; pointer for the right half of the health graphics

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used when drawing the cat

CatPosY		ds 1	; number of scanlines to skip before drawing cat

RainbowStack	ds 1	; value to set the stack pointer to when
			; loading the rainbow colors into RAM

TartGfxPtr	ds 2	; pointer for the tart graphics
CatGfxPtr	ds 2	; pointer for the cat face/paws graphics

PreCatRows	ds 1	; number of rows to draw before the two "cat" rows
PostCatRows	ds 1	; number of rows to draw after the two "cat" rows

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used for the food items

FoodItemL	ds 7	; 2x 7-byte arrays for the 28 food items. Only 14 of 28
FoodItemR	ds 7	; will be drawn on each frame. The first 7 bytes are for
			; the left items, last 7 bytes are for the right items.
			; Hi nybble holds the value (0-15) of the item to draw.
			; Lo nybble holds the value of next frame's item.
			; All nybbles are swapped at the start of each frame.

FoodPosX	ds 7	; (range 0-88)

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the throbbing lines' colors

ThrobColor	ds 3	; 3-byte array for the colors used to draw the
			; throbbing lines. The first color is darkest,
			; the last is brightest.

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Temporary variables which cannot be shared with stack space

TempLoop	ds 1

; 53 of 79 non-temporary RAM bytes used (22 left)
; last 49 bytes of RAM are used for stack space in the scoreboard display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Temporary variables which can be shared with stack space

Temp		ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Other variables which can be shared with stack space

CurrentRow	ds 1	; the current row being drawn in the gameplay kernel

FoodGfxPtr1	ds 2	; pointer for the 1st food item's graphics
FoodColor1	ds 1	; color of the 1st food item

FoodGfxPtr2	ds 2	; pointer for the 2nd food item's graphics
FoodColor2	ds 1	; color of the 2nd food item

; 7 of 15 available temporary RAM bytes used (8 left)
; last 34 bytes of RAM are used to hold the rainbow color graphics

    ORG $100 - 34
    
RamBowColors	ds 34
