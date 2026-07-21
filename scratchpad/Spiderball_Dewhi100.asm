lorom

!left = $9350
!right = $93B1
!up = $93EC
!down = $9440

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
LDA $7F0002,x	;tile data
AND #$F000
BEQ Air					;Air
CMP #$2000 : BEQ Air	;Air (fool x-ray)
CMP #$4000 : BEQ Air	;Air (Shot)
CMP #$5000 : BEQ Air	;H-Copy
CMP #$7000 : BEQ Air	;Air (Bomb)
CMP #$D000 : BEQ Air	;V-Copy
IsSolid:
LDA #$0008	;morph ball falling
STA $0A1F
LDA $09A2	;equipped items
BIT #$0002	;Springball
BEQ +
LDA #$0013	;spring ball falling
STA $0A1F
+
STZ $0B2C	;samus y subspeed
STZ $0B2E	;samus y speed
SEC
RTS
Air:
CLC
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
;LDA $09A2
;BIT #$0800
;BEQ +
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
;;;;
;todo: push into slopes
; LDA #$8000 : STA $14 : STZ $12
; LDA $7FFA02
; CMP #$0004 : BNE ++
; ;JSR !right
; JSR !down
++

;;;;
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
print pc
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
DW Right, Diagonal_Right_DownFlipLeft, Diagonal_Right_FlipUpFlipLeft, Flip_Left, Diagonal_RightFlipUp, Right, Flip_Up, Flip_Left, Diagonal_RightDown, Down, Right, Down, Right, Right, Flip_Up, Right

Left_Array:
DW Left, Diagonal_Left_UpFlipRight, Diagonal_Left_FlipDownRight, Flip_Right, Diagonal_LeftFlipDown, Left, Flip_Down, Flip_Down, Diagonal_LeftUp, Up, Left, Flip_Right, Left, Up, Left, Left


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

; Diagonal_FlipLeftUp:
; ;JSR $9842	;move left no collision
; JSR Reverse
; JSR !left	;move left no collision
; JSR !up
; RTS

; Diagonal_FlipRightDown:
; JSR Reverse
; JSR !down
; JSR !right
; RTS

;holding left
;move left if right of block edge
;move down if left of block edge
Diagonal_LeftFlipDown:
LDA $0AF6	;samus x pixel position
AND #$000F
CMP #$0009
BEQ +
LDA $0AFA	;Samus Y position
AND #$000F
CMP #$0009
BNE +
LDA $0AFC
CMP #$FFFF
BNE +
JSR !left
+
JSR Flip_Down
RTS

Diagonal_RightFlipUp:
LDA $0AFA	;samus y pixel position
AND #$000F
CMP #$0009
BEQ +
JSR Flip_Up
RTS
+
JSR !right
RTS

Diagonal_LeftUp:
LDA $0AFA	;samus y pixel position
AND #$000F
CMP #$0009
BEQ +
JSR !up
RTS
+
JSR !left
RTS

Diagonal_RightDown:
LDA $0AF6	;samus x pixel position
AND #$000F
CMP #$0007
BEQ +
LDA $0AFA	;Samus Y position
AND #$000F
CMP #$0009
BNE +
LDA $0AFC
CMP #$FFFF
BNE +
JSR !right
+
JSR !down
RTS

Diagonal_Right_DownFlipLeft:
print pc
LDA $0AFA	;samus y position
AND #$000F
CMP #$0007
BNE +
JSR Flip_Left
RTS
+
JSR !down
RTS

Diagonal_Left_FlipDownRight:
JSR Reverse
LDA $0AFA	;samus y position
AND #$000F
CMP #$0007
BEQ +
JSR !down
+
JSR !right

RTS

Diagonal_Right_FlipUpFlipLeft:
JSR Reverse
LDA $0AF6	;samus x pixel position
AND #$000F
CMP #$0009
BEQ +
; LDA $0AFA	;Samus Y position
; AND #$000F
; CMP #$0009
; BNE +
; LDA $0AFC
; CMP #$FFFF
; BNE +
JSR !left
+
JSR !up
RTS

Diagonal_Left_UpFlipRight:
LDA $0AF6	;samus x pixel position
AND #$000F
CMP #$0007
BEQ +
; LDA $0AFA	;Samus Y position
; AND #$000F
; CMP #$0009
; BNE +
; LDA $0AFC
; CMP #$FFFF
; BNE +
JSR Reverse
JSR !right
RTS
+
JSR !up
RTS

!free90 #= pc()

;;;debugging
org $809B4E
JSR debugHUD

org !free80
print pc
debugHUD:
LDA $7FFA02
ASL : TAX
LDA TileTable,x
STA $7EC618
LDA $09C0
RTS

TileTable:
DW $0009, $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007, $0008, $00E0, $00E1, $00E2, $00E3, $00E4, $00E5

!free80 #= pc()