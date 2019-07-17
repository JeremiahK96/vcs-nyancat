; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Music Data Tables
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ALIGN $100

; equates for main voice's note frequencies
NOTE_HOLD	equ	0
NOTE_D4S	equ	16
NOTE_E4		equ	15
NOTE_F4S	equ	13
NOTE_G4S	equ	12
NOTE_A4S	equ	10
NOTE_B4		equ	128 + 31
NOTE_C5S	equ	128 + 27
NOTE_D5		equ	128 + 26
NOTE_D5S	equ	128 + 24
NOTE_E5		equ	128 + 23
NOTE_F5S	equ	128 + 20
NOTE_G5S	equ	128 + 18
NOTE_B5		equ	128 + 15
NOTE_C6S	equ	128 + 13
NOTE_D6		equ	128 + 12
NOTE_E6		equ	128 + 11
NOTE_F6		equ	128 + 10
NOTE_G6		equ	128 + 9
NOTE_A6		equ	128 + 8

; note lengths in frames - 37 bytes
	.byte	6
NoteLenNTSC
	.byte	6
	.byte	7
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	6
	.byte	7
	.byte	6
	.byte	6
	.byte	7
	.byte	6

NoteLenPAL
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	5
	.byte	6

BassSeq
	.byte $0B
	.byte $0A
	.byte $0C
	.byte $09
	.byte $0D
	.byte $0A
	.byte $0F
	.byte $0F

; main voice volume envelope - 14 bytes
VlmEnvelope
	HEX	09 0B 0D 0E 0F 0F 0F
	HEX	0E 0D 0C 0A 09 07 05

IntroVlm
	HEX	0F 0E 0D 0B 0A 09 08
	HEX	07 06 05 04 03 02 01

IntroSeq
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_F5S
	.byte	NOTE_HOLD
	.byte	NOTE_B5
	.byte	NOTE_HOLD
	.byte	NOTE_D5S
	.byte	NOTE_E5

	.byte	NOTE_F5S
	.byte	NOTE_B5
	.byte	NOTE_C6S
	.byte	NOTE_HOLD
	.byte	NOTE_C6S
	.byte	NOTE_E5
	.byte	NOTE_F5S
	.byte	NOTE_HOLD

	.byte	NOTE_F5S
	.byte	NOTE_HOLD
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_F5S
	.byte	NOTE_HOLD
	.byte	NOTE_B5
	.byte	NOTE_HOLD

	.byte	NOTE_C6S
	.byte	128 + 16
	.byte	NOTE_B5
	.byte	NOTE_C6S
	.byte	NOTE_E6
	.byte	NOTE_C6S
	.byte	NOTE_E6
	.byte	NOTE_B5

; music sequence order for main voice - 16 bytes
MusicSeqs
	HEX	00
	HEX	10
	HEX	20
	HEX	30
	HEX	00
	HEX	10
	HEX	20
	HEX	40
	HEX	50
	HEX	60
	HEX	70
	HEX	80
	HEX	50
	HEX	60
	HEX	70
	HEX	90

; music note sequences for main voice - 160 bytes
MusicSeq0
	.byte	NOTE_F5S
	.byte	NOTE_HOLD
	.byte	NOTE_G5S
	.byte	NOTE_HOLD
	.byte	NOTE_D5S
	.byte	NOTE_D5S
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_D5
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_C5S
	.byte	NOTE_HOLD

	.byte	NOTE_D5
	.byte	NOTE_HOLD
	.byte	NOTE_D5
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_F5S
	.byte	NOTE_G5S
	.byte	NOTE_D5S
	.byte	NOTE_F5S
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_B4

	.byte	NOTE_D5S
	.byte	NOTE_HOLD
	.byte	NOTE_F5S
	.byte	NOTE_HOLD
	.byte	NOTE_G5S
	.byte	NOTE_D5S
	.byte	NOTE_F5S
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_D5
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_C5S

	.byte	NOTE_D5
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_F5S
	.byte	NOTE_C5S
	.byte	NOTE_D5
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_C5S
	.byte	NOTE_HOLD

	.byte	NOTE_D5
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_F5S
	.byte	NOTE_C5S
	.byte	NOTE_D5
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD

	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_B4
	.byte	NOTE_E5
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_F5S

	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_F4S
	.byte	NOTE_E5
	.byte	NOTE_D5S
	.byte	NOTE_C5S
	.byte	NOTE_B4
	.byte	NOTE_F4S
	.byte	NOTE_D4S
	.byte	NOTE_E4
	.byte	NOTE_F4S

	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_B4
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_F4S

	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_A4S
	.byte	NOTE_B4
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_E5
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_F5S
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_A4S
	.byte	NOTE_HOLD

	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_A4S
	.byte	NOTE_B4
	.byte	NOTE_F4S
	.byte	NOTE_G4S
	.byte	NOTE_B4
	.byte	NOTE_E5
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_F5S
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_C5S
	.byte	NOTE_HOLD

	.byte	NOTE_D4S
	.byte	NOTE_E4
	.byte	NOTE_F4S
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_D4S
	.byte	NOTE_E4
	.byte	NOTE_F4S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_D5S
	.byte	NOTE_C5S
	.byte	NOTE_A4S
	.byte	NOTE_B4
	.byte	NOTE_HOLD

	.byte	NOTE_F4S
	.byte	NOTE_HOLD
	.byte	NOTE_D4S
	.byte	NOTE_E4
	.byte	NOTE_F4S
	.byte	NOTE_HOLD
	.byte	NOTE_B4
	.byte	NOTE_HOLD
	.byte	NOTE_C5S
	.byte	NOTE_A4S
	.byte	NOTE_B4
	.byte	NOTE_C5S
	.byte	NOTE_E5
	.byte	NOTE_D5S
	.byte	NOTE_E5
	.byte	NOTE_C5S

