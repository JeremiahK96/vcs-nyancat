; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Bank 1
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	START_BANK 1

	include init.asm
	include bank1/code/intro.asm
	include bank1/code/menu_init.asm
	include bank1/code/oscan_logic.asm
	include bank1/code/vblank_logic.asm
	include bank1/code/kernel.asm
	include bank1/code/music_engine.asm
	include bank1/data/menucatgfx.asm
	include bank1/data/colors.asm
	include bank1/data/getTxtField.asm
	include bank1/data/menutxtdlytbl.asm
	include bank1/data/music.asm

ZZZ_1

	END_BANK 1

