;Missiles deal xtra damage to frozen enemies
;----------
lorom

!A0Free = $A0FF00

org $A0A74A : JSR IceDamage ;hijack enemy shot damage calculation | LDA $187A

org !A0Free
IceDamage:
;if enemy is frozen && incoming damage is super/missile then INC the damage multiplier
PHX
LDX $0E54
LDA $0F9E,x : BEQ .out
	LDA $18A6 : ASL : TAX
	LDA $0C18,x : AND #$0F00
	CMP #$0100 : BEQ +
	CMP #$0200 : BNE .out
	+
	INC $0E32
.out
PLX
LDA $187A
RTS