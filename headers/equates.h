; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; TIA Register Value Equates
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; NUSIZx player size and player/missile copy spacing values
ONE_COPY		equ	0
TWO_CLOSE		equ	1
TWO_MED			equ	2
THREE_CLOSE		equ	3
TWO_WIDE		equ	4
DOUBLE_SIZE		equ	5
THREE_MED		equ	6
QUAD_SIZE		equ	7

; NUSIZx missile size values
MSL_SIZE_1		equ	$00
MSL_SIZE_2		equ	$10
MSL_SIZE_4		equ	$20
MSL_SIZE_8		equ	$30

; REFPx values
REFP_TRUE		equ	8
REFP_FALSE		equ	0

; CTRLPF values
PF_REFLECT		equ	$01
PF_SCORE_MODE		equ	$02
PF_PRIORITY		equ	$04
BALL_SIZE_1		equ	$00
BALL_SIZE_2		equ	$10
BALL_SIZE_4		equ	$20
BALL_SIZE_8		equ	$30

; VDELxx values
VDEL_FALSE		equ	0
VDEL_TRUE		equ	1

; ENAMx / ENABL values
ENA_TRUE		equ	2
ENA_FALSE		equ	0


; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Program Equates
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; number of scanlines in vertical blank and overscan
VBLANK_SCANLINES	equ	37
OVERSCAN_SCANLINES	equ	29

; converted values to store to TIM64T
VBLANK_TIMER		equ	[[VBLANK_SCANLINES + 1] * 76 + 13] / 64
OVERSCAN_TIMER		equ	[[OVERSCAN_SCANLINES + 1] * 76 + 13] / 64

; colors
COL_SCORE		equ $7A
COL_SCOREBOARD		equ $70
COL_BACKGROUND		equ $00
COL_CAT_FACE		equ $09
COL_CAT_TART		equ $4A

; luminosity values for throb line data
LUM_0			equ $0>>1
LUM_2			equ $2>>1
LUM_4			equ $4>>1
LUM_6			equ $6>>1
LUM_8			equ $8>>1
LUM_A			equ $A>>1
LUM_C			equ $C>>1
LUM_E			equ $E>>1

; color modes for throb line data
MODE_GREY		equ $80	; for greyscale throb lines
MODE_COLOR		equ $00	; for colored throb lines

GAMEPLAY_STACK		equ $DD	; stack location during gameplay kernel

; bankswitching hotspots
SelectBank1		equ $1FF6
SelectBank2		equ $1FF7
SelectBank3		equ $1FF8
SelectBank4		equ $1FF9
