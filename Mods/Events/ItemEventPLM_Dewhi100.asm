lorom
;---------------------------------------------------------
;PLM to set event if item/beam is collected
;
;Uses the PLM instruction to look for a certain item/beam flag
;If Samus has collected the item/beam, sets an event
;The event is also based on the PLM instruction
;Instruction High byte = which beam/item; Low Byte = Event
;High byte 0 ... F = items, 10 ... 1F = beams
;---------------------------------------------------------

org !free84
print "Item Event PLM: ", pc
DW setup, $DB42	;$DB42 is sleep

setup:
LDA #preInstruction
STA $1CD7,y
RTS

preInstruction:
PHB
LDA #$0080		;\
PHA				;|Set Bank to 84
PLB				;|This is so ItemFlags array can be read.
PLB				;/
PHY	
LDY $1C27		;PLM index
LDA $1DC7,y		;PLM variable (event # to set)
XBA
AND #$001F		;A = which item flag to set
ASL				;A = index of ItemFlags
BIT #$0020		;check for beams bitflag
BEQ +
AND #$001F		;Remove beams bitflag
TAX
LDA ItemFlags, x
AND $09A8		;Samus' collected beams
BRA ++
+
TAX
LDA ItemFlags, x
AND $09A4		;Samus' collected items
++
BEQ +
LDA $1DC7,y		;PLM variable (event # to set)
AND #$00FF		;A = which event to set
JSL $8081FA		;Set event A
+
PLY
PLB
RTS

ItemFlags:
DW $0001, $0002, $0004, $0008	;varia/wavebeam, springball/icebeam, morphball/spazerbeam, screw attack/plasmabeam
DW $0010, $0020, $0040, $0080	;---, gravity, ---, ---
DW $0100, $0200, $0400, $0800	;hijump, spacejump, ---, ---
DW $1000, $2000, $4000, $8000	;charge/bombs, speedbooster, grapple, xray

!free84 #= pc()