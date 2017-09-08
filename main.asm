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
; 09-08-2017 Version 1.4
;
; Clean up and optimize code
;
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Initialization
;
; Include headers and set address of binary
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Add directories to be included from
    incdir headers/
    incdir code/
    incdir data/


; Define CPU type and include standard VCS header files
    PROCESSOR 6502
    
    include vcs.h
    include macro.h

; Include TIA/program equates and RAM labels
    include Equates.h
    include RamVariables.h


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

    include GameLogic.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
;
; Draw the screen
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    include Kernel.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Data Tables
;
; Include data tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; Include graphics data tables
    include Graphics.asm


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; End of ROM
;
; Define the end of the cartridge
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    ORG $FFFA		; set address to 6507 Interrupt Vectors 
    .WORD SystemClear	; NMI
    .WORD SystemClear	; RESET
    .WORD SystemClear	; IRQ
