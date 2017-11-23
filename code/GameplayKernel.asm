; The rainbow will be drawn using both the playfield (PF0) and the background.

; The pop-tart will be a single-color rectangle drawn with the background.

; The cat's head and front paws will be drawn with player 0. If it is possible,
; the rear paws will be drawn with missile 0.

; All the food items will be drawn with player 1. It's NUSIZ will be set to
; 2 copies wide, and it will use flicker to draw up to 4 food items per row,
; 2 for each frame.

; The cat's face color will be drawn with the ball, behind the head.

; The PF0 register will be written to twice per scanline, the playfield
; color will be set twice per scanline, and the background color 3 times
; per scanline. If this is not possible, I can draw the rainbow with only the
; playfield, saving 2 register writes at the expense of graphics.

; Player 0's graphics will be written to once per scanline, while player 1's
; will be written to twice. Player 0's color will never change, while player 1's
; will need also 2 writes per scanline.

; The ball will also need to be enabled or disabled each scanline. I am planning
; on using the graphics table for PF0 to control the ball and missile as well,
; since PF0 only uses the 4 high bits, saving cycles by only having to read once
; for three writes (a shift will be neccesary).

; I may have to push some of the cat graphics onto the stack to save cycles
; in the kernel. I can reuse the RAM that was needed to draw the score graphics.



; Output 4 blank scanlines, while setting up the graphics objects.
PreKernel:
    
    ; Align player 0 and the ball for drawing the cat's face, set up both
    ; missiles to draw the rear paws, and align player 1 to draw
    ; the current frame's food items for the top row.

    ; Depending on how tight the cycles will be, it may also be neccesary to push
    ; some of the graphics into RAM here so they can be loaded more quickly
    ; in the kernel.
    
    ; If any part of the cat needs to be drawn in the top row,
    ; skip straight to CatRows.



; Draw all the rows above the cat's two rows.
HiRows:

    ; First, output a single-color line to draw the bottom of a "throb" line.
    ; This will probably be a good time to prepare the pointers for the
    ; food items' graphics, as well as loading the colors for the food items.
    
    ; After that, output 14 lines to draw a single row with food items,
    ; but without drawing the cat. The food graphics will be updated every line,
    ; but there will probably not be enough time to also update the food colors
    ; every line throughout the kernel.
    
    ; Lastly, output four single-color lines to draw most of a "throb" line,
    ; while setting the position of player 1 to draw the next set of food items.
    
    ; If this is not the last row before drawing the cat's rows,
    ; loop back to HiRows to draw the next row.



; Draw the two rows that contain the cat.
CatRows:

    ; Output a line to finish the bottom of a "throb" line, like in HiRows.
    ; If the cat is at the very top of the row, draw the top of the pop-tart.
    
    ; Then output the 14 lines to draw a single row. This will include drawing
    ; the rainbow, the pop-tart, the head and face or paws, and the food items.
    ; All graphics will be updated every line.
    
    ; Then output the 5 lines to draw a "throb" line, but also draw the entire
    ; cat with the rainbow. In order to align player 1 for the next row's
    ; food items, it will be neccesary to have three versions of this kernel,
    ; one for each of the three 60-color-clock spaced positions to reset.
    ; HMOVE will be written to on the first four scanlines. With a maximum
    ; movement of 15 color-clocks per scanline, this will allow a movement of
    ; up to 60 color clocks. With three versions of the kernel, it should be
    ; possible to put player 1 anywhere on the screen.
    
    ; Then output 14 lines to draw the next row, exactly the same way as the
    ; previous one. It will be neccesary to have multiple versions of this, as well,
    ; since GRP1 needs to be updated at the correct time depending on the position
    ; of player 1.
    
    ; Lastly, output only one line (not four) to draw the top of a "throb" line.
    ; Use this time to prepare the next row's food item pointers (unless this is
    ; the last row). If this is the last row, skip over LoRows.
    
    ; If the cat is at the very bottom of the screen, don't disable the
    ; missile/player graphics until after they are drawn, so they don't get
    ; clipped at the bottom of the screen. An easy way to do this would be to
    ; simply disable them after they would have been drawn, whether they are
    ; already disabled or not.











; Draw all the rows below the cat's two rows.
LoRows:

    ; Output 4 lines, drawing the rest of the "throb" line, while preparing
    ; player 1 for the next row's food items.
    
    ; Output 14 lines to draw a row, exactly the same as in HiRows.
    ; It may be possible to code this as a subroutine to save ROM space.
    
    ; Lastly, output     
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #$00
    sta PF0
    sta PF1

    ldx #6
KernelLoopA	; draw the gameplay display
    
    
        
    lda #COL_BACKGROUND
    sta COLUBK

    ldy #14
KernelLoopC	; draw a row
    sta WSYNC

    dey
    bne KernelLoopC
    
    ; draw a row seperator
    

    ldy ThrobFrame
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+2,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx+1,y
    sta COLUBK
    sta WSYNC
    
    lda #LineThrobGfx,y
    sta COLUBK
    sta WSYNC


    dex
    bne KernelLoopA


    lda #COL_BACKGROUND
    sta COLUBK
    
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
