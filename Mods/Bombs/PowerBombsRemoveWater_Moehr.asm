;by moehr (for questions)
;thanks to Smiley for help with the main parts and Benox50 for help with the vanilla bugfix

;patch alters powerbumbs so that when Samus uses one, all the water in a room will drain,
;allowing the player to use power bombs as an alternative to gravity suit for unlocking water-filled areas.
;first used in Temple of the Winds, for the Sun Flare version of power bombs.

;careful for ammo-related softlocks - ensure the player gets powerbomb ammo in underwater areas so they can escape!

LOROM

;freespace writes, can be edited
;!waterDrainPointer = !free83;$83AD70
;!powerBombDrainsWater = !free90;$90F670
!doorFxTransitionFix = !free82;$82F7D0

;hijacked addresses, only change if you already moved this in your ROM
!powerBombHijack = $90C195;$90C039
!doorFxTransitionHijack = $82E659
!animatedTilesObjectsHandler = $878064

;vanilla variables
!powerBombActiveFlag = $0CEE
!roomFx = $196E
!roomHeightHi = $07AC	;$07AB - AC is room height, hi byte is height in scrolls
!fxTargetY = $197A		;pointer for where to stop water level at
!fxVelocityY = $197C	;pointer to speed at which water drains
!fxTimer = $1980		;pointer which holds the delay before starting, value must be nonzero

;constants
;water drain speed can be adjusted to whatever value you prefer, but too slow and players won't wait
!WATER_DRAIN_SPEED = #$0200
!PB_INACTIVE = #$FFFF
!ACID_FX = #$0004
!WATER_FX = #$0006
!WATER_SCROLL_OFFSET = #$00FF

;;;; Power Bomb explosions drain water from room

;set water to change, keep spike tile animations on
ORG !free83;!waterDrainPointer

waterDrain: ;list of raw values to set up a new fx pointer for PBs to swap to in rooms with water
db #$00, #$00, #$B0, #$00, #$F8, #$FF, #$80, #$00, #$01, #$06, #$02, #$18, #$00, #$00, #$03, #$48

!free83 #= pc()

; hijack from end of setting up powerbombs 
ORG !powerBombHijack
powerBombHijack:
JSR powerBombDrainsWater
;dewhi tweaked. now overwrites LDA #$FFFF			; A2 0A 00 original value at 90C039

; new code
Org !free90;!powerBombDrainsWater
powerBombDrainsWater:
;PHA			; store A til after hijack
;LDA $0CEE : CMP #$FFFF : BNE NOWATER
;LDA $196E : CMP #$0006 : BNE NOWATER 

; if water present and not draining, set level to lower via powerbomb
LDA !powerBombActiveFlag : CMP !PB_INACTIVE : BNE exitRoutine

;dewhi tweak: check for acid as well as water
LDA !roomFx : CMP !ACID_FX : BEQ +
; if water present and not draining, set level to lower via powerbomb
CMP !WATER_FX : BNE exitRoutine
+

;dewhi tweak: if target y is positive (from $0 to $7FFF), use the values already there and just start the timer
LDA !fxTargetY : BPL +
;set room fx to new values to adjust room fx height
LDA !roomHeightHi : CLC : ADC !WATER_SCROLL_OFFSET : STA !fxTargetY
LDA !WATER_DRAIN_SPEED : STA !fxVelocityY
+
STZ !fxTimer : INC !fxTimer

; restore A, restore code replaced by hijack, and return
exitRoutine:
;PLA
;STA !powerBombActiveFlag
LDA #$FFFF
RTS

!free90 #= pc()

;;;; QOL: remove annoying floatymode waterphysics being stuck on from door transition in vanilla
; thanks Benox for this!!

; Door transition code hijack
org !doorFxTransitionHijack
JSR doorFxTransitionFix
NOP

;reset momentum to use normal physics if exiting a watery room and entering one that is not full of water
org !free82;!doorFxTransitionFix
doorFxTransitionFix:

;fix the vanilla bug when entering a room without water from a room that has water
STZ $0A9C

;restore code from hijack, and return
JSL !animatedTilesObjectsHandler : RTS

!free82 #= pc()

;dewhi edit 
org $88B367 ;normally start of the  "wait to rise" fx code (does earthquake and ticks down fx timer.)
BRA DecrementFxTimer ;I want to skip that and only do earthquake when lava/acid is rising/falling (tides dont count)
org $88B376
DecrementFxTimer:
