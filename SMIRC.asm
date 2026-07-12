;|||   Super Metroid Integrated Resource Collection |||;
lorom

if 1 == 1	;Easily disable assembling while debugging
{
;Configuration;

incsrc "config.asm"

;File Includes;

;Beams
if !BeamBasedPseudoScrewDamage_Dewhi100 == 1
	incsrc "Beams/BeamBasedPseudoScrewDamage_Dewhi100.asm"
endif
if !PseudoScrewRequiresSpazer_Dewhi100 == 1
	incsrc "Beams/PseudoScrewRequiresSpazer_Dewhi100.asm"
endif
if !RedBeamsLowHP_Dewhi100 == 1
	incsrc "Beams/RedBeamsLowHP_Dewhi100.asm"
endif

;Doors
if !GadoraChargeVulnerability_Nodever2 == 1
	incsrc "Doors/GadoraChargeVulnerability.asm"
endif
if !DoorTransitions_Nodever2 == 1
	incsrc "Doors/Door_Transitions_v1.1.1_Nodever2.asm"
endif

;Drops
if !HomingDrops_Nodever2 == 1
	 incsrc "Drops/HomingDrops_Nodever2.asm"
endif

;Enemies
if !EnemiesStayDead_Nodever2 = 1
	incsrc "Enemies/EnemiesStayDead_Nodever2.asm"
endif

if !OneRoomElevator_Dewhi100 = 1
	incsrc "Enemies/OneRoomElevator_Dewhi100.asm"
endif

;Energy
if !ChargeHeal_Dewhi100 == 1
	incsrc "Energy/ChargeHeal_Dewhi100.asm"
endif
if !DeathForgivenessRevision2_Nodever2
	incsrc "Energy/DeathForgivenessRevision2_Nodever2.asm"
endif

;Events
if !EventStation_Dewhi100 == 1
	incsrc "Events/EventStation_Dewhi100.asm"
endif
if !EventDoors_Dewhi100 == 1
	incsrc "Events/EventDoors_Dewhi100.asm"
endif
if !ItemEventPLM_Dewhi100 == 1
	incsrc "Events/ItemEventPLM_Dewhi100.asm"
endif
if !RoomClearEventPLM_Dewhi100 == 1
	incsrc "Events/RoomClearEventPLM_Dewhi100.asm"
endif

;Jumps
if !SuitlessSpaceJump_Dewhi100 = 1
	incsrc "Jumps/SuitlessSpaceJump_Dewhi100.asm"
endif

;Missiles
if !SupersNeedMains_Dewhi100 = 1 && !EventStation_Dewhi100 == 1
	incsrc "Missiles/SupersNeedMains_Dewhi100.asm"
endif

;Room States
if !BossCountRoomState_Dewhi100 == 1
	incsrc "RoomStates/BossCountRoomState_Dewhi100.asm"
endif

if !RandomRoomState_Dewhi100 == 1
	incsrc "RoomStates/RandomRoomState_Dewhi100.asm"
endif

if !TimeElapsedState_Dewhi100 == 1
	incsrc "RoomStates/TimeElapsedState_Dewhi100.asm"
endif

;Suits
if !PseudoVaria_Dewhi100 == 1
	incsrc "Suits/pseudoVaria_Dewhi100.asm"
endif

;Tweaks
if !AcidSubDamage = $8000 || !AcidDamage = $0000
	org $909E8F	;Acid damage
	DW !AcidSubDamage, !AcidDamage
endif
if !MissilesPerDoorCap != 5
	if !EventDoors_Dewhi100 == 0
		org $84C32C
		DB !MissilesPerDoorCap
		org $84C38E
		DB !MissilesPerDoorCap
		org $84C3F0
		DB !MissilesPerDoorCap
		org $84C452
		DB !MissilesPerDoorCap
	else
		print "Cannot customize missiles per door (Blocked by Event Doors ASM)"
	endif
endif
if !SkipDemo == 1
	org $8B9F2C
	BRA +
	org $8B9F38
	+
endif

;;;;;;;;;;;;;;;
}		;end of master toggle for file
endif
