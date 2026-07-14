;----------Event BTS----------------
;---------Version 1.1---------------
;--------OmegaDragnet9--------------

;Credits to DSO (for using BTS in the room to store to a RAM address.)
;MetroidNerd#9001 for the Earthquake Script
;Smiley for the Formula from the Endgame BTS
;squishy_ichigo for the template provided by the Endgame BTS
;P.JBoy for the Banklogs
;Amoeba and neen for using BTS tiles similarly and giving me inspiration to go this direction.
;Benox50, for suggesting a BTS solution (and the excellent Event PLM.) 

;To use, simply place 2 BTS tiles at the top leftmost of the room.
;No need to worry about Endianness as the XBA takes care of that
;Highest byte at $7xxx sets earthquake. Other values do not.
;Bytes $xFFF control which events to check against and set.

;Setup to work in Vanilla Air Fool X Ray table OR the repointed one from my project.

lorom

;----------DEFINES------------------

;!event_bts = $0A 		  		;max $0F
;!free94 = $94DE40
;!freeRAM = $7EF4A0

;---------FOOL XRAY TILE------------

org !Event_bts*2+$9498AC		;Vanilla Air Fool X Ray Location
EventBTS:
; org !bts*2+$94B280 		;Repointed Air Fool X Ray Location
DW .Event

;--------EVENT SCRIPT---------------

org !free94
.Event

LDA $7F6402				;Gets first BTS Block from Room
XBA						;Flips the high and low bytes
STA !OmegaDragnetRAM

;BTS Check
LDA !OmegaDragnetRAM
AND #$0FFF				;Masking the 3 low bytes, reversed due to the endian nature 
JSL $808233				;Check if event already set
BCS +					;Already set then go to end

;Set Event
LDA !OmegaDragnetRAM
AND #$0FFF
JSL $8081FA

;Earthquake Check
LDA !OmegaDragnetRAM
AND #$F000
CMP #$7000
BNE +		

;MetroidNerd#9001 Earthquake
LDA #$0006
STA $183E
LDA #$0032 
STA $1840
LDA #$0046
JSL $8090CB

+
RTS

!free94 #= pc()