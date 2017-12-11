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
; 12-11-2017 Version 2.2
;
; Optimize cycle timings in the cat row kernel loop
; Add 2nd version of kernel for different food positions
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

; Include TIA/program equates and RAM labels

    include headers/Equates.h
    include headers/RamVariables.h

; Ensure that the code is placed in the proper place in the binary

    SEG CODE
    ORG $F000	; 4K ROM


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
; Do the overscan, vertycal sync, and vertical blanking,
; along with any game logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    include code/GameLogic.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
;
; Draw the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    include code/Kernel.asm
    
Z_EndOfCode	; label to show how much ROM is used for the code


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Data Tables
;
; Include data tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Include graphics data tables
    include data/Graphics.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End of ROM
;
; Define the end of the cartridge
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ORG $FFFA		; set address to 6507 Interrupt Vectors 
    .WORD SystemClear	; NMI
    .WORD SystemClear	; RESET
    .WORD SystemClear	; IRQ
