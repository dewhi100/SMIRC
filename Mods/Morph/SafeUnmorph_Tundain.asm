lorom

;Safe Unmorph, by Tundain

;!SlopeFlag = $39;flag to indicate we collided with slope this frame


;triggered when trying to unmorph
org $91FE7D
JSR CheckEdgeCase

org !unused91 ;unused vanilla code


CheckEdgeCase:
LDA $0B00 : CMP #$0008 : BPL +;only if we're morphed
LDA $09B4 : ORA $09AA : BIT $8F : BEQ +;if pressed space or up
TXA : CMP #$0004 : BNE +; if X was 4, means only collision from below (is the case with unmorph)
LDA !SlopeFlagRAM : BIT #$0001 : BNE ++;if is $01, means slope above was touched
BIT #$0002 : BEQ +;if $02, slope is below samus
LDA #$FFF0 : STA $12 : STZ $14
PHX : JSL $9496AB : PLX : BCS ++;check if solid collision one tile extra higher
BRA +
++
LDX #$0006
+
STZ !SlopeFlagRAM;clear the flag for the next frame
JMP ($FE92,x)

warnpc !unused91End
!unused91 #= pc()

org $9486FE
JSR SetSlopeFlag;set a flag for slope collision, since vanilla collision routine only returns whether solid collision has happened

org !free94
SetSlopeFlag:
LDA $12 : BPL +
LDA !SlopeFlagRAM
ORA #$0001 : BRA ++;slope is above samus
+
LDA !SlopeFlagRAM
ORA #$0002 : BRA ++;slope is below samus
++
STA !SlopeFlagRAM
LDA $0B02 : RTS

!free94 #= pc()

