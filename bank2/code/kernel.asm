; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Kernel
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	sta WSYNC
	SLEEP 3

; Include kernel routines
	include bank2/code/kernel_score.asm
	include bank2/code/kernel_gameplay.asm
	include bank2/code/kernel_health.asm

	jmp Overscan
