; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; TIA Register Value Equates
;
; Equates for values for the TIA registers.
; These can be OR'ed together, for example:
;     lda #TWO_CLOSE | MSL_SIZE_4
;     sta NUSIZ0
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; NUSIZx player size and player/missile copies
ONE_COPY		equ	$00
TWO_CLOSE		equ	$01
TWO_MED			equ	$02
THREE_CLOSE		equ	$03
TWO_WIDE		equ	$04
DOUBLE_SIZE		equ	$05
THREE_MED		equ	$06
QUAD_SIZE		equ	$07

; NUSIZx missile size
MSL_SIZE_1		equ	$00
MSL_SIZE_2		equ	$10
MSL_SIZE_4		equ	$20
MSL_SIZE_8		equ	$30

; CTRLPF values
PF_REFLECT		equ	$01
PF_SCORE_MODE		equ	$02
PF_PRIORITY		equ	$04
BALL_SIZE_1		equ	$00
BALL_SIZE_2		equ	$10
BALL_SIZE_4		equ	$20
BALL_SIZE_8		equ	$30

; VDELxx values
VDEL_FALSE		equ	#0
VDEL_TRUE		equ	#1



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Program Equates
;
; Equates for constant program values.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; colors
COL_SCORE		equ $42
COL_SCOREBOARD		equ $9E
COL_BACKGROUND		equ $90
