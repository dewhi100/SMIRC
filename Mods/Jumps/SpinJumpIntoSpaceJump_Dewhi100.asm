lorom
;Spinjump Into Spacejump  	Animation Override by dewhi100
;Based on Spin Boost AKA Limited Space Jump, by Oi27
;---------------------
;Plays the normal spinjump animation when jumping off a floor or wall. Space jump animation only triggers when jumping in midair.
;Screw attack animates normally, but you can restrict it to only function when jumping in midair, if you want.
;Requires free RAM as a jump counter. Other patches sometimes use this same RAM by default, so be careful.

;Number of Jumps made since last grounded. 0 = on floor; 1 = jumped from floor or wall; 2+ = jumped in midair i.e. utilized Space Jump
!JumpCounter = $099A ;any free RAM
;Free space in $90 and $91
!90Free = $90F63A
!91Free = $91EC9D ;overwrite unused routine
!ItemMask = #$FDF7 	;Masking Space Jump. Use FDF7 instead  if you also want to mask Screw Attack.
									;Screw attack not masked = screw attack whenever jumping with it equipped (Nullifying the space jump animation override)
									;Screw attack masked = only perform a screw attack on and after your first midair jump (i.e. when the space jump animation would play)

org $908445
 ;normally LDA 09A2 (equipped items)
JSR CheckFirstJump90
org $9098BC
;Does the actual counting. 0 = on floor; 1 = jumped from floor or wall; 2+ = jumped in midair (i.e. utilized Space Jump)
JSR CountJump
org $909E5E
;Resets your jump counter to 1 during/immediately after a wall jump. Hijacked instruction: "LDA #$0005"
JSR RefreshByWallJump
org $909E7F
JSR RefreshByWallJump

org !90Free
JSR RefreshPose		;initial spinjump doesnt work without this
LDA !JumpCounter
INC
STA !JumpCounter
JSR RefreshPose		;initial spacejump doesn't work without this
PLA							;\
PHP : PHB : PHK		;|---This is the code block that got hijacked. nothing to do with the patch. well, sort of. you  get the idea
PHA							;/
RTS

RecoverSpaceJump:
TDC : STA !JumpCounter ;zeroes the counter
RTL

;Duplicate of the routine in bank 91 but hijacks a different  instruction.
RefreshByWallJump:
JSL RecoverSpaceJump
INC !JumpCounter	;set it to one
LDA #$0005	;hijacked instruction
RTS

CheckFirstJump90:
JSL CheckFirstJumpLong
RTS

RefreshPose:
LDA $0B3C : PHA	;keep momentum flag across pose change
LDA #$000C : JSL $90F084 ;this routine immediately calls "Update Samus Pose due to Equipment Change", and then updates the Samus state handlers in $0A42/44
PLA : STA $0B3C 
RTS

org $91E94A
;Resets your jump counter to 0 when landing. Hijacked instruction: "LDA #$0005"
JSR ClearLandFlag

;dont enter space jump poses if jumping for the first time
 ;normally LDA 09A2 (equipped items)
org $91D9F7
JSR CheckFirstJump
org $91DA0B
JSR CheckFirstJump
org $91E7A8
JSR CheckFirstJump
org $91E7B7
JSR CheckFirstJump
org $91E894
JSR CheckFirstJump
org $91F6B2
JSR CheckFirstJump
org $91F713
JSR CheckFirstJump

org !91Free
ClearLandFlag:
JSL RecoverSpaceJump
LDA #$0005 ;hijacked instruction
RTS

CheckFirstJump:
LDA !JumpCounter : CMP #$0002 : BPL + ;branch if jump count >= 2
LDA $09A2
AND !ItemMask 
RTS
+
LDA $09A2
RTS

CheckFirstJumpLong:
JSR CheckFirstJump
RTL

warnpc $91ECD0