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
; 01-08-2018 Version 2.7
;
; Redesign the scoreboard kernel
;
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Initialization
;
; Include headers and set address of binary
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Define CPU type and include standard VCS header files
    PROCESSOR 6502
    
    include headers/vcs.h
    include headers/macro.h

; Include TIA/program equates, RAM labels, and macros

    include headers/Equates.h
    include headers/RamVariables.h
    include headers/Macros.h

; Ensure that the code is placed in the proper place in the binary

    SEG CODE
    ORG $1000	; 4K ROM


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Full System Clear
;
; Clear all system registers and RAM at startup
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

SystemClear:

    CLEAN_START


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
    
Z_EndOfCode	.byte 0	; label to show how much ROM is used for the code


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Data Tables
;
; Include data tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Include graphics data tables
    include data/Graphics.asm
    
Z_EndOfGfx	.byte 0	; label to show how much ROM is used for the graphics


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End of ROM
;
; Define the end of the cartridge
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ORG SystemClear+$0FFA	; set address to 6507 Interrupt Vectors 
    .WORD SystemClear		; NMI
    .WORD SystemClear		; RESET
    .WORD SystemClear		; IRQ
