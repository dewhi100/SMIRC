lorom

org $8FE893
JSR setLocalGravity

org !free8F
setLocalGravity:
LDX $07BB
LDA $8F0010, X
BMI +
STA !localGravity
+
RTS

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