lorom

;TODO: dont fire beam when hitting (DO still reduce charge counter back down to 0)

org $90A4F5
JSR CheckSpazer

org $90A744
JSR CheckSpazer

org !free90
CheckSpazer:
LDA $09A6 : BIT #$0004 ;spazer equipped
BEQ +
LDA $0CD0		;spazer is equipped. load charge timer
RTS
+
LDA #$0000	;no spazer. load zero
RTS

!free90 #= pc()

org $91D75A
;was LDA $0A6E : CMP #$0004
LDA $0A6E : CMP #$0004
;JSL pseudoScrewCheck_long : NOP : NOP

org $91D760 
;was BNE $0A 
BRA $0A

org $91D805
;was DW 9C80,9C80,9C80,9400,9400,9400
DW $9C80, $9C80, $9C80, $9400, $9400, $9400	;vanilla
;DW $9C80, $9400, $9C80, $9400, $9C80, $9400

org $A09A8B	;enemy-samus collision handling
JSR pesudoScrewCheck

org $A0A091
JSR pesudoScrewCheck

org $A0A4A1
JSR pesudoScrewCheck

org $A0A4B2
JSR pesudoScrewCheck

org $A0A4D4
;was JSL $90F084;} Run Samus command - end charge beam
;STZ $0CD0 : INC $0CD0 : NOP
JSR resetPseudoScrew : BRA $07

org !freeA0
pesudoScrewCheck:
LDA $09A6	;equipped beams
BIT #$0004	;spazer
BEQ +
LDA #$0077
CMP $0CD0	;charge beam flare index. #$0078 is full charge
BPL +
LDA #$0004
RTS
+
LDA $0A6E	;contact damage index. 4 is pseudo screw
RTS

resetPseudoScrew:
LDA #$0002
STA $0CD0	;charge counter
STA $0B62	;charge palette index
RTS

pseudoScrewCheck_long:
JSR pesudoScrewCheck
CMP #$0004
RTL

!freeA0 #= pc()