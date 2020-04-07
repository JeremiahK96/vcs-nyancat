; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Menu Variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; These variables are only needed in the main menu routine.
;
; Uses 103 bytes of RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	RORG RamLocal

; Menu position and display - 2 bytes
CursorPos	; -----xxx	cursor position from 0-4
	ds 1
MenuPos		; -xxxxxxx	menu display position from 0-104
	ds 1

; Frame counters - 3 bytes
MenuCatFrame	; animation frame for menu cat
	ds 1
MenuCatFrameX14	; animation frame for menu cat times 14
	ds 1
MenuCatTiming	; xxxxx---	animation frame length offset from 0-26
	ds 1	; -----xxx	game frames left in current animation frame

; Pointers - 8 bytes
MenuTemp
MenuCatRamPtr	; pointer for loading menu cat gfx to push to the stack
MenuCatHmvPtrM	; pointer used to access HMOVE graphics for the missiles
	ds 2
MenuCatHmvPtrP	; pointer used to access HMOVE graphics for the players
TextColorPtr
	ds 2
MenuCatMslPtr	; pointer used to access missile graphics
	ds 2
BowColorsPfPtr	; pointer used to access rainbow colors in RAM
	ds 2

; Data blocks - 82 bytes
RamTxtColors
RamMenuCatGfxL	; GRP0 graphics for menu cat
	ds 14
TextHeight	; height of next text block
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

; Variables for menu display - 4 bytes
MenuTxtDelay	; -----xxx	line to start on in first text field
	ds 1	; -xxxx---	scanlines to skip before starting menu text
MenuTxtField	; -----xxx	first text field to display
	ds 3

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

; 9 bytes free

