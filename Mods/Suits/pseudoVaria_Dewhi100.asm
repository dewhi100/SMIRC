;Pseudo-Varia effect when holding fully charged ice beam.
;By dewhi100
;Holding a fully charged Ice Beam will prevent damage from heated rooms, with an option to also reduce lava damage by half

LoROM

org $8DE379 
NOP : NOP
JSL ChargedIceCheck

;Lower lava damage
if !HalfDamageInLava != 0
	org $9081F7
	JSR CheckIce
	JSR HalfLava	;loads either subdamage + full lava subdamage, or subdamage + half lava damage, depending on result of CheckIce
	NOP	;filler
endif

org !free90
ChargedIceCheck:	;returns item flags, after bitmasking with varia and/or gravity
JSR CheckIce
BCS +
LDA $09A2	;if charge counter not 78 or euipped beams does not have ice, load normal item flags
if !HeatProofGravitySuit = 0
	AND #$0001	;CHANGE TO #$0021 TO INCLUDE GRAVITY
else
	AND #$0021	;CHANGE TO #$0021 TO INCLUDE GRAVITY
endif
RTL
+
LDA #$0001	;spoof the varia suit flag
RTL

CheckIce:	;carry clear if not fully charged ice. otherwise carry set
LDA $0CD0	;charge counter
CMP #$0078	;fully charged
BEQ +
-
CLC
RTS
+
LDA $09A6	;equipped beams
BIT #$0002	;ice
BEQ -		;branch if ice not equipped
SEC
RTS

if !HalfDamageInLava != 0
HalfLava:
	LDA #$8000	;lava damage over time
	BCC +
	CLC
	LSR
	+
	ADC $0A4E
	RTS
endif

!free90 #= pc()