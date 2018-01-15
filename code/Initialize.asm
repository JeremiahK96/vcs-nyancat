; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Full System Clear
;
; Clear all system registers and RAM at startup
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

SystemClear:

	CLEAN_START



; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
; Set the food items (temporary demo code)
; <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

	lda #$10
	sta FoodItemL+0
	lda #$70
	sta FoodItemR+0
	
	lda #$20
	sta FoodItemL+1
	lda #$80
	sta FoodItemR+1
	
	lda #$30
	sta FoodItemL+2
	lda #$90
	sta FoodItemR+2
	
	lda #$40
	sta FoodItemL+3
	lda #$A0
	sta FoodItemR+3
	
	lda #$50
	sta FoodItemL+4
	lda #$B0
	sta FoodItemR+4
	
	lda #$60
	sta FoodItemL+5
	lda #$C0
	sta FoodItemR+5
	
	lda #$D0
	sta FoodItemL+6
	lda #$E0
	sta FoodItemR+6