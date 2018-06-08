; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
;
; Bank 2
;
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	SUBROUTINE

; Clear all system RAM/registers and do any neccesary initialization

	include code/Initialize.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Game Logic
;
; Do the overscan, vertical sync, and vertical blanking,
; along with any game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	include code/Game Logic/Overscan.asm
	include code/Game Logic/VerticalSync.asm
	include code/Game Logic/VerticalBlank.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
;
; Draw the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	include code/Kernel.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Data Tables
;
; Include data tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	include data/Graphics.asm
