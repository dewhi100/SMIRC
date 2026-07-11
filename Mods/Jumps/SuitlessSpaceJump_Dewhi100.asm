lorom
;Suitless Space Jump, by dewhi100

;Overwriting the branch that would bypass space jump while suitless. This is what allows SJ to trigger.
org $90A46C
NOP : NOP

org $90A4C4
JSR Bubblejump : NOP

;Fine-tuning the window during which another jump is possible. This is what keeps the jumps mostly horizontal.
org $909E9B 
DW $0180	;Minimum Y velocity needed to space jump under water. was DW $0080
DW $0A00	;Maximum Y velocity needed to space jump under water. was DW $0500

org !free90
Bubblejump:
JSL $9098BC
JSR $8156
JSR $8156
RTS

!free90 #= pc()

;;; $813E: Spawn air bubbles ;;;