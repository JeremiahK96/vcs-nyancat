 ; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables for First Five "Pixels"
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; left player graphics, always the same (5 bytes)
	.byte %00000001
	.byte %00000001
	.byte %00001000
	.byte %00100000
	.byte %11111111

; right player graphics, always the same (4 bytes)
	.byte %00100000
	.byte %00100000
	.byte %01000000
	.byte %10000000
	
; right player graphics for last "pixel" (6 bytes)
	.byte %00100000
	.byte %00100000
	.byte %00100000
	.byte %00100000
	.byte %00100000
	.byte %00101100	; (lsr to set ENAM0)



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables for Middle Twelve "Pixels"
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; left player graphics (72 bytes)
	.byte %00111000	; frame 1
	.byte %00000100
	.byte %00000001
	.byte %00000011
	.byte %00001111
	.byte %00011001
	.byte %00110011
	.byte %01100111
	.byte %01001101
	.byte %01111001
	.byte %00000001
	.byte %00000001

	.byte %00011000	; frame 2
	.byte %00000100
	.byte %00000001
	.byte %00000111
	.byte %00011001
	.byte %00100001
	.byte %01001111
	.byte %01001001
	.byte %00110001
	.byte %00000001
	.byte %00000001
	.byte %00000001

	.byte %00011000	; frame 3
	.byte %00000100
	.byte %00111101
	.byte %01000111
	.byte %01100001
	.byte %00011111
	.byte %00000011
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001

	.byte %00011000	; frame 4
	.byte %11000100
	.byte %01001001
	.byte %01001111
	.byte %00100001
	.byte %00011001
	.byte %00000111
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001

	.byte %01111000	; frame 5
	.byte %00001100
	.byte %00000001
	.byte %00000001
	.byte %00000111
	.byte %00111101
	.byte %11000011
	.byte %10001111
	.byte %01111001
	.byte %00000001
	.byte %00000001
	.byte %00000001

	.byte %01011000	; frame 6
	.byte %00001100
	.byte %00000001
	.byte %00000001
	.byte %00000111
	.byte %00011001
	.byte %00100001
	.byte %01001111
	.byte %01001001
	.byte %00110001
	.byte %00000001
	.byte %00000001

; right player graphics (24 bytes)
	.byte %00000100	; frame 1
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %00100010
	.byte %00110010
	.byte %00101100

	.byte %00000100	; frames 2/3/4/5
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %01100010
	.byte %01010010
	.byte %01001100

	.byte %11111000	; frame 6
	.byte %00000100
	.byte %11110010
	.byte %10010001
	.byte %00000001
	.byte %01011001
	.byte %00001001
	.byte %00000001
	.byte %00000010
	.byte %11000010
	.byte %00100010
	.byte %00110010



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables for Seventeenth "Pixel"
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Graphics Tables for Last Two "Pixels"
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; left player graphics (12 bytes)
	.byte %11110011	; frame 1
	.byte %10011010
	.byte %11100011	; frame 2
	.byte %10010100
	.byte %11100011	; frame 3
	.byte %10010100
	.byte %11100011	; frame 4
	.byte %10010100
	.byte %11100011	; frame 5
	.byte %10010100
	.byte %11100111	; frame 6
	.byte %10010100

; right player graphics (12 bytes)
	.byte %11100110	; frame 1
	.byte %00101001
	.byte %11100111	; frame 2
	.byte %00101001
	.byte %11100111	; frame 3
	.byte %00101001
	.byte %11100111	; frame 4
	.byte %00101001
	.byte %11100111	; frame 5
	.byte %00101001
	.byte %11100111	; frame 6
	.byte %00101001

; missile HMOVE (12 bytes)
	.byte $2E	; frame 1
	.byte $4A
	.byte $0E	; frame 2
	.byte $4C
	.byte $0E	; frame 3
	.byte $2A
	.byte $0E	; frame 4
	.byte $4C
	.byte $0E	; frame 5
	.byte $6E
	.byte $2E	; frame 6
	.byte $0A
