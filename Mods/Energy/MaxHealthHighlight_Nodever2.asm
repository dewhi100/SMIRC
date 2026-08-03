;hilite-health-at-max by nodever2
lorom

org $809BFB : LDA #$9DBF ;ammo & health to share tilemaps
org $809BEE : JSR HealthColor

org $809DD3
dw $2809,$2800,$2801,$2802,$2803,$2804,$2805,$2806,$2807,$2808
warnpc $809DE7

org !free80	;free space in $80
HealthColor:
{
LDA #$9DBF
LDY $09C2 : CPY $09C4 : BNE +
	LDA #$9DD3
+
RTS
}

!free80 #= pc()