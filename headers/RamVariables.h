; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80

RamStart

Frame		ds 1	; Current frame modulus 256

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the score and level counter - 6 bytes

BCDScore	; 3-byte array for score value which will be stored as a
	ds 3	; BCD encoded 6-digit number and used to control the
		; 6-digit score display

BCDScoreAdd	; 2-byte array for the value to be added to the score
	ds 2	; on the next frame (max of 9,999)

BCDLevel	; value for the current level which will be stored as a
	ds 1	; BCD encoded 2-digit number and used to control the
		; level counter display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variable game colors - 3 bytes

ScoreColor	ds 1	; color of the score text and scoreboard
PgBarColor	ds 1	; color for full part of progress bar
CatTartColor	ds 1	; color of the cat's tart body

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the progress bar and health display - 7 bytes

Progress	; value for level progress, which can be
	ds 1	; from 0 to 30 and will be used to draw progress bar

Health		; amount of health
	ds 1	; 0=full 8=medium 16=low 24=empty

ProgressBar	; array of 5 values to be written to the playfield
	ds 5	; registers when drawing progress bar

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Pointers - 14 bytes

FoodGfxPtr1	; pointer for 1st food item's graphics
LvlLoadPtr	; pointer for level digit graphics in scoreboard loading routine
	ds 2

FoodGfxPtr2	; pointer for 2nd food item's graphics
ScrLoadPtr0	; pointer for digit 0 in scoreboard loading routine
	ds 2

TartGfxPtr1	; pointer for the tart graphics
ScrLoadPtr1	; pointer for digit 1 in scoreboard loading routine
	ds 2

CatGfxPtr1	; pointer for the cat face/paws graphics
ScrLoadPtr2	; pointer for digit 2 in scoreboard loading routine
	ds 2

TartGfxPtr2	; pointer for the tart graphics
HthGfxLPtr	; pointer for left half of the health graphics
ScrLoadPtr3	; pointer for digit 3 in scoreboard loading routine
	ds 2

CatGfxPtr2	; pointer for the cat face/paws graphics
HthGfxRPtr	; pointer for right half of the health graphics
ScrLoadPtr4	; pointer for digit 4 in scoreboard loading routine
	ds 2

ThrobPtr	; pointer for loading the throb colors
ScrLoadPtr5	; pointer for digit 5 in scoreboard loading routine
	ds 2

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used when drawing the cat - 5 bytes

CatPosY		; number of scanlines to skip before drawing cat
	ds 1
CatPosition	; data describing the cat's position
	ds 1	; bits 7-5 store the cat's row, from 1-7
		; bits 4-0 store the number of scanlines to skip after
		; top of the cat's row before drawing the cat, from 0-18

Rainbow		; PF0 value for the rainbow graphics
ScoreDigit4	; temporary variable for digit 4 in scoreboard loading routine
	ds 1
		
RainbowStack	; value to set stack pointer to before pushing rainbow colors
ScoreDigit5	; temporary variable for digit 5 in scoreboard loading routine
	ds 1

PreCatRows	; number of rows to draw before the two "cat" rows
	ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used for the food items - 21 bytes

FoodItemL	; 2x 7-byte arrays for the 28 food items. Only 14 of 28
	ds 7	; will be drawn on each frame. The first 7 bytes are for
FoodItemR	; the left items, last 7 bytes are for the right items.
	ds 7	; Hi nybble holds the value (0-15) of the item to draw.
		; Lo nybble holds the value of next frame's item.
		; All nybbles are swapped at the start of each frame.

FoodPosX	; (range 0-88)
	ds 7

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables used to pre-load for 2nd "cat" row's food items - 7 bytes


CatRowHmove	; array of 3 values to store to HMP1 before strobing
	ds 3	; HMOVE to position food items in 2nd cat row

CatRow2FoodL	; 
	ds 1	; 
CatRow2FoodR	; 
	ds 1	; 

CatRow2Color1	; 
	ds 1	; 
CatRow2Color2	; 
	ds 1	; 

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables for the throbbing lines' colors - 4 bytes

ThrobColor	ds 3	; 3-byte array for the colors used to draw the
			; throbbing lines. The first color is darkest,
			; the last is brightest.

CatThrobPF	ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Temporary variables - 2 bytes

Temp		ds 1
TempLoop	ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; 69 of 79 non-temporary RAM bytes used (10 left)
; last 49 bytes of RAM are used for stack space in the scoreboard display

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Variables which can be shared with the stack - 3 bytes

CurrentRow	ds 1	; the current row being drawn in the gameplay kernel

FoodColor1	ds 1	; color of the 1st food item
FoodColor2	ds 1	; color of the 2nd food item

; 7 of 15 available temporary RAM bytes used (8 left)
; last 34 bytes of RAM are used to hold the rainbow color graphics

    ORG $100 - 34
RamBowColors
