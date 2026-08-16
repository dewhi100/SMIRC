;Beams
!AccelCharge_Oi27 = 1
!BeamBasedPseudoScrewDamage_Dewhi100 = 1
	!DoubleDamage = 1
!BeamPatch_Mfreak = 0			;NOT IMPLEMENTED. HERE FOR FUTUREPROOFING
!BrokenChargeBeam_PHOSPHOTiDYL = 1
	!brokenChargeBeamTimer = 60				;$3C or 60d is normal. $78 or 120 is SBA and default for the patch.
!ChargeFlareFix_HAM = 1
!FullHealthChargeShot_InsaneFirebat = 1
!PseudoScrewRequiresSpazer_Dewhi100 = 0
!RedBeamsLowHP_Dewhi100 = 1
!SmoothGrappleBetterLatching_Tundain = 1
;!SpinningChargeFlare_Tundain = 0	;possibly bugged. tundain is notified.

;Blocks
!ChainBlocks_BlackFalcon = 1	;D horizontal E veritcal F = cross. uses shotblcoks and bomb blocks. crumbles would be nice
!CrumbleDelay_BlackFalcon = 1		;uses !BlockGfx in stddefines.
	!crumble_delay = $0028         ;this is the frame delay for how long Samus can step on it until it breaks 
!DropThruPlatforms_Oi27 = 1
!EventBTS_OmegaDragnet = 1
!MissileBlock_Oi27 = 1
!ScrewAttackBlock_Crashtour99 = 1

;Bombs
!ThreeByThreeBombs_Benox50_Nodever2 = 1	;this is out of alphabetical order because "three" == "3" IDK
!BombLauncher_Ob = 1	;set the item bit you want for this in stddefines.txt. Does not handle drawing icon the HUD.
	!HUD_Index = 1 ; 0..4
	!bombLauncherAmmoRequirement = 1	;if using universal ammo, you can use it for bomb launcher too.
!PowerBombsRemoveWater_Moehr = 1

;Bosses
!FixKraidVomit_PJBoy = 1

;Doors
!DoorTransitions_Nodever2 = 1	;see file for full list of custom options. There are too many to list here.
    !AddOptionToFadeLayer1      = 0  ; If enabled, set the 20h bit in door elevator properties to fade layer 1 per-door (this works just like the CRE bitflag that bosses use in vanilla). (In SMART: Raw > bitflag)
    !ReportFreespaceAndRamUsage = 0  ; Set to 0 to stop this patch from printing it's freespace and RAM usage to the console when assembled.
!EventDoors_Dewhi100 = 0
!EventGrayDoors_OmegaDragnet = 1	;see patch for details
	!btsEventDoor = 1
	!plmEventDoor = 1
	!bossEventBTS = 1
!GadoraChargeVulnerability_Nodever2 = 1
!ItemGrayDoors_OmegaDragnet = 1

;Drops
!HomingDrops_Nodever2 = 1

;Effects
!ScrollingSkyFix_Amoeba = 1
!SuitAura_Oi27 = 1		;you can set the item that grants aura in the stddefines.txt file. setting to $0000 will remove the item check
	!AuraRadius = 1     ;(d. pixels) CANNOT BE < 1 OR BREAKS BUILD
	!AuraITM = $0000		;item to activate the aura. unused in my custom version	
	!gravityEffect = 2		;0 = always on. 1 = aura triggers when Gravity suit is equipped in liquids, 2 = aura trigegrs if gravity is equipped at all.
	!chargeAura = 1			;adds an aura with beam color when fully charged. overrides gravity
	!criticalAura = 1		;aura triggers if samus is at or below critical HP (beam palette). overrides gravity aura (white). Intended to pair with "RedBeamsLowHP"
!WaterDroplets_Oi27 = 1		;NOTE: you wont see the graphics ingame right away when quickmetting. You need to go through a door transition in order to properly load the GFX

;Ending
!NonExplosivePlanet_Tundain = 1
	!AreaDoesExplode = 1			;If set to 1, part of the surface will still explode. You must supply the art yourself.
!SkipZebesMode7_OmegaDragnet = 1

;Enemies
!BombTorizoItemOverride_PjBoy = 1
!Donkkon_Ob = 1
!EnemyAlwaysFreezesVulnerability_Tundain = 1
!EnemiesStayDead_Nodever2 = 1
    !NumRooms             = $0005 ; The last !NumRooms rooms where an enemy was killed will be remembered.
!FlippedBombTorizo_Tundain = 0
!ImprovedMetroidLatching_Tundain = 1
!MissileGrabbingGoldenTorizo_Tundain = 1
!OneRoomElevator_Dewhi100 = 1
!SlopeCompatibleSpacePirates_Tundain = 1
!TorizoAreaBit_Nodever2 = 1
!VariableKnockback_Tundain = 1

;Energy
!ChargeHeal_Dewhi100 = 0
	!HealsCutoff = 2				;0 = no limit, 1 = heal if critical alarm is on, 2 = can't heal above critical cutoff (almost same as 1, but cutoff is 1 less)
!DeathForgivenessRevision2_Nodever2 = 1
    !HealthThreshold = #$001E ; If Samus has at least this much health, she will survive an instant kill with !HealthRemaining HP. Default: 30 (decimal). This should be greater than !HealthRemaining.
                              ;   In vanilla, the low health alarm plays when Samus has 30 (decimal) or less HP.
    !HealthRemaining = #$0001 ; This is how much health Samus will be left with when she takes damage that is otherwise fatal.
    !ForgivePeriodicDamage       = 1 ; Set to 0 to disable death forgiveness from periodic damage including heat & spikes.
    !ForgiveWhenReservesNotEmpty = 0 ; Set to 0 to disable forgiveness when Samus' reserve health is not zero (REGARDLESS OF IF RESERVE TANKS ARE ON AUTO OR MANUAL MODE)
!MaxHealthHighlight_Nodever2 = 1
!ReserveTankBugfixes_Nodever2 = 1

;Events
!BossEvents_OmegaDragnet = 1
!EventStation_Dewhi100 = 1
!ItemEventPLM_Dewhi100 = 1
!RoomClearEventPLM_Dewhi100 = 0

;HUD
!FullReserveTankIndicator_Compatability_Nodever2 = 1
!HudCounterAnimation_Nodever2 = 1

;Items
!InstantPickups_Oi27 = 1

;Items: MOAR Items							;There are just so many that I separated them into their own thing
!WaveDash_Mccad = 1						;\While spinjumping, hold [run] and double tap left or right. (Mccad's MOAR Items)
	!WaveDashSingleTap = 1				;|single tapping to activate (normally a double tap)
	!WaveDashSetMinimumSpeed = 1 		;|sets speed to a minimum of the below value when activated
		!WaveDashSpeed = $0004			;|
	!WaveDashCancelSpinjump = 0 		;|cancel spinjump after dashing. bugged and funny.
	!WaveDashChargeCombo = 1			;|WaveDash requires charged wave beam rather than an item.
	!WaveDashThroughWalls = 1			;|Samus' collision is disabled when dashing through gates, shutters, and walls of 1 tile thickness
	!WaveDashOncePerJump = 0			;|Samus must touch the ground in between wave dashes. Based on Spin Boost's code (by Oi27)	;bugged
	!OverrideAura = 0					;|Suit Aura makes wavedash look ugly, so turn off aura during dash
!HammerBall_Mccad = 1					;|while in the air in morph, hold down and press [aim down]
	!HammerBallTriggerWithJump = 1		;|Hammerball effect triggered by the jump button
	!HammerBallRequireSpringBall = 1	;|Bundles hammerball with springball
!GaussMissiles_Mccad = 1				;|(Much) Faster missiles, also hit harder
	!GaussMissilesNoPLM = 0				;/Set to 1 if for some reason you plan to enable gauss missile in a non-item way

;Intro
!SkipIntro_Phosphotidyl = 1	;NOT INCLUDED IN SMIRC. SET THIS TO '0'
!SkipIntroFlashbacks_Nodever2 = 1
!SkipHexMap_Mfreak = 1	;NOT INCLUDED IN SMIRC. SET THIS TO '0'

;Jumps
!EasierWallJump_Benox50 = 1
!LimitedSpaceJumps_Oi27 = 0	;not working, but I wouldn't want it to.
	!JumpsAllowed = $0002 		;number of jumps incl the one from the ground
!Respin_Kejardon = 1
!SuitlessSpaceJump_Dewhi100 = 1

;Missiles
!AmmoRegen_Dewhi100 = 1
!BlockRevealingMissile_MarioFanGamer = 1
!ChargeMissiles_Tundain = 1	;Note: add $0100 to the PLM argument to make it a charged Super item rather than charged missile
	!needsMainSupers = 1
	!withPLMs = 0			;if 1, will use PLMs to set the item flags
!IcePlusMissileDamage_Oi27 = 1
!SupersNeedMains_Dewhi100 = 1
	!StarterAmmo = 05
!UniversalAmmo_Tundain = 1	;You must supply the "ammo:" HUD text yourself 
	!AmmoPLM = 1	;a specialized universal ammo tank.	0XXX = big, 1XXX = small, X0XX ... X2XX are normal/orb/hidden
	;these values are how much ammo it will consume when fired
	!supermissileweight = #$0004	;this will be 5 if using charge missiles.
	!PowerbombWeight = #$000A


;Morph
!MorphSpeed_OmegaDragnet = 1
!SafeUnmorph_Tundain = 1

;Optimizations
!CameraRework_Tundain = 1
	!disableManualCamera = 1	;if set to 1, no manual camera control (I have seen people trigger it by mistake while playing and get confused)
!Decompression_Kejardon_Tundain = 1	;So much work went into this by both that it makes sense to include them.
!FasterElevators_ProjectBase = 1

;Pause Screen
!EquipScreenDisassembly_Tundain = 1
!MapOverhaul_Mfreak = 1					;NOT INCLUDED IN SMIRC. SET THIS TO 0!
!MenuColoredSamus_RealRed = 1			;NOT INCLUDED IN SMIRC. SET THIS TO 0!
!PercentTime_FelicityVi = 1				;NOT INCLUDED IN SMIRC. SET THIS TO 0!
	!TotalItems = 100					;how many items in hack
	!BlankTile = #$295D					;-addresses for tiles in the Pause GFX ("Map Screen Graphics" in SMART)
	!NumbersStart = #$3966				; |
	!PercentSign = #$3964				; |
	!DecimalPoint = #$3960				; |
	!Colon = #$3963						;/

;Physics
!LocalGravity_Dewhi100 = 1
	!resetGravityMode = 1	;0: use RoomVar, 1:  use RoomVar (positive values only), 2: Zeroed on entering rooms.
!PlanetaryGravityRework_Dewhi100 = 1	;See patch for customization options

;PLMs
!FX_LevelPLM_OmegaDragnet = 1
!GenericMaridiaTube_OmegaDragnet = 1
	!TheHardcodedTile = $0140 ;Change this to if you want to use another tile.
	!WaitForInput = 0
!SingleUseGates_Nodever2 = 1

;Room States
!BossCountRoomState_Dewhi100 = 1
!RandomRoomState_Dewhi100 = 1
!TimeElapsedState_Dewhi100 = 1

;Samus GFX
!DualSuitGfx_Crashtour99 = 1	;gfx dont apply properly when using SMART for some reason. asking in the SMART discord
	!DualGfxPath = "VanillaSamusGFX.gfx"	;path to the alternate GFX
	!VariaOnly = 0
!MorphRoll_BlackFalcon = 1
!NoShouldersGravitySuit_Dewhi100 = 1
!SamusElbowFix_Kejardon = 0	;not needed if you use crashtour disassembly. I think. also possibly collides with custom gfx
!SamusMasterDisassembly_Crashtour99 = 1
!SamusResprite = 1		;Rewrite Samus' graphics with gfs at this path
	!SamusRespritePath = "Offline/SamusGfxRedesign_Physix.gfx"
!ZeroSuitDeath_ProjectXVIII = 1	;NOT INCLUDED IN SMIRC. SET THIS TO 0!

;Speed Booster
!ChainSpark_Various = 1
!Downsparking_Tundain = 1
!FixSpeedBoosterJumpMomentum_Nodever2 = 1
!RemoveShinesparkHealthDrain_Exister = 1
!ShinesparkCompatibleReflecs_Tundain = 1
!SparkBounce_Kejardon = 1
	!disableVertical = 1	;I think vertical sparks from walljump pose feel jarring, so here's an option to disable them.
!SpeedKeep_Various = 1		;This is the "modern" speedkeep, that requires you to press run as you land.

;Suits
!AcidMod_BlackFalcon = 0
!M2anim_Oi27 = 1				;This breaks the hidden block variety of Varia, but you weren't planning on using that... were you?
	!M2Anim_GFX_Path = "../../Offline/M2Varia_SamusGfxRedesign_Physix.bin"
!PseudoVaria_Dewhi100 = 1
	!HeatProofGravitySuit = 0	;Set to 1 if you want Gravity Suit to protect from heat
	!HalfDamageInLava = 1		;Set if you want charged Ice Beam to reduce lava damage

;Tweaks
;If set to custom values, will trigger ASM. Any ASM that conflicts with these will shut them down
!AcidSubDamage = $4000		;$8000
!AcidDamage = $0000			;$0000
!MissilesPerDoorCap = 1		;5
!MissilePickupsRefill = 1	;By Exister
!RemoveMorphBounce = 0		;By Omegadragnet
!SkipDemo = 1				;1 to skip, 0 to keep
!TerminalVelocity = 8		;vanilla = 5
!GrappleDelta = $000E		;Vanilla = $000C
!GrappleMaxLength = $00A0 	;Vanilla = $0080
!SpeedBoostRequirement = $0300	;vanilla $0400
