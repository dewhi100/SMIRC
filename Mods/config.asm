lorom

;Beams
!BeamBasedPseudoScrewDamage_Dewhi100 = 1
	!DoubleDamage = 0
!PseudoScrewRequiresSpazer_Dewhi100 = 1
!RedBeamsLowHP_Dewhi100 = 1

;Energy
!ChargeHeal_Dewhi100 = 1
	!HealsCutoff = 0				;0 = no limit, 1 = heal if critical alarm is on, 2 = can't heal above critical cutoff (almost same as 1, but cutoff is 1 less)

;Events
!EventStation_Dewhi100 = 1
!EventDoors_Dewhi100 = 1
!ItemEventPLM_Dewhi100 = 1
!RoomClearEventPLM_Dewhi100 = 1

;Jumps
!SuitlessSpaceJump_Dewhi100 = 1

;Suits
!PseudoVaria_Dewhi100 = 0
	!HeatProofGravitySuit = 0	;Set to 1 if you want Gravity Suit to protect from heat
	!HalfDamageInLava = 1		;Set if you want charged Ice Beam to reduce lava damage
