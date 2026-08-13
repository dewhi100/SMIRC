; ; !BombLauncher_Ob = 1
	; ; !HUD_Index = 1 ; 0..4
	; ; !bombLauncherAmmoRequirement = 1	;if using universal ammo, you can use it for bomb launcher too.
; ; !ChargeMissiles_Tundain = 0
; ; !UniversalAmmo_Tundain = 0
; ; !SupersNeedMains_Dewhi100 = 0
; ; !BrokenChargeBeam_PHOSPHOTiDYL = 0
; ; !EventStation_Dewhi100 = 0
; ; incsrc "Bombs/BombLauncher_Ob.asm"
; ; ; incsrc "Missiles/UniversalAmmo_Tundain.asm"

; ; incsrc "Pause/MenuColoredSamus_RealRed/MenuColoredSamus.asm"

; incsrc "Offline/SkipIntro_PhosphotiDYL.asm"

; !EquipScreenDisassembly_Tundain = 0
; !MapOverhaul_Mfreak = 0
	; !TotalItems = 100					;how many items in hack
	; !BlankTile = #$295D					;-addresses for tiles in the Pause GFX ("Map Screen Graphics" in SMART)
	; !NumbersStart = #$3966				; |
	; !PercentSign = #$3964				; |
	; !DecimalPoint = #$3960				; |
	; !Colon = #$3963						;/
; incsrc "Offline/equip-screen-itemstime.asm"