lorom

;Beams
!BeamBasedPseudoScrewDamage_Dewhi100 = 1
	!DoubleDamage = 1
!PseudoScrewRequiresSpazer_Dewhi100 = 1
!RedBeamsLowHP_Dewhi100 = 1

;Doors
!DoorTransitions_Nodever2 = 1	;see file for full list of custom options. There are too many to list here.
    !AddOptionToFadeLayer1      = 1  ; If enabled, set the 20h bit in door elevator properties to fade layer 1 per-door (this works just like the CRE bitflag that bosses use in vanilla). (In SMART: Raw > bitflag)
    !ReportFreespaceAndRamUsage = 0  ; Set to 0 to stop this patch from printing it's freespace and RAM usage to the console when assembled.
!EventDoors_Dewhi100 = 0
!GadoraChargeVulnerability_Nodever2 = 1

;Drops
!HomingDrops_Nodever2 = 1

;Enemies
!EnemiesStayDead_Nodever2 = 1	
    !NumRooms             = $0005 ; The last !NumRooms rooms where an enemy was killed will be remembered.
!OneRoomElevator_Dewhi100 = 1
!TorizoAreaBit_Nodever2 = 1

;Energy
!ChargeHeal_Dewhi100 = 1
	!HealsCutoff = 0				;0 = no limit, 1 = heal if critical alarm is on, 2 = can't heal above critical cutoff (almost same as 1, but cutoff is 1 less)
!DeathForgivenessRevision2_Nodever2 = 1
    !HealthThreshold = #$001E ; If Samus has at least this much health, she will survive an instant kill with !HealthRemaining HP. Default: 30 (decimal). This should be greater than !HealthRemaining.
                              ;   In vanilla, the low health alarm plays when Samus has 30 (decimal) or less HP.
    !HealthRemaining = #$0001 ; This is how much health Samus will be left with when she takes damage that is otherwise fatal.
    !ForgivePeriodicDamage       = 1 ; Set to 0 to disable death forgiveness from periodic damage including heat & spikes.
    !ForgiveWhenReservesNotEmpty = 0 ; Set to 0 to disable forgiveness when Samus' reserve health is not zero (REGARDLESS OF IF RESERVE TANKS ARE ON AUTO OR MANUAL MODE)
!ReserveTankBugfixes_Nodever2 = 1

;Events
!EventStation_Dewhi100 = 1
!ItemEventPLM_Dewhi100 = 1
!RoomClearEventPLM_Dewhi100 = 1

;HUD
!FullReserveTankIndicator_Compatability_Nodever2 = 1
!HudCounterAnimation_Nodever2 = 1

;Intro
!SkipIntroFlashbacks_Nodever2 = 1

;Jumps
!SuitlessSpaceJump_Dewhi100 = 1

;Misiles
!SupersNeedMains_Dewhi100 = 1	
	!StarterAmmo = 15

;Room States
!BossCountRoomState_Dewhi100 = 1
!RandomRoomState_Dewhi100 = 1
!TimeElapsedState_Dewhi100 = 1

;Speed Booster
!FixSpeedBoosterJumpMomentum_Nodever2 = 1

;Suits
!PseudoVaria_Dewhi100 = 1
	!HeatProofGravitySuit = 0	;Set to 1 if you want Gravity Suit to protect from heat
	!HalfDamageInLava = 1		;Set if you want charged Ice Beam to reduce lava damage

;Tweaks
;If set to custom values, will trigger ASM. Any ASM that conflicts with these will shut them down
!AcidSubDamage = $4000		;$8000
!AcidDamage = $0000			;$0000
!MissilesPerDoorCap = $05		;5
!RemoveMorphBounce = 1
!SkipDemo = 0				;1 to skip, 0 to keep