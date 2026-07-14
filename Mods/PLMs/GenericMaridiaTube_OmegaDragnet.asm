;-------------GENERIC MARIDIA TUBE---------------------
;----------------PLM VERSION---------------------------
;---------------OmegaDragnet9--------------------------
;----------------Version 1.2---------------------------

;I neglected to include the actual hardcoded tile in 1.0.
;Now included at the top of the defines section for ease of access. 

;MAKES THE ANIMATION MORE GENERIC SO IT CAN BE MORE FLEXIBLE
;INSPIRED BY THE TUBES IN SUBVERSION

;Credits to AmoebaOfDoom and TestRunner
;JAM
;Smiley
;(Noxus for recommending skipping inputs for tube breaking.)
;P.JBoy

;This version has a PLM that replaces the Vanilla Maridia Tube.
;PLM argument sets the event.
;This PLM is intended to be more generic and therefore more versatile with different tilesets. 
;You are responsible for mainting tile $140 in the Tileset editor (the top left corner of the tube.)
;Aside from this it's not hardcoded as you only really deal with transparent air tiles after the Maridia Tube glass breaks.

lorom

;------------DEFINES---------------------

!HardcodedTileShotBlock = !ShotBlockBehavior+!TheHardcodedTile+!HorizontalFlip ;Comment out "+!HorizontalFlip" if NOT flipping the tile.
!HorizontalFlip = $0400
!ShotBlockBehavior = $C000

!PLM_Header = $840000+!PLM	
!PLM = $8821               ;Set Boss Bits Per Area, Unused
!84Freespace = $84F930	
!BTS = $0E 	
!FirstBTS = $7F6402	
!ShotBlockTable = $94A012

;------------CREATE BTS BOMB BLOCK FOR MARIDIA TUBE-----------------------------------

;CREATE BTS TILE FOR MARIDIA TUBE PLM:
;This makes it so Bomb Block $0E will activate the Maridia Tube.
;This has to be placed in the same place you would the PLM.

; org !BTS*2+!ShotBlockTable 		;Shotblock Table
; DW !PLM

;-----------PLM HEADER-------------------

org !PLM_Header
print "Generic Maridia Tube PLM: ", pc
DW $D6CC
DW #INSTRUCTION

;----------PLM INSTRUCTIONS--------------

org $8498D1	;Vanilla Location for START label.
;DW $0001,$C540,$0000		
;$C000 is the shotblock. This middle number is hardcoded to always display tile $140, with $400 added to it.

org !84Freespace

INSTRUCTION:
DW $8A24,#LABEL1      
DW $86C1,$BD26       ;Pre-instruction = go to link instruction if shot with a power bomb
DW $0001,#START
DW $86B4           

LABEL1:
DW $8A24,#LABEL2     
DW $86C1,$D4BF       ;Had to add this; otherwise it took 2 Power Bomb detonations to trigger this with the BTS tile. 
DW $86B4         

LABEL2:	             ;Link Instruction
DW $86CA             ;Clear pre-instruction
DW #MaridiaTube1 
DW $D52C             ;Spawn n00b tube crack enemy projectile
DW $0030,#ONE
DW $0001,#TWO
DW $0001,#THREE
DW $8C10
DB $1A               ;Queue sound 1Ah, sound library 2, max queued sounds allowed = 6 (n00b tube shattering)
DW $D543             ;Spawn ten n00b tube shards and six n00b tube released air bubbles
DW $D536             ;Trigger n00b tube earthquake
DW $0060,#FOUR
DW $D525             ;Enable water physics
DW $86BC            
DW $0001,#TWO 
DW $0001,#THREE 
DW $D525             ;Enable water physics
DW $86BC             ;Delete

MaridiaTube1:
PHY
LDY $1C27            ;PLM index (PLM ID)
LDA $1DC7,y          ;PLM variable (event # to set)
AND #$0FFF
JSL $8081FA          ;Set event A
PLY
RTS 

START:
DW $0001,!HardcodedTileShotBlock,$0000

ONE:
DW $0001,!TheHardcodedTile,$0000 		

TWO:
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DB $00,$01
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DB $00,$02
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DW $0000

THREE:
DW $0001,$00FF
DB $00,$03
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DB $00,$04
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DB $00,$05
DW $000C,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF,$00FF
DW $0000

FOUR:
DW $0001,$00FF,$0000 		


;--------------Skip Input for Tube Break---------------------------------

;Comment this out if you want Vanilla behavior
;In Super Metroid, up, down, left, right, a,b,x, or y 
;trigger the glass breaking.
;This bypasses that behavior.

if !WaitForInput == 1
	org $84D4C4 ;Hex Edit by Smiley, recommended by Noxus
	NOP : NOP
else:
	BEQ $0D
endif





























