; ;Items: MOAR Items							;There are just so many that I separated them into their own thing
; !WaveDash_Mccad = 1						;\While spinjumping, hold [run] and double tap left or right. (Mccad's MOAR Items)
	; !WaveDashSingleTap = 1				;|single tapping to activate (normally a double tap)
	; !WaveDashSetMinimumSpeed = 1 		;|sets speed to a minimum of the below value when activated
		; !WaveDashSpeed = $0004			;|
	; !WaveDashCancelSpinjump = 0 		;|cancel spinjump after dashing. bugged and funny.
	; !WaveDashChargeCombo = 1			;|WaveDash requires charged wave beam rather than an item.
	; !WaveDashThroughWalls = 1			;|Samus' collision is disabled when dashing through gates, shutters, and walls of 1 tile thickness
	; !WaveDashOncePerJump = 0			;|Samus must touch the ground in between wave dashes. Based on Spin Boost's code (by Oi27)	;bugged
	; !OverrideAura = 0					;|Suit Aura makes wavedash look ugly, so turn off aura during dash
; !HammerBall_Mccad = 0					;|while in the air in morph, hold down and press [aim down]
	; !HammerBallTriggerWithJump = 1		;|Hammerball effect triggered by the jump button
	; !HammerBallRequireSpringBall = 1	;|Bundles hammerball with springball
; !GaussMissiles_Mccad = 0				;|(Much) Faster missiles, also hit harder
	; !GaussMissilesNoPLM = 0				;/Set to 1 if for some reason you plan to enable gauss missile in a non-item way

; !BeamPatch_Mfreak = 0			;NOT IMPLEMENTED. HERE FOR FUTUREPROOFING

; !EnemyProjectileCollision_HAM = 0

; incsrc "Items/MoarItems_Mccad/master_custom.asm"