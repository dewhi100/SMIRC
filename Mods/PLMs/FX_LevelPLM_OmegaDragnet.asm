;-----------FX Level Changing PLM----------------
;----------------OmegaDragnet9-------------------

;Credits to starlightintheriver for explaining mechanics of how to implement this
;Credits to RT-55J, who has a PLM that shares similar functionality to this one and predates it by a year. (Both are based off of Scroll PLM architecture.)
;Credits to RealRed, suku, and Metaquarius (whose works inspired this. Not sure what exact mechanic was implemented in those hacks.) 
;Thanks to P.JBoy for the Banklogs

;Use this to change the level of lava or water instantly.
;(Best done offscreen in most cases.)
;PLM Argument determines the new height of the liquid.
;Another good use of this is to make some fake lava like in Zero Mission.

lorom

;-----------------DEFINES-----------------------

!84Freespace1 = $84875A     ;Writes over unused vanilla code for the header.
;!84Freespace2 = $84F910

;----------------HEADER-------------------------

org !84Freespace1           ;Header placed here so that PLM doesn't show up under X Ray when a major item is collected.

DW $B371                    ;Setup for Scroll PLM 
DW #InstructionList 

;---------------PLM CODE------------------------

org !free84

InstructionList:

.Loop
DW $86B4
DW .TheMagicHappen 			
DW $8724,.Loop


.TheMagicHappen	
PHX
PHY
LDY $1C27		;PLM index
LDA $1DC7,y		;PLM variable 
STA $1962		;Water Level
STA $1978		;Lava Level
STZ $1E17,x		;This was necessary to allow for the PLM to reset and be allowed to be used again.
PLY
PLX
RTS

!free84 #= pc()