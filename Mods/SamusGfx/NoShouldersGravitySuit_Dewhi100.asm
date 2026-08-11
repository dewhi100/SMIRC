LoROM

;Hex tweaks to use the power suit gfx rather than varia when only gravity is equipped.
;No credit needed. This is too simple. Can if you want to though, I am not shy

org $90F26E : LDA #$0000


if !M2anim_Oi27 == 0
org $91D557 : NOP : NOP		;|not needed if using m2 varia. which overwrites these addresses anyway
org $91D561 : LDA #$0000	;/ 
endif

org $91D639 : LDA #$0000	;facing forward, power suit
org $91E403 : NOP : NOP	
org $91E74C : NOP : NOP
org $91E762 : NOP : NOP