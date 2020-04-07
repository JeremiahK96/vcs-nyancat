Txt_SPC	equ 0*7
Txt_A	equ 1*7
Txt_B	equ 2*7
Txt_C	equ 3*7
Txt_D	equ 4*7
Txt_E	equ 5*7
Txt_F	equ 6*7
Txt_G	equ 7*7
Txt_H	equ 8*7
Txt_I	equ 9*7
Txt_J	equ 10*7
Txt_K	equ 11*7
Txt_L	equ 12*7
Txt_M	equ 13*7
Txt_N	equ 14*7
Txt_P	equ 15*7
Txt_Q	equ 16*7
Txt_R	equ 17*7
Txt_S	equ 18*7
Txt_T	equ 19*7
Txt_U	equ 20*7
Txt_V	equ 21*7
Txt_W	equ 22*7
Txt_X	equ 23*7
Txt_Y	equ 24*7
Txt_Z	equ 25*7
Txt_0	equ 26*7
Txt_1	equ 27*7
Txt_2	equ 28*7
Txt_3	equ 29*7
Txt_4	equ 30*7
Txt_5	equ 31*7
Txt_6	equ 32*7
Txt_7	equ 33*7
Txt_8	equ 34*7
Txt_9	equ 35*7



	ALIGN $100
FontGfx0
	incbin bank3/data/font_gfx0.bin

	ALIGN $100
	incbin bank3/data/font_gfx1.bin

	ALIGN $100
	incbin bank3/data/font_gfx2.bin



	ALIGN $100
FontText
	.byte Txt_SPC	; 0
	.byte Txt_SPC
	.byte Txt_SPC
	.byte Txt_SPC
	.byte Txt_SPC

	.byte Txt_SPC	; 5
	.byte Txt_SPC
	.byte Txt_SPC
	.byte Txt_B
	.byte Txt_Y
	.byte Txt_SPC

	.byte Txt_SPC	; 11
	.byte Txt_SPC
	.byte Txt_F
	.byte Txt_I
	.byte Txt_R
	.byte Txt_E

	.byte Txt_SPC	; 17
	.byte Txt_SPC
	.byte Txt_B
	.byte Txt_A
	.byte Txt_C
	.byte Txt_K

	.byte Txt_SPC	; 23
	.byte Txt_SPC
	.byte Txt_N
	.byte Txt_E
	.byte Txt_X
	.byte Txt_T

	.byte Txt_SPC	; 29
	.byte Txt_SPC
	.byte Txt_E
	.byte Txt_A
	.byte Txt_S
	.byte Txt_Y

	.byte Txt_SPC	; 35
	.byte Txt_SPC
	.byte Txt_G
	.byte Txt_A
	.byte Txt_M
	.byte Txt_E

	.byte Txt_SPC	; 41
	.byte Txt_SPC
	.byte Txt_0
	.byte Txt_V
	.byte Txt_E
	.byte Txt_R

	.byte Txt_SPC	; 47
	.byte Txt_SPC
	.byte Txt_K
	.byte Txt_N
	.byte Txt_0
	.byte Txt_L

	.byte Txt_SPC	; 53
	.byte Txt_SPC
	.byte Txt_2
	.byte Txt_0
	.byte Txt_1
	.byte Txt_9

	.byte Txt_SPC	; 59
	.byte Txt_SPC
	.byte Txt_P
	.byte Txt_R
	.byte Txt_E
	.byte Txt_S
	.byte Txt_S

	.byte Txt_SPC	; 66
	.byte Txt_SPC
	.byte Txt_S
	.byte Txt_T
	.byte Txt_A
	.byte Txt_R
	.byte Txt_T

	.byte Txt_SPC	; 73
	.byte Txt_SPC
	.byte Txt_C
	.byte Txt_0
	.byte Txt_L
	.byte Txt_0
	.byte Txt_R

	.byte Txt_SPC	; 80
	.byte Txt_SPC
	.byte Txt_S
	.byte Txt_H
	.byte Txt_A
	.byte Txt_D
	.byte Txt_E

	.byte Txt_SPC	; 87
	.byte Txt_SPC
	.byte Txt_R
	.byte Txt_E
	.byte Txt_A
	.byte Txt_D
	.byte Txt_Y

	.byte Txt_SPC	; 94
	.byte Txt_SPC
	.byte Txt_V
	.byte Txt_I
	.byte Txt_D
	.byte Txt_E
	.byte Txt_0

	.byte Txt_SPC	; 101
	.byte Txt_SPC
	.byte Txt_C
	.byte Txt_H
	.byte Txt_R
	.byte Txt_I
	.byte Txt_S

	.byte Txt_SPC	; 108
	.byte Txt_N
	.byte Txt_0
	.byte Txt_V
	.byte Txt_I
	.byte Txt_C
	.byte Txt_E

	.byte Txt_SPC	; 115
	.byte Txt_E
	.byte Txt_X
	.byte Txt_P
	.byte Txt_E
	.byte Txt_R
	.byte Txt_T

	.byte Txt_SPC	; 122
	.byte Txt_T
	.byte Txt_H
	.byte Txt_A
	.byte Txt_N
	.byte Txt_K
	.byte Txt_S

	.byte Txt_SPC	; 129
	.byte Txt_T
	.byte Txt_0
	.byte Txt_SPC
	.byte Txt_T
	.byte Txt_H
	.byte Txt_E

	.byte Txt_SPC	; 136
	.byte Txt_T
	.byte Txt_0
	.byte Txt_R
	.byte Txt_R
	.byte Txt_E
	.byte Txt_S

	.byte Txt_SPC	; 143
	.byte Txt_C
	.byte Txt_R
	.byte Txt_E
	.byte Txt_A
	.byte Txt_T
	.byte Txt_E
	.byte Txt_D

	.byte Txt_SPC	; 151
	.byte Txt_S
	.byte Txt_P
	.byte Txt_E
	.byte Txt_C
	.byte Txt_I
	.byte Txt_A
	.byte Txt_L

	.byte Txt_SPC	; 159
	.byte Txt_C
	.byte Txt_R
	.byte Txt_E
	.byte Txt_A
	.byte Txt_T
	.byte Txt_0
	.byte Txt_R

	.byte Txt_S	; 167
	.byte Txt_E
	.byte Txt_T
	.byte Txt_SPC
	.byte Txt_N
	.byte Txt_A
	.byte Txt_M
	.byte Txt_E

	.byte Txt_1	; 175
	.byte Txt_SPC
	.byte Txt_P
	.byte Txt_L
	.byte Txt_A
	.byte Txt_Y
	.byte Txt_E
	.byte Txt_R

	.byte Txt_2	; 183
	.byte Txt_SPC
	.byte Txt_P
	.byte Txt_L
	.byte Txt_A
	.byte Txt_Y
	.byte Txt_E
	.byte Txt_R

	.byte Txt_A	; 191
	.byte Txt_D
	.byte Txt_V
	.byte Txt_A
	.byte Txt_N
	.byte Txt_C
	.byte Txt_E
	.byte Txt_D

	.byte Txt_J	; 199
	.byte Txt_E
	.byte Txt_R
	.byte Txt_E
	.byte Txt_M
	.byte Txt_I
	.byte Txt_A
	.byte Txt_H

	.byte Txt_0	; 207
	.byte Txt_R
	.byte Txt_I
	.byte Txt_G
	.byte Txt_I
	.byte Txt_N
	.byte Txt_A
	.byte Txt_L

	.byte Txt_N	; 215
	.byte Txt_Y
	.byte Txt_A
	.byte Txt_N
	.byte Txt_SPC
	.byte Txt_C
	.byte Txt_A
	.byte Txt_T

