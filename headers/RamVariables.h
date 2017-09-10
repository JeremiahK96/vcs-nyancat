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

BCDLevel	ds 1	; value for the current level which will be stored as a
			; BCD encoded 2-digit number and used to control the
			; level counter display

ThrobFrame	ds 1	; offset for line throb animation frame

; temporary variables
Temp		ds 1
TempLoop	ds 1
