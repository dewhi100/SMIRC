;Local Gravity by dewhi100

;the value in !localGravity will be addded to gavitational subacceleration.
;On enteing a room, !localGravity is initialized to whatever is in "Room Var" (the unused thing at the bottom of the header data in SMART)
;Equippping gravity suit negates any local modifications to gravity.
;!localGravity can be modified by room ASM for dynamic changes (ex. syncing it with a rising and falling glow fx, or with a flexglow cycle)

;This doesn't play very nicely with Flex Glow, which also uses the room var. Setting !resetGravityMode to 1 or 2 will fix that.

lorom

org $8FE893
JSR setLocalGravity

org !free8F
setLocalGravity:
LDX $07BB
if !resetGravityMode == 2
	STZ !localGravity
	RTS
else
	LDA $8F0010, X
	if !resetGravityMode == 0
		BMI +
	endif
	STA !localGravity
	+
	RTS
endif

!free8F #= pc()

org $909C7E
JSR addLocalGravity

org $909C94
JSR addLocalGravity

org $909CA2
JSR addLocalGravity

org !free90
addLocalGravity:
PHA
LDA $09A2
BIT #$0020
BEQ +
PLA
STA $0B32
RTS
+
PLA
CLC
ADC !localGravity
STA $0B32
RTS

!free90 #= pc()