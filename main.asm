; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
;
; Project - Nyan Cat Game
; by Jeremiah Knol
;
; Make a game based off of "Nyan Cat FLY!" on addictinggames.com
; http://www.addictinggames.com/funny-games/nyan-cat-fly-game.jsp
;
;
;
; 06-08-2018 Version 4.0
;
; Add bankswitching and menu's cat kernel
;
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Initialize DASM
;
; Define CPU, include header files, and set binary address
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	PROCESSOR 6502
	
	include headers/vcs.h
	include headers/macro.h
	
	include headers/Equates.h
	include headers/RamVariables.h
	include headers/Macros.h


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Include 4K banks
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	START_BANK 1
	include Bank1.asm
	END_BANK 1
	
	START_BANK 2
	include Bank2.asm
	END_BANK 2
	
	START_BANK 3
	include Bank3.asm
	END_BANK 3
	
	START_BANK 4
	include Bank4.asm
	END_BANK 4
