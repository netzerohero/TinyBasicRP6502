
;  BREAK TEST FOR KIM
; 
		.org $0100
;
; TASM syntax
;
; KIM defines 
;
OUTCH    = $1EA0          ; KIM character output routine
KTTY	 = $1740		  ; Break test if PB7 low at TTY input  
		
KIMBT	lda	KTTY			;Look at TTY bit PB7
		clc					;C=O IF IDLE
		bmi	KIMX			;IDLE
KLO		lda	KTTY			;WAIT FOR END
		bpl	KLO
KLDY	jsr	KIMDL
KIMDL	lda	#255			;DELAY 2 RUBOUT TIMES
		jsr	OUTCH
		sec					; C=1 IF BREAK
KIMX	rts

	.end