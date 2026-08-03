;Black Falcon's "Acid Mod"
;Gravity suit does not protect from lava damage (but still protects from heat damage)
;Varia suit protects from lava damage
;Gravity suit protects from acid damage

LoROM

org $9081DB : BIT #$0001

org $908222
LDA $09A2	;equipped items
AND #$0020	;gravity suit
CMP #$0020
BEQ +
JSR acidMod
BRA ++
+
RTS
NOP #6
++

org !free90	;90F63A
acidMod:
LDA $09DA	;game time (frames)
BIT #$0007
BNE +
LDA $09C2	;samus health
CMP #$0047
BMI ++
LDA #$002D
JSL $809139
++
+
RTS

!free90 #= pc()