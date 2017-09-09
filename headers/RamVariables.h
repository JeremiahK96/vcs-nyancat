; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Ram Variables
;
; Define labels for RAM locations to be used as variables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    SEG.U VARS
    ORG $80
    
RamStart

Frame		ds 1	; Current frame

BCDScore	ds 3	; 3-byte array for score value which will be stored as a
			; BCD encoded 6-digit number and used to control the
			; 6-digit score display

; pointers for digit graphics
;DigitPtr0	ds 2
;DigitPtr1	ds 2
;DigitPtr2	ds 2
;DigitPtr3	ds 2
;DigitPtr4	ds 2
;DigitPtr5	ds 2

BCDLevel	ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

;LvlGfxPtr	ds 2	; pointer for LevelGfx table

; temporary variables
Temp		ds 1
TempLoop	ds 1
