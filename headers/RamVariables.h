; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80
    
RamStart

Frame		ds 1	; Current frame

ThrobFrame	ds 1	; offset for line throb animation frame

BCDScore	ds 3	; 3-byte array for score value which will be stored as a
			; BCD encoded 6-digit number and used to control the
			; 6-digit score display

BCDScoreAdd	ds 2	; 2-byte array for the value to be added to the score
			; on the next frame (max of 9,999)

BCDLevel	ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

ScoreColor	ds 1	; color of the score text and scoreboard

Progress	ds 1	; value for the level progress, which can be
			; from 0 to 30 and will be used to draw the progress bar

ProgressBar	ds 5	; array of the 5 values to be written to the playfield
			; registers when drawing the progress bar

PgBarColor	ds 1	; color for the full part of the progress bar

Health		ds 1	; amount of health
			; 0=full 8=medium 16=low 24=empty

HthGfxLPtr	ds 2	; pointer for the left half of the health graphics
HthGfxRPtr	ds 2	; pointer for the right half of the health graphics

CatPosY		ds 1	; number of scanlines to skip before drawing cat

PreCatRows	ds 1	; number of rows to draw before the two "cat" rows
PostCatRows	ds 1	; number of rows to draw after the two "cat" rows



; temporary variables which cannot be shared with stack space
TempLoop	ds 1

; 25 of 79 available bytes used

; temporary variables which can be shared with stack space
Temp		ds 1

; last 49 bytes are used for stack space
