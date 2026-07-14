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

;Blocks
if !EventBTS_OmegaDragnet == 1
	incsrc "Blocks/EventBTS_OmegaDragnet.asm"
endif

;Doors
if !DoorTransitions_Nodever2 == 1
	incsrc "Doors/Door_Transitions_v1.1.1_Nodever2.asm"
endif
if !GadoraChargeVulnerability_Nodever2 == 1
	incsrc "Doors/GadoraChargeVulnerability.asm"
endif
if !ItemGrayDoors_OmegaDragnet == 1
	incsrc "Doors/ItemGrayDoors_OmegaDragnet.asm"
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

if !TorizoAreaBit_Nodever2 == 1
	incsrc "Enemies/TorizoAreaBit_Nodever2.asm"
endif

;Energy
if !ChargeHeal_Dewhi100 == 1
	incsrc "Energy/ChargeHeal_Dewhi100.asm"
endif
if !DeathForgivenessRevision2_Nodever2
	incsrc "Energy/DeathForgivenessRevision2_Nodever2.asm"
endif
if !ReserveTankBugfixes_Nodever2 == 1
	incsrc "Energy/ReserveTankBugfixes_Nodever2.asm"
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

;HUD
if !FullReserveTankIndicator_Compatability_Nodever2 == 1
	incsrc "HUD/FullReserveTankIndicator_Compatability_Nodever2.asm"
endif

if !HudCounterAnimation_Nodever2 == 1
	incsrc "HUD/HudCounterAnimation_Nodever2.asm"
endif

;Intro
if !SkipIntroFlashbacks_Nodever2 == 1
	incsrc "Intro/SkipIntroFlashbacks_Nodever2.asm"
endif

;Jumps
if !SuitlessSpaceJump_Dewhi100 = 1
	incsrc "Jumps/SuitlessSpaceJump_Dewhi100.asm"
endif

;Missiles
if !SupersNeedMains_Dewhi100 = 1 && !EventStation_Dewhi100 == 1
	incsrc "Missiles/SupersNeedMains_Dewhi100.asm"
endif

;Morph
if !MorphSpeed_OmegaDragnet == 1
	incsrc "Morph/MorphSpeed_OmegaDragnet.asm"
endif

;PLMs
if !GenericMaridiaTube_OmegaDragnet == 1
	incsrc "PLMs/GenericMaridiaTube_OmegaDragnet.asm"
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

;Speed Booster
if !FixSpeedBoosterJumpMomentum_Nodever2 == 1
	incsrc "Speedbooster/FixSpeedBoosterJumpMomentum_Nodever2.asm"	
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
if !RemoveMorphBounce == 1
	org $91F204 : DW $F245 : DW $F245 : dw $F245
	org $91F279 : DW $F2C0 : DW $F2C0 : dw $F2C0
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
