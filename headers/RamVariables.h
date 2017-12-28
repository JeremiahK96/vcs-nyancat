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

BCDLevel		ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the progress bar and health display

Progress	ds 1	; value for level progress, which can be
			; from 0 to 30 and will be used to draw progress bar

ProgressBar	ds 5	; array of 5 values to be written to the playfield
			; registers when drawing progress bar

PgBarColor	ds 1	; color for full part of progress bar

Health		ds 1	; amount of health
			; 0=full 8=medium 16=low 24=empty

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Pointers

FoodGfxPtr1	; pointer for 1st food item's graphics
LvlLoadPtr	; pointer for level digit graphics in scoreboard loading routine

		ds 2

FoodGfxPtr2	; pointer for 2nd food item's graphics
ScrLoadPtr0	; pointer for digit 0 in scoreboard loading routine

		ds 2

TartGfxPtr		; pointer for the tart graphics
ScrLoadPtr1	; pointer for digit 1 in scoreboard loading routine

		ds 2

CatGfxPtr	; pointer for the cat face/paws graphics
ScrLoadPtr2	; pointer for digit 2 in scoreboard loading routine

		ds 2

HthGfxLPtr	; pointer for left half of the health graphics
ScrLoadPtr3	; pointer for digit 3 in scoreboard loading routine

		ds 2

HthGfxRPtr	; pointer for right half of the health graphics
ScrLoadPtr4	; pointer for digit 4 in scoreboard loading routine

		ds 2

ThrobPtr	; pointer for loading the throb colors
ScrLoadPtr5	; pointer for digit 5 in scoreboard loading routine

		ds 2

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used when drawing the cat

CatPosY		ds 1	; number of scanlines to skip before drawing cat

Rainbow		; PF0 value for the rainbow graphics
ScoreDigit4	; temporary variable for digit 4 in scoreboard loading routine
	ds 1
		
RainbowStack	; value to set stack pointer to before pushing rainbow colors
ScoreDigit5	; temporary variable for digit 5 in scoreboard loading routine
	ds 1

PreCatRows	ds 1	; number of rows to draw before the two "cat" rows
PostCatRows	ds 1	; number of rows to draw after the two "cat" rows

CatTartColor	ds 1	; color of the cat's tart body

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
Temp1		ds 1
Temp2		ds 1

; 53 of 79 non-temporary RAM bytes used (22 left)
; last 49 bytes of RAM are used for stack space in the scoreboard display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Temporary variables which can be shared with stack space

Temp		ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Other variables which can be shared with stack space

CurrentRow	ds 1	; the current row being drawn in the gameplay kernel

FoodColor1	ds 1	; color of the 1st food item
FoodColor2	ds 1	; color of the 2nd food item

; 7 of 15 available temporary RAM bytes used (8 left)
; last 34 bytes of RAM are used to hold the rainbow color graphics

    ORG $100 - 36
RamBowColors	ds 34
