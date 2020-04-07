; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Global Variables
;
; These variables are used globally and cannot be shared or otherwise corrupted
; Uses 16 bytes of RAM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

RamGlobal

; Game housekeeping - 2 bytes
Frame	ds 1	; current frame mod 256
Variation	; game variation options
	ds 1	; x-------	60Hz or 50Hz mode
		; -x------	0 = show startup splash / 1 = show menu
		; --x-----	number of players
		; ---x----	current player
		; ----xx--	P2 difficulty
		; ------xx	P1 difficulty

; Random Numbers - 2 bytes
Rand16	ds 2	; 16-bit random number

; Music - 2 bytes
MusicNote	; xxxx----	current sequence
	ds 1	; ----xxxx	note in sequence
NoteData	; xxxxx---	note length table offset
	ds 1	; -----xxx	frames left in note

; Cat colors - 2 bytes
CatTartColor	; color for current player's cat in the kernels
	ds 1
OtherTartColor	; color for the other player's cat
	ds 1

; Scores and current level - 7 bytes
BCDScore	; 3-byte array for the 2 scores which will each be stored as
	ds 6	; BCD encoded 6-digit numbers. First 3 bytes for player 1,
		; last 3 for player 2.
Level		; value for the current level
	ds 1

; Controller data - 2 bytes
CtrlType	; xx------	controller types
		; 00------	joystick L, joystick R
		; 01------	joystick L, paddle R
		; 10------	paddle L, joystick R
		; 11------	paddle L, paddle L (left port only)
		; --x-----	free bit:
		; 		in menu, tells if controller has been detected
		; ---x----	previous fire button state (joystick or paddle)
		; ----xxxx	previous right/left/down/up (joystick only)
	ds 1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Local Variables
;
; These variables are only used locally, and are redefined for each area of code
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

RamLocal

