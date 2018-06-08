; Level 01

; level colors
	.byte #$06	; level u/i color
	.byte #$0E	; progress bar color

; row speeds
	.byte %00000000	; 00000xxx - maximum speed for level
			; 00xxx000 - maximum for random number to subtract

; random probability for individual food items (should all add up to 256)
	.byte 16	; blank
	.byte 16	; apple
	.byte 16	; peach
	.byte 16	; banana
	.byte 16	; pear
	.byte 16	; plum
	.byte 16	; grapes
	.byte 16	; broccoli
	.byte 16	; cabbage
	.byte 16	; celery
	.byte 16	; green pepper
	.byte 16	; pumpkin
	.byte 16	; mushroom
	.byte 16	; key
	.byte 16	; ring
	.byte 16	; heart

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>