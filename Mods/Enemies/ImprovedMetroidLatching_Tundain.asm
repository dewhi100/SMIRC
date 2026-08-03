lorom
;Improved metroid latching

;bomb jumping is reduced if a metroid is latched onto you. Allows easier removal of metroids by just bombing
;also fixes a bug where a metroid will always read projectile slot 0 when getting recoil from shooting it

;freespace! find some
;!Bank90Freespace = $90F700
;!BankA3Freespace = $A3F400

;Configuration!----------------------------

;bomb jump speed when latched (small value recommended)
!JumpSubspeed = $8000;subpixel
!Jumpspeed = $0001;pixel

;vertical and horizontal metroid speed when getting bombed off
;(a negative value to make the metroid move upwards)
;examples: 
;$FFFF.1000 = -0.9375 
;$FFFE.8000 = -1.5
!MetroidYspeed = $FFFF
!MetroidYSubspeed = $1000
;examples:
;$0002.4000 = 2.25
;$0003.2000 = 3.125
!MetroidXspeed = $0002
!MetroidXSubSPeed = $4000

!Bombed_off_time = 30 ;how many frames to be bombed off (60 frames = 1 second)

;hijack during "make samus bomb jump"
org $909A64
JSR check_latched


org !free90
check_latched:
;special palette flag indicates we're being drained by a metroid
LDA $0A4A : BMI + : BEQ +
LDA #!JumpSubspeed : STA $0B2C
LDA #!Jumpspeed : STA $0B2E
PLA : JMP $9A70; resume rest of routine

+
LDA $9EFB,x
RTS

!free90 #= pc()

;rewrite bombed off samus routine so the metroid actually gets knocked back
org $A3EDAB
JSR $EC11;just call normal movement function for smooth movement
DEC $0FB0,x  ; Decrement enemy bombed off Samus cooldown timer
BNE +      ; If [enemy bombed off Samus cooldown timer] = 0:
STZ $0FB2,x  ; Enemy function index = chase Samus
LDA #$E9CF : STA $0F92,x  ;} Enemy instruction list pointer = $E9CF (chasing Samus)
LDA #$0001 : STA $0F94,x  ;} Enemy instruction timer = 1
+
RTS


org $A3EF8C
LDA.w #!Bombed_off_time ;<-- set a longer time to be knocked off 
JSR setdirection_metroidLatch


;randomly get knocked to the left/right
org !freeA3	;!BankA3Freespace
setdirection_metroidLatch:
STA $0FB0,x
JSL $808111 : AND #$0001 : ASL : TAY
LDA XSpeeds,y : STA $0FAA,x
LDA XSubSpeeds,y : STA $0FA8,x
LDA #!MetroidYspeed : STA $0FAE,x
LDA #!MetroidYSubspeed : STA $0FAC,x
RTS

XSpeeds:
DW !MetroidXspeed,-!MetroidXspeed-1 ;-1 because we want to consider subspeed, so $0000 needs to become $FFFF for example
XSubSpeeds:
DW !MetroidXSubSPeed,-!MetroidXSubSPeed

!freeA3 #= pc()


org $A3EFB2;fix bug where it always reads projectile slot 1 when shooting a metroid (just don't reset Y to $0000)
BRA $1
