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

VDEL_FALSE		equ	0
VDEL_TRUE		equ	1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; ENAMx / ENABL values

ENA_TRUE		equ	%00000010
ENA_FALSE		equ	0



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Program Equates
;
; Equates for constant program values.
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

; number of scanlines in vertical blank and overscan

VBLANK_SCANLINES	equ	37
OVERSCAN_SCANLINES	equ	29

; converted values to store to TIM64T

VBLANK_TIMER		equ	[[VBLANK_SCANLINES + 1] * 76 + 13] / 64
OVERSCAN_TIMER		equ	[[OVERSCAN_SCANLINES + 1] * 76 + 13] / 64

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; colors

COL_SCORE		equ $7A
COL_SCOREBOARD		equ $70
COL_BACKGROUND		equ $00
COL_CAT_FACE		equ $09
COL_CAT_TART		equ $4A

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; luminosity values for throb line data

LUM_0			equ $00>>1
LUM_2			equ $02>>1
LUM_4			equ $04>>1
LUM_6			equ $06>>1
LUM_8			equ $08>>1
LUM_A			equ $0A>>1
LUM_C			equ $0C>>1
LUM_E			equ $0E>>1

; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; color modes for throb line data

MODE_GREY		equ $80	; for greyscale lines
MODE_COLOR		equ $00	; for colored lines

END_FOOD		equ #%00000001	; any value not present in food graphics
