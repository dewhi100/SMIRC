lorom

;Beam-based pseudo-screw attack damage, by dewhi100
;Inspired by the Savage Wizzrobe patch"Variable Pseudo Screw Attack Damage"
;Usable with splasma, as long as you know where to look for the relocated beam data pointer array.

;!ChargedBeamsListPointer = ChargedBeamsListPointer	;Label used in the splasma included as part of MFreak's beam overhaul patch.
!ChargedBeamsListPointer = $9383D9	;vanilla
!freeA0 = $A0F7D3			;change as needed. default:  $A0F7D3 (beginning of vanilla freespace in bank A0

org $A0A4CC
JSR Freespace

org !freeA0
Freespace:
PHX
LDA $09A6			;equipped beams
AND #$000F		;mask the charge beam bit
ASL						;double it because pointers are two byes in size
TAX						;index = equipped beams (not counting charge)
LDA !ChargedBeamsListPointer, x	;wherever the pointer array for charged shot data begins, plus X
TAX 						;index = pointer to data for that beam combo (starting with damage)
LDA $930000,x	;load beam damage
ASL						;multiply by 2 because you're feeling spicy
PLX
RTS
!freeA0 #= pc()	;stores the program counter to the freeA0 variable. Useful if you have more patches in this bank's freespace. Harmless if not.
print "End of Beam Based Pseudo Screw Damage: ", pc				;prints the program counter. If you are tracking freespace manually, this will help