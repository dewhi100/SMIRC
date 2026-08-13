LoROM

;Hex tweaks to use the power suit gfx rather than varia when only gravity is equipped.
;No credit needed. This is too simple. Can credit if you want to though, I am not shy

org $90F26E : JSR PowerGravityPose

if !M2anim_Oi27 == 0
org $91D557 : NOP : NOP		;|not needed if using m2 varia. which overwrites these addresses anyway
org $91D561 : LDA #$0000	;/ 
endif

org $91E403 : NOP : NOP	
org $91E74C : NOP : NOP
org $91E762 : NOP : NOP

org !free90
PowerGravityPose:
LDA $09A2	;equipped items
BIT #$0001	;varia
BEQ +
LDA #$009B : RTS
+
LDA #$0000 : RTS
!free90 #= pc()