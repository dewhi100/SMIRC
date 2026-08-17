LoROM

;//[HIDE INTRO & ALL 3 SAVES WORK (v.3 HACKMODE)]
org $82EEB4	;//($64 byte routine to $82EF17) 
SaveCheck:
	STZ $0DE2		;//<which screen during loading>
	LDA $09DA		;//<game time, frames>
	BNE ForceHack
ForceStartPoint:
	STZ $079F		;//<region number>
	STZ $078B		;//<save in area>
ForceDifficulty:
	LDA $09EA : STA $7ED808
ForceNewSave:
	LDA $0952 : JSL $818000	;//force the game to save
ForceHack:
	LDA $0952 : JSL $818085
	LDA $7ED808 : STA $09EA	;//3 days straight to lock difficulties last time
ForceMap:
	JSL $80858C		;//[load mirror of current area explored map]
	LDA #$0005 : STA $0998	;//force the map to load
Highlighter:
	LDA $7ED918 : STA $0950	;//
	NOP : NOP : NOP : NOP : NOP : NOP

org $82EEEE
Endit:
	RTS