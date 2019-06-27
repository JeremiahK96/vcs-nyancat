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

	.byte	6
NoteLengths
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

VlmEnvelope
	HEX	09 0B 0D 0E 0F 0F 0F
	HEX	0E 0D 0C 0A 09 07 05

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

MusicSeq1
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

MusicSeq2
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

MusicSeq3
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

MusicSeq4
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

MusicSeq5
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

MusicSeq6
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

MusicSeq7
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

MusicSeq8
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

MusicSeq9
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

MusicSeqA
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

MusicSeqB
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

