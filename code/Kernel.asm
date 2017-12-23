; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

    lda #0
    ldy ScoreColor
    sta WSYNC
    sta VBLANK	; enable display

; Include kernel routines
    include code/ScoreboardKernel.asm
    include code/Gameplay Kernel/GameplayKernel.asm
    include code/ProgressHealthKernel.asm
    
    lda #2
    sta VBLANK	; disable display
    
    jmp Overscan
