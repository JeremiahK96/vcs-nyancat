; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Vertical Sync and Logic
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	VERT_SYNC		; 11

	include bank1/code/music.asm
	include bank1/code/auto_detect.asm
	include bank1/code/process_input.asm	
	include bank1/code/menucat_anim.asm
	include bank1/code/load_cat_ram.asm
	include bank1/code/menu_text_prep.asm

	TIMER_LOOP

