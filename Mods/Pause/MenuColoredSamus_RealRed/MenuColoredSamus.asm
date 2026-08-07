;"Menu Colored Samus"
;Fills in and colors the Samus wireframe on the item screen
;Original IPS by RealRed
;Disassembled by dewhi100

lorom

;In Vanilla, bank 82 freespace begins at $82F70F
;Bank B6 freespace begins at $B6F200
;!free82 = $82F70F
;!freeB6 = $B6F200

;Hijacks.
org $8291BE
JSR MenuColorRoutineHijack3
org $82B5C5
JSR MenuColorRoutineHijack1
org $82B5E3
JSR MenuColorRoutineHijack2

org !free82
;Hijacked Routines
MenuColorRoutineHijack1:

;if !EquipScreen_Tundain == 1
;	JSR Loadtilemap : BRA +		;if using tundains pause menu
;else
	JSR $A27E : BRA +		;if not using tundains pause menu
;endif

MenuColorRoutineHijack2:
JSR $A29D : BRA +
MenuColorRoutineHijack3:
JSR $A615
MenuColorRoutineHijack4:	;used by tundains pause menu
+
;Actual code that does things
;save current X and Y
PHX : PHY	
;Determine palette to use. Gravity has priority, then Varia
LDX #$0004
;09A2 is equipped items. 0020 is the Gravity Suit. 0001 is the Varia Suit
LDA $09A2 : BIT #$0020 : BNE +	
DEX : DEX
BIT #$0001 : BNE +	
DEX : DEX
+
;Store the address of the palette we will use
;note that you can put palette data ANYWHERE in the ROM, but this will need to reflect the bank you choose.
LDA #$B600 : STA $01	;bank B6
LDA.l Palettes,x : STA $00 ;one of the addresses at "Palettes"
;Initialize X and Y to 0
LDY #$0000 : LDX #$0000
;transfer palette data to RAM
-
LDA [$00],y : STA $7EC020,x	
INY : INY : INX : INX
CPX #$0020 : BCC -
PLY : PLX : RTS

Palettes:
DW PaletteData, PaletteData+$20, PaletteData+$40
!free82 #= pc()

org !freeB6
PaletteData:
incbin "palettes.bin"
!freeB6 #= pc()
