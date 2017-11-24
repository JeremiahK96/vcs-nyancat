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

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; NUSIZx missile size

MSL_SIZE_1		equ	$00
MSL_SIZE_2		equ	$10
MSL_SIZE_4		equ	$20
MSL_SIZE_8		equ	$30

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; REFPx values

REFP_TRUE		equ	$08
REFP_FALSE		equ	$00

; CTRLPF values
PF_REFLECT		equ	$01
PF_SCORE_MODE		equ	$02
PF_PRIORITY		equ	$04
BALL_SIZE_1		equ	$00
BALL_SIZE_2		equ	$10
BALL_SIZE_4		equ	$20
BALL_SIZE_8		equ	$30

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; VDELxx values

VDEL_FALSE		equ	#0
VDEL_TRUE		equ	#1



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Program Equates
;
; Equates for constant program values.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; number of scanlines in vertical blank and overscan

VBLANK_SCANLINES	equ	#37
OVERSCAN_SCANLINES	equ	#29

; converted values to store to TIM64T

VBLANK_TIMER		equ	[[VBLANK_SCANLINES + 1] * 76 + 13] / 64
OVERSCAN_TIMER		equ	[[OVERSCAN_SCANLINES + 1] * 76 + 13] / 64

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; colors

COL_SCORE		equ $40
;COL_SCOREBOARD		equ $4C
COL_SCOREBOARD		equ $9E
COL_BACKGROUND		equ $90
COL_LINES		equ COL_BACKGROUND
COL_CAT_FACE		equ $06

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; luminosity masks, which can be added to any dark color to set the luminosity

LUM_0			equ $00
LUM_2			equ $02
LUM_4			equ $04
LUM_6			equ $06
LUM_8			equ $08
LUM_A			equ $0A
LUM_C			equ $0C
LUM_E			equ $0E
