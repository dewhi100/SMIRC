lorom

;takes a single parameter.
;if number of bosses killed >= param, state triggers.

org !free8F
bossCount:
PHY
PHX		;save index
LDY #$0000
LDX #$0004		;Norfair's area index
-
DEX
BEQ +
LDA $D828, x	;Boss bits
BIT #$0001
BEQ ++
INY
++
BRA -
+
PLX
LDA $0000,x		;state param: # of bosses req. to trigger
DEY
BMI +
DEC
BPL ++
BRA -
++
PLY
LDA $0001,x		;go to state
TAX
JMP $E5E6
+
PLY				;failure. advance to next state
INX
INX
INX
RTS

!free8F #= pc()