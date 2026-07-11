lorom

;Random Room States
;by dewhi100

;Creates a new room state. Use this check, and assign it a property of X
;The state will have a one in X chance of happening.
;Failing to trigger the state will fall through to the next check, just like usual.
;You can put multiple of these in a row. 
;For example, a state with a 1/3 chance, followed by a state with a 1/2 chance, followed by a default, if you want an equal shot for all of them to happen.
;Can be good for mixing up enemy arrangements, or just screwing with the player.
;For example, I used this for the headache-inducing Phantoon maze in Super Ethical Metroid.

org !free8F
print "Random Room State: ", pc
RandomStateTest:
LDA $0000,x
AND #$00FF
JSR GetRandomInRange
BNE +
LDA $0001,x
TAX
JMP $E5E6
+
INX
INX
INX
RTS

;Generate random number between 0 and value in Accumulator 
GetRandomInRange:
PHP
SEP #$20
PHA
LDA $05E5	;a random number
STA $4204	;Dividend (The number you are dividing)
PLA			;the testcode in SMART
STA $4206	;Divisor. Begins division. Division takes 16 cycles.
PLP			;4 Cycles
NOP			;2 Cycles
NOP			;2 Cycles
NOP			;2 Cycles
NOP			;2 Cycles
NOP			;2 Cycles
NOP			;2 Cycles
LDA $4216	;A = random number between 0 and A	;4216 is the remainder register
RTS

!free8F #= pc()
