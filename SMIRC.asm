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

;Energy
if !ChargeHeal_Dewhi100 == 1
	incsrc "Energy/ChargeHeal_Dewhi100.asm"
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

;Jumps
if !SuitlessSpaceJump_Dewhi100 = 1
	incsrc "Jumps/SuitlessSpaceJump_Dewhi100.asm"
endif

;Suits
if !PseudoVaria_Dewhi100 == 1
	incsrc "Suits/pseudoVaria_Dewhi100.asm"
endif

;;;;;;;;;;;;;;;
}		;end of master toggle for file
endif
