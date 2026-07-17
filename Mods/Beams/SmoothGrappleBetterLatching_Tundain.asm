lorom


;Smooth grapple swings & better grapple latching, by Tundain
;makes it so initiating a swing preserves samus momentum
;and releasing from a swing while holding left/right will properly preserve the momentum gained from being propelled

;also makes it so latching on doesn't automatically retract the beam to it's minimum length

;grapple is also better at targeting grapple tiles when being fired
;this gives some room for error if your hack has single grapple blocks in walls for example

;!Bank90Freespace = $90F640
;!Bank9BFreespace = $9BFDA0
;!Bank94Freespace = $94B400

;when connecting to grapple, at which scale should samus's speed be converted to angular speed
;default is 3, which is what I consider to most accurately convert samus's current speed to swing speed

; smaller than 3 will speedup samus when initiating a swing

; larger than 3 will slow samus when initiating a swing
;(6 is prob as much as you'd like it to go, the effect become negligible/non-existent beyond that)

!SwingScale = 3



;subpixel deceleration when releasing from grapple swing
;higher numbers mean samus will get slowed down faster after being propelled
;default is $1000
!ReleasedSubDecel = $1000


;when trying to latch onto a grapple block, the 4 tiles next to grapple in each cardinal direction will be checked from this distance.
;larger distance = greater detection radius (but you prob don't want it to be greater than $10, as it will check tiles too far away)
!Distance = $000C; 12 pixels

;uncomment (remove the semicolons) the following to make samus spinjump when releasing from a grapple swing
;credit: Smiley
; org $9BCB97
; LDA #$0019
; org $9BCB9F
; LDA #$001A

;hijacks
org $9BC745;when initiating a grapple swing
JSR setupGrappleSwing : BRA $02


org !free9B
; first step is to convert samus's speed to angular speed
setupGrappleSwing:
LDA $0AF6 : STA $0E32
; some Rotating to preserve 2 most significant bits of subpixel X speed
ASL $0B48 : ROL $0B46
ASL $0B48 : ROL $0B46

LDA $0A1E : BIT #$0008 : BNE .right
LDA $0AF6 : SEC : SBC $0B46 : BRA ++
.right:
LDA $0AF6 : CLC : ADC $0B46
++
STA $0E36
; some Rotating to preserve 2 most significant bits of subpixel Y speed
ASL $0B2C : ROL $0B2E
ASL $0B2C : ROL $0B2E
LDA $0AFA : STA $0E34
LDA $0B36 : BIT #$0002 : BNE down
LDA $0AFA : SEC : SBC $0B2E : BRA ++
down:
LDA $0AFA : CLC : ADC $0B2E
++
STA $0E38
JSL $A0ACA8 : XBA : LSR #!SwingScale : STA $00;calculate the scaled speed
LDA $0D34 : ASL : TAX : JSR (directions,x);depending on the angle we latched on, and the direction we're moving, we might want to invert the speed
STA $0D26

;next step is to decide wether we want to increase/decrease the grapple beam's length
JSL checkbelow : BCS +; if there is a solid tile below the grapple block we latched onto, decrease length
LDA $0CFE : CMP #$0040 : BPL +; otherwise, we check if the lenght of grapple beam is above/below the max length when connected
LDA #$0002 : RTS
+
LDA #$FFF8 : RTS

directions:
;        ________________________________________________________________________________________ Up, facing right
;       |     ___________________________________________________________________________________ Up-right
;       |    |              _____________________________________________________________________ Right
;       |    |             |            _________________________________________________________ Down-right
;       |    |             |           |             ____________________________________________ Down, facing right
;       |    |             |           |            |       _____________________________________ Down, facing left
;       |    |             |           |            |      |        _____________________________ Down-left
;       |    |             |           |            |      |       |        _____________________ Left
;       |    |             |           |            |      |       |       |          ___________ Up-left
;       |    |             |           |            |      |       |       |         |          _ Up, facing left
;       |    |             |           |            |      |       |       |         |         |
DW Invert,cntrClockWise,cntrClockWise,cntrClockWise,Keep,Invert,ClockWise,ClockWise,ClockWise,Keep

cntrClockWise:
LDA $0E3A
CMP #$00C0 : BPL Keep
CMP #$0040 : BMI Keep
Invert:
LDA $00 : EOR #$FFFF : INC : RTS
Keep:
LDA $00 : RTS

ClockWise:
LDA $0E3A
CMP #$00C0 : BPL Invert
CMP #$0040 : BMI Invert
LDA $00 : RTS

!free9B #= pc()



;Bank $90

;preserve samus's momentum when releasing from a grapple swing

;hijacks during grapple swing release movement
org $909484;
JSR Preserve_hor_momentum
org $9094BF
JSR Dont_cancel_from_vertical


;x speed tables when releasing from grapple
org $909F31
DW $0000,$3000,$000F,$0000,$0000,!ReleasedSubDecel ; When disconnecting grapple beam in air
DW $0000,$3000,$000F,$0000,$0000,!ReleasedSubDecel ; When disconnecting grapple beam in water
DW $0000,$3000,$000F,$0000,$0000,!ReleasedSubDecel ; When disconnecting grapple beam in lava/acid


org !free90
;if we're holding left/right, and the X speed is > 1, then we preserve the grapple release movement handler
;allows the momentum to carry on longer
Preserve_hor_momentum:
STA $0B36
LDA $8B : BIT #$0300 : BEQ +
LDA $0B46 : CMP #$0002 : BMI +
PLA : JMP $948D
+
RTS
;don't cancel the vertical swing movement handler even if samus has started falling
;allows the momentum to carry on longer
Dont_cancel_from_vertical:
LDA $0DC6 : BEQ +
AND #$00FF : CMP #$0002 : BEQ +
+
RTS

!free90 #= pc()

;bank $94
;don't auto retract grapple beam when initiating a swing if latching on

;hijacks
org $94AC41;when retracting the grapple beam
JMP Smart_retracting

org $94A8F4;when checking for grapple tiles
JSL BetterLatchcheck


org !free94
;when changing the length of grapple beam, we
;make it so if the length is shorter than $3F (the max length when being latched on)
;then, we retract to the minimum length (this happens if you were already connected)
;if the length is greater than $3F, this means it's the first time we're latching on, and then we want to retract only until the max length
;this way, if we latch on for the first time, it won't default to zipping samus until she's right next to the block, which results in a smooth grapple latch effect
Smart_retracting:
LDA $0CFE : CMP #$0040 : BMI + ; if length is greater
CLC : ADC $0D00 : CMP #$003F : BCS ++ ; add grapple length delta
STZ $0D00 : LDA #$003F ; if reached max, stop retracting
++
JMP $AC53
+
JMP $AC44;retract until minimum value

;check the tile below the one grapple latched on for solid collision
checkbelow:
LDA $0D0C : PHA : CLC : ADC #$0010 : STA $0D0C
JSL $94A91F
PLA : STA $0D0C
RTL

;check the 4 tiles next to the point grapple is currently trying to connect
BetterLatchcheck:
LDA $0D08 : STA $00
LDA $0D0C : STA $02

LDX #$0014
PHP
-
PLP
LDA $0D08 : CLC : ADC Offsets,x : STA $0D08
LDA $0D0C : CLC : ADC Offsets+2,x : STA $0D0C
PHX : JSL $94A91F : PLX : BVS +;overflow gets set when connected to grapple block
PHP;preserve status bits (incase we don't hit any grapple block, we wanna know if it's air/solid
LDA $02 : STA $0D0C
LDA $00 : STA $0D08
TXA : SEC : SBC #$0004 : TAX : BPL -
PLP
+
RTL

;this checks the 4 tiles next to the tile grapple is in+ the central tile, in this order:
;center
;to the left
;above
;to the right
;below
;center again

;the center is done as last so we preserve the collision result of it (to allow grapple beam to grow if it hits air)
;it is also done as first incase we're aiming at an entire row/column of grapple blocks, so we select the one we're actually aiming at
Offsets:
DW $0000,$0000
DW $0000,!Distance
DW !Distance,$0000
DW $0000,-!Distance
DW -!Distance,$0000
DW $0000,$0000

!free94 #= pc()

;Grapple Slow scroll removal
;STZs
org $9BC66F
	NOP #3
org $9BC884
	NOP #3
org $9BBDB1
	NOP #3	
org $9BCBBA
	NOP #3
;Store
org $9BBDA9
	NOP #6