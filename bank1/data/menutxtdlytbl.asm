MenuTxtDlyTbl

	.byte (0 << 4)	+ (6 << 1) +	0
	.byte (1 << 4)	+ (5 << 1) +	0
	.byte (0 << 4)	+ (5 << 1) +	0
	.byte (1 << 4)	+ (4 << 1) +	0
	.byte (0 << 4)	+ (4 << 1) +	0
	.byte (1 << 4)	+ (3 << 1) +	0
	.byte (0 << 4)	+ (3 << 1) +	0
	.byte (1 << 4)	+ (2 << 1) +	0
	.byte (0 << 4)	+ (2 << 1) +	0
	.byte (1 << 4)	+ (1 << 1) +	0
	.byte (0 << 4)	+ (1 << 1) +	0
	.byte (1 << 4)	+ (0 << 1) +	0
	.byte (0 << 4)	+ (0 << 1) +	0
	.byte (8 << 4)	+ (6 << 1) +	1
	.byte (7 << 4)	+ (6 << 1) +	1
	.byte (6 << 4)	+ (6 << 1) +	1
	.byte (5 << 4)	+ (6 << 1) +	1
	.byte (4 << 4)	+ (6 << 1) +	1
	.byte (3 << 4)	+ (6 << 1) +	1
	.byte (2 << 4)	+ (6 << 1) +	1
	.byte (1 << 4)	+ (6 << 1) +	1

JoyUpDnMask
	.byte %11001111
	.byte %11111100

SetJoyMask
	.byte %01100000
	.byte %10100000

SetPdlMask
	.byte %10100000
	.byte %01100000

PdlFireMask
	.byte %10000000
	.byte %01000000
	.byte %00001000

Mult21	.byte 0
	.byte 21
	.byte 42
	.byte 63
	.byte 84

