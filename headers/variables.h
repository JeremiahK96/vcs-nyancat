; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Define Ram Variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    RORG $80

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Global Variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; These variables are used globally and cannot be shared or otherwise corrupted
;
; Uses 13 bytes of RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

RamGlobal

; Game housekeeping - 2 bytes
Frame	ds 1	; current frame mod 256
Variation	; game variation options
	ds 1
		; ideas for variations :
	
		; players - 1 bit
		;	0 = 1 player, use player 2's score RAM to keep track
		;	of the highest score
		;	1 = 2 players, keep track of both scores, erasing any
		;	high score previously saved (might not need to erase
		;	high score based on free RAM)
		
		; randomness - 1 bit
		;	0 = leave Rand16 as-is at start of game and use player
		;	input to further randomize numbers
		;	1 = reset Rand16 at start of game and don't use
		;	player input to affect randomization
		;	(same exact game every time)
		
		; multi-speed rows - 1 bit
		;	0 = force all rows to be the same speed
		;	1 = allow levels to randomize row speeds
		
		; 5 bits still available

; Scores and current level - 7 bytes
BCDScore	; 3-byte array for the 2 scores which will each be stored as
	ds 6	; BCD encoded 6-digit numbers. First 3 bytes for player 1,
		; last 3 for player 2.
BCDLevel	; value for the current level which will be stored as a
	ds 1	; BCD encoded 2-digit number and used to control the
		; level counter display

; Random Numbers - 2 bytes
Rand16	ds 2	; 16-bit random number

; Cat colors - 2 bytes
CatTartColor	; color for current player's cat in the kernels
	ds 1
OtherTartColor	; color for the other player's cat
	ds 1


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Local Variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; These variables are only used locally, and are redefined for each area of code
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

RamLocal

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; These variables are only needed in the main menu routine.
;
; Uses 96 bytes of RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Frame counters - 2 bytes
MenuCatFrame	; animation frame for menu cat
	ds 1
MenuCatFrameX14	; animation frame for menu cat times 14
	ds 1

; Pointers - 8 bytes
MenuCatRamPtr	; pointer for loading menu cat gfx to push to the stack
MenuCatHmvPtrM	; pointer used to access HMOVE graphics for the missiles
	ds 2
MenuCatHmvPtrP	; pointer used to access HMOVE graphics for the players
	ds 2
MenuCatMslPtr	; pointer used to access missile graphics
	ds 2
BowColorsPfPtr	; pointer used to access rainbow colors in RAM
	ds 2

; Pre-load variables for within kernel - 4 bytes
RamMenuCatGfx	; GRP1 graphics in menu cat
	ds 1
RamMenuCatMissile	; missile graphics in menu cat
	ds 1
RainbowColorBk	; COLUBK rainbow color in menu cat
RainbowColorPf	; COLUPF rainbow color in menu cat
	ds 1
MenuCatShift
	ds 1

; Data blocks - 82 bytes
RamMenuCatGfxL	; GRP0 graphics for menu cat
	ds 14
RamMenuCatPfL	; left PF2 graphics for menu cat
	ds 15
RamMenuCatPfR	; right PF2 graphics for menu cat
	ds 15
RamMenuCatGfxR	; GRP1 graphics for menu cat
	ds 16
	ds 1	; extra byte needed for next data block
RamBowColorsBk	; rainbow colors
	ds 20
MenuBgColor	; menu background color in current color palatte (NTSC/PAL)
	ds 1

; 18 bytes free


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Gameplay variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; These variables are only needed in the gameplay routine
;
; Uses 55 bytes of RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	RORG RamLocal

; Pointers - 14 bytes

; The unused 3 bits of the high byte in each pointer
; may be used for the speeds of each row

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

; Variable game colors - 2 bytes
ScoreColor	ds 1	; color of the score text and scoreboard
PgBarColor	ds 1	; color for full part of progress bar

; Variables used when drawing the cat - 5 bytes
CatPosY	ds 1	; number of scanlines to skip before drawing cat
CatPosition	; data describing the cat's position
	ds 1	; bits 7-5 store the cat's row, from 1-7
		; bits 4-0 store the number of scanlines to skip after
		; top of the cat's row before drawing the cat, from 0-18
CatRow	ds 1	; the row that the cat is on or wants to be on/is moving towards
Rainbow		; PF0 value for the rainbow graphics
JoyCenter	; least significant bit, true if joystick has been returned to center
	ds 1
PreCatRows	; number of rows to draw before the two "cat" rows
	ds 1

; Variables used for the food items - 21 bytes
FoodItemL	; Hi nybble holds the value (0-15) of the right object to draw
	ds 7	; this frame.
		; Lo nybble either holds the pre-loaded value of the next
		; food item to appear in this row, or temporarily holds the
		; 3rd food item which isn't shown this frame, based on how many
		; food items are visible in this row (2-3), which is determined
		; by the position of the leftmost food item.
FoodItemR	; Hi nybble holds the value of the left object to draw
	ds 7	; this frame.
		; Lo nybble holds the fractional positional value
		; for the row's position (0-15).
FoodPosX	; (range 0-88)
	ds 7

; Variables for the progress bar and health display - 2 bytes
Progress	; value for level progress, which can be
	ds 1	; from 0 to 30 and will be used to draw progress bar
Health		; amount of health
	ds 1	; 0=full 8=medium 16=low 24=empty
ProgressBar	; array of 5 playfield values for progress bar
		; (shared with next 5 bytes of RAM)

; Variables used to pre-load for 2nd "cat" row's food items - 7 bytes
CatRowHmove	; array of 3 values to store to HMP1 before strobing
	ds 3	; HMOVE to position food items in 2nd cat row
CatRow2FoodL
	ds 1
CatRow2FoodR
	ds 1
CatRow2Color1
	ds 1
CatRow2Color2
	ds 1

; Variables for the throbbing lines' colors - 4 bytes
ThrobColor	ds 3	; 3-byte array for the colors used to draw the
			; throbbing lines. The first color is darkest,
			; the last is brightest.
CatThrobPF	ds 1

; Temporary variables - 2 bytes
Temp		ds 1
TempLoop	ds 1

; 51 bytes free

; Variables which can be shared with the stack - 3 bytes
CurrentRow	ds 1	; the current row being drawn in the gameplay kernel
FoodColor1	ds 1	; color of the 1st food item
FoodColor2	ds 1	; color of the 2nd food item

; 7 of 15 available temporary RAM bytes used (8 left)
; last 34 bytes of RAM are used to hold the rainbow color graphics

	RORG $100 - 34
RamBowColors
