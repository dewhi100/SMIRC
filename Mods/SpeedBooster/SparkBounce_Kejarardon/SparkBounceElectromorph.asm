;DO NOT COMPILE THIS FILE DIRECTLY.
;These are tweaks to SparkBounce for also supporting Electromorph. By itself, SparkBounce shouldn't use any of this code.
;If you want to combine the two, copy the below org sections to replace the same org sections in SparkBounceFunctions.asm

org $91FAD6
	BMI $22
	ASL A
	TAX
	JSL $B88090
	STA $0A58
	LDA #$E90E
	STA $0A60


org !Bank90FreeSpace
HookSuperjumpCollision:
	LDA $0617
	BIT #$0008
	BNE End
	LDA $0DD0
	BEQ End
	!EquipmentCheck()
	LDA $8B
	BIT $09B4
	BEQ End
	LDA #$000C
	JSL $80912F
	LDA #$0010
	JSL $80914D
	LDA #$F720
	STA $0A58
	LDA #$E913
	STA $0A60
	STZ $0DD0
	STZ $0A32
	LDA #$0001
	STA $0ACC
	LDA #$0020
	STA $0A68
	PLA
	PLA
	LDA $0A1E
	BIT #$0004
	BNE Left
	LDA #$0021
	STA $0A2C
	BRA End
Left:
	LDA #$0020
	STA $0A2C
End:
	LDA $0AF6
	RTS


;The below sections aren't replacing anything, just include them in SparkBounceFunctions.asm
org $B88090
	LDA $0617
	BIT #$0008
	BEQ Normal
	LDA #$D0DE
	RTS
Normal:
	LDA $FAFC,X
	RTL