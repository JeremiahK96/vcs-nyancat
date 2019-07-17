; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Music Data Tables
;
; Uses 311 bytes total of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	ALIGN $100

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Equates for note frequencies
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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
NOTE_A5S	equ	128 + 16
NOTE_B5		equ	128 + 15
NOTE_C6S	equ	128 + 13
NOTE_E6		equ	128 + 11



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Note lengths in frames for each 18-note cycle, for 60Hz NTSC and 50Hz PAL.
; A full cycle in 60Hz mode is 114 frames long, or 95 frames for 50Hz mode.
; Either mode spends exactly 1.9 seconds for each 18-note cycle.
; At 4 notes per beat, this is very close to 142 BPM.
;
; Uses 37 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Volume envelopes for intro and song
;
; Uses 26 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

IntroVlm
	HEX	0F 0E 0D 0B 0A 09 08 07 06 05 04 03 02

MusicVlm
	HEX	09 0B 0D 0E 0F 0F 0F 0E 0D 0C 0A 09 07



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Melody Intro Sequence
;
; Uses 32 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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
	.byte	NOTE_A5S
	.byte	NOTE_B5
	.byte	NOTE_C6S
	.byte	NOTE_E6
	.byte	NOTE_C6S
	.byte	NOTE_E6
	.byte	NOTE_B5



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Melody Bass Sequence
;
; Uses 8 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

BassSeq
	HEX	0B 0A 0C 09 0D 0A 0F 0F



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Melody Lead Sequence Order
;
; Uses 16 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Melody Lead Sequences
;
; Uses 192 bytes of ROM
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

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



;

CatTimingNTSC
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 5
	.byte 4
	.byte 4
	.byte 4
	.byte 5
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 5
	.byte 4
	.byte 4
	.byte 4
	.byte 5
	.byte 4
	.byte 4
	.byte 4
	.byte 4
	.byte 5
	.byte 4
	.byte 4
	.byte 4
	.byte 5

CatTimingPAL
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 3
	.byte 4
	.byte 4

