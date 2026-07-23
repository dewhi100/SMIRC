lorom

;incsrc SparkBounceCustomizeOptions.asm

;Customizable variables.
;End of customizable variables.

;Other noteworthy information:
;This patch overwrites Samus's poses 20 and 21, which were previously unused. It will be incompatible with another patch that uses those poses.


;Use the correct graphics for Samus in Spark Bounce poses
;Shortcut for indexes that land in free space in the ROM.
!TilemapIndexBase = TilemapIndices-$92808D/2

if !SamusMasterDisassembly_Crashtour99 == 0
org $9292A3 ;Tile arrangements top
	DW !TilemapIndexBase, !TilemapIndexBase+4
org $92949D ;Tile arrangements bottom
	DW !TilemapIndexBase+2, !TilemapIndexBase+6
org $92D98E ;Loaded graphics
	DW Pose20GraphicIndexes, Pose21GraphicIndexes
endif

;We need to start this next bit at an odd address "because of indexing shenanigans" (see SparkBounceCustomizeOptions.asm), so this code adds 1 to the PC if it's even.
!free92 #= !free92-(!free92%2)+1
org !free92	;!Bank92FreeSpace
TilemapIndices:
	DW $9A7B, $9B43 ;Top tilemaps for sparkbounce pose 20 (frame 0 and 1)
	DW $B144, $AFB2 ;Bottom tilemaps for sparkbounce pose 20 (frame 0 and 1)
	DW $9A87, $9B59 ;Top tilemaps for sparkbounce pose 21 (frame 0 and 1)
	DW $B169, $AFBE ;Bottom tilemaps for sparkbounce pose 21 (frame 0 and 1)
Pose20GraphicIndexes:
	DB $01, $12, $01, $13
	DB $01, $1C, $00, $1E
Pose21GraphicIndexes:
	DB $01, $13, $01, $14
	DB $01, $1D, $00, $1F

!free92 #= pc()


if !SamusMasterDisassembly_Crashtour99 == 0
org $91B729 ;General Pose data for 20 and 21.
	DB $08,$1B,$CB,$FF,$04,$00,$13,$00
	DB $04,$1B,$CC,$FF,$04,$00,$13,$00
endif

;Reuse existing animation frame counters for spark bounce poses.
if !SamusMasterDisassembly_Crashtour99 == 0
org $91B050
	DW $B32A, $B32A
endif

org $90D1D6
	JSR HookSuperjumpCollision

;Hackish thing to skip damage when a superjump ends. Shared with Electromorph, both this and the electromorph write the same byte to this location.
org $90D344
	PLA

org !free90
HookSuperjumpCollision:
	LDA $0DD0
	BEQ End_SparkBounce
	
	if !SparkbounceEquipmentSlot != $0000
	print "spark bounce item flag: ", !SparkbounceEquipmentSlot
;	!EquipmentCheck()
	LDA $09A2 : BIT.w #!SparkbounceEquipmentSlot : BEQ End_SparkBounce
	endif

	LDA $8B
	BIT $09B4
	BEQ End_SparkBounce
	LDA #$000C
	JSL $80912F
	LDA #$0010
	JSL $80914D
	LDA.w #HandleCollisionMoveType
	STA $0A58
	LDA #$E913
	STA $0A60
	STZ $0DD0
	STZ $0A32
	LDA #$0001
	STA $0ACC
	LDA #$0020
	STA $0A68
	PLA
	PLA
	LDA $0A1E
	BIT #$0004
	BNE Left_SparkBounce
	LDA #$0021
	STA $0A2C
	BRA End_SparkBounce
Left_SparkBounce:
	LDA #$0020
	STA $0A2C
End_SparkBounce:
	LDA $0AF6
	RTS

HandleCollisionMoveType:
	JSR $EEE7
	LDA $09C2
	CMP #$001E
	BMI Fall
	LDA $0A68
	DEC
	BEQ Fall
	if !RemoveShinesparkHealthDrain_Exister == 0
		DEC $09C2	;health drain while gripping wall.
	endif
	RTS
Fall:
	LDA #$0006
	STA $0ACC
	STA $0A68
	LDA #$E90E
	STA $0A60
	JSR $D2C9

!free90 #= pc()

;Override some movement type code to ignore sparkbounce.
org $91FAD6
	BMI $22
	ASL A
	TAX
	if !Downsparking_Tundain != 0
		JSL CheckDown
	else
		LDA $FAFC, X
		NOP
	endif
	STA $0A58
	LDA #$E90E
	STA $0A60

;Fix echoes that fire off when Samus is attached to a wall (used ALL times Samus ends a super jump)
org $90D40D
	LDA $0A1C
	SEC
	SBC #$00C9
	BMI ++
	ASL A
	TAX
	LDA $D4C6, X
	BRA +
++
	LSR
	LDA #$2060 ;Diagonal right angles
	BCS +
	LDA #$A0E0 ;Diagonal left angles
+
	STA $14
	STZ $0AAE
	LDA $0CCE
	SEC
	SBC #$0005
	BPL + ;No projectile slots available, don't create echoes.
	INC
	BEQ ++ ;One projectile slot available, skip first echo.
	INC $0CCE
	LDA #$0040
	STA $0AC4
	LDA $0AF6
	STA $0AB4
	LDA $0AFA
	STA $0ABC
	LDA #$8029
	STA $0C1E
	LDX #$0006
	JSL $938163
	LDA #$D4D2
	STA $0C6E
	LDA $14
	AND #$00FF
	STA $0C82
	STZ $0BE2
++
	INC $0CCE
	LDA #$0040
	STA $0AC6
	LDA $0AF6
	STA $0AB6
	LDA $0AFA
	STA $0ABE
	LDA #$8029
	STA $0C20
	LDX #$0008
	JSL $938163
	LDA #$D4D2
	STA $0C70
	LDA $15
	AND #$00FF
	STA $0C84
	STZ $0BE4
+
	STZ $0CCC
	LDX #$0001
	STX $0A68
	LDA $0A1E
	AND #$00FF
	CMP #$0004
	BNE +
	INX
+
	STX $0A2C
	LDA #$0002
	STA $0A32
	STZ $0DEC
	STZ $0DEE
	RTS
;print pc	;90D4C2 - 4 bytes to spare

org !free83	;can be any bank

CheckDown:
	LDA $09AC : ORA $09BC : BIT $8B : BEQ +	;checks for down OR aim down
	LDA #$0002 : STA $0B36
	+
	LDA $91FAFC, X	;hijacked instruction
	RTL

!free83 #= pc()