; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	lda #0
	sta WSYNC
	sta VBLANK	; enable display

; Include kernel routines
	include bank2/code/kernel_score.asm
	include bank2/code/kernel_gameplay.asm
	include bank2/code/kernel_health.asm

	lda #2
	sta VBLANK	; disable display

	jmp Overscan
