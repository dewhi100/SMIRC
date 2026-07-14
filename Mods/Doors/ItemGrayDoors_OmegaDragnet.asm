;----------Item Gray Doors-----------------
;-----------OmegaDragnet9------------------

;Credits to RealRed and Smiley for the inspiration for this.

;Uses the "Always Closed" condition (PLM Argument $1xxx.) 
;Opens a gray door if an item is matching the index of $001-$1FF. (PLM Argument $xxFF) 
;Item $000 is deliberately setup to allow the original "Always Closed" behavior.

lorom

;!Freespace = $84F240

org $84BE1C
JMP ITEMCHECK

org !free84

ITEMCHECK:
PHX
LDA $1DC7,x     ;PLM variable (event # to set)
PLX
AND #$0FFF
BEQ END         ;This way an item index of 00 will keep the "always closed" function for the door, needed for escape rooms.

CLC
ADC #$0280      ;This moves the low byte of the PLM argument into the Item part of the array.
JSL $808233     ;Uses vanilla event check routine to check if an item is collected.
BCS ACTIVATE

END:
JMP $BDC4       ;Dud sound

ACTIVATE:
JMP $BDB2       ;Activates door

!free84 #= pc()