lorom

org $908007
JSR SpiderCheckAndCollision

org $908ED7
JSR Rightwards

org $908F11
JSR Rightwards

org $908F7C
JSR Rightwards

org $90931D
JSR Rightwards

org $90ED19
JSR Rightwards

org $908EDB
JSR Leftwards

org $908F16
JSR Leftwards

org $908F81
JSR Leftwards

org $909322
JSR Leftwards

org $90ED08
JSR Leftwards

org $909163
JSR Upwards

org $909232
JSR Upwards

org $909283
JSR Upwards

org $9092B3
JSR Upwards

org $90ECE6
JSR Upwards

org $908FAE
JSR Downwards

org $90915E
JSR Downwards

org $90922D
JSR Downwards

org $9092AE
JSR Downwards

org $90927E
JSR Downwards

org $90ECE6
JSR Downwards

org $909038
JSR FullXMovement

;org $90F650
org !free90

FullXMovement:
LDA $7FFA02
BNE +
JSR $8EA9
RTS
+
JSR $8E64
RTS

CalculateBlockIndex: ;Modified/Stripped-down version of $94:9543
LDA $7E0AFA
SEC
SBC #$0008
LSR A
LSR A
LSR A
LSR A
SEP #$20
STA $4202	;SNES Math- Multiplicand
LDA $7E07A5
STA $4203	;SNES Math- Multiplier
REP #$20
LDA $7E0AF6
SEC
SBC #$0008
LSR A
LSR A
LSR A
LSR A
CLC
ADC $4216	;SNES Math- Product of $4202 and $4203
ASL A
TAX
RTS

SetCarryIfSolid: ;Slopes don't feel good at the moment, so they don't count as solid.
PHX
LDA $7F0002,x
AND #$F000
XBA
LSR A
LSR A
LSR A
TAX
LDA $9494D5,x
PLX
CMP #$8F49
BEQ IsSolid
CMP #$9447
BEQ IsSolid
CMP #$9411
BEQ IsSolid
CMP #$932D
BEQ IsSolid
CLC
RTS
IsSolid:
SEC
RTS
print "collision: ", pc
Collision:	;Which corners of Samus' hitbox are touching a solid block. 
		;1 = top left, 2 = top right, 4 = bottom right, 8 = bottom left.
		;Treats corners outside the room as touching solid blocks.
		;Based on collisions, redirects to different movement routines.
LDA #$0000
STA $7FFA02
JSR CalculateBlockIndex
JSR SetCarryIfSolid
BCC +
LDA $7FFA02
ORA #$0001
STA $7FFA02
+
INX
INX
JSR SetCarryIfSolid
BCC +
LDA $7FFA02
ORA #$0002
STA $7FFA02
+
TXA
CLC
ADC $7E07A5
ADC $7E07A5
TAX
JSR SetCarryIfSolid
BCC +
LDA $7FFA02
ORA #$0004
STA $7FFA02
+
DEX
DEX
JSR SetCarryIfSolid
BCC +
LDA $7FFA02
ORA #$0008
STA $7FFA02
+
RTS
print "spidercheck: ", pc
SpiderCheckAndCollision:
LDA #$0000	;initialize to #$0000
STA $7FFA02
LDA $09A2
BIT #$0800
BEQ +
LDA $008B	;Controller input
BIT #$0010	;R Button
BEQ +
LDA $0A1F	;Movement type (one byte)
AND #$00FF
CMP #$0004	;Morph ball on ground
BEQ ++
CMP #$0008	;Morph ball in air
BEQ ++
CMP #$0011	;Spring ball on ground
BEQ ++
CMP #$0012	;Spring ball jumping
BEQ ++
CMP #$0013	;Spring ball falling
BEQ ++
BRA +
++
JSR Collision
+
LDA $196E	;Hijacked instruction
RTS

LoadMovementArrayIndex:
LDA $7FFA02
ASL A
TAX
RTS

Rightwards:
JSR LoadMovementArrayIndex
JMP (Right_Array, x)

Leftwards:
JSR LoadMovementArrayIndex
JMP (Left_Array, x)

Upwards:
LDA $7FFA02
BEQ +
RTS
+
JSR $93EC
RTS

Downwards:
LDA $7FFA02
BEQ +
RTS
+
JSR $9440
RTS

;JSR LoadMovementArrayIndex
;JMP (Down_Array, x)

Right_Array:
DW Right, Flip_Left, Flip_Up, Flip_Left, Right, Right, Flip_Up, Flip_Left, Right, Down, Right, Down, Right, Right, Flip_Up, Right

Left_Array:
DW Left, Up, Flip_Right, Flip_Right, Left, Left, Flip_Down, Flip_Down, Left, Up, Left, Flip_Right, Left, Up, Left, Left


Reverse:	;Negates $12.14
LDA $12
EOR #$FFFF
STA $12
LDA $14
EOR #$FFFF
INC A
STA $14
BNE $02
INC $12
RTS

Flip_Right:
JSR Reverse
Right:
JSR $93B1
RTS

Flip_Left:
JSR Reverse
Left:
JSR $9350
RTS

Flip_Up:
JSR Reverse
Up:
JSR $93EC
RTS

Flip_Down:
JSR Reverse
Down:
JSR $9440
NoMove:
RTS



!free90 #= pc()