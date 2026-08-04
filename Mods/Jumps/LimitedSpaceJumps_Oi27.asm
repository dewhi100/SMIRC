lorom
;Limited-SpaceJump.asm
;---------------------
;Set Samus's pose and graphics to normal spin jump after Space is used.
;Requires free RAM as a jump counter
;Free space in $90 and $91

;!JumpCounter = $0A02 ;any free RAM
;!JumpsAllowed = $0002 ;number of jumps incl the one from the ground
;!90Free = $90F63A
;!91Free = $91EC9D ;overwrite unused routine

if !PlanetaryGravityRework_Dewhi100 == 0
	org $9098BC
	JSR CountJump
endif

org $9099CA
JSR RefreshByWallJump

org !free90
CountJump:
;disallow jump if the flag is too high. Else, INC & do the stack instructions we overwrite.
;Double checks the jump flag at the beginning bc the jump that increments it to the jump limit needs to propel Samus.
LDA !JumpCounter : CMP #!JumpsAllowed : BMI +
	PLA : RTL
+
INC
STA !JumpCounter : CMP #!JumpsAllowed : BMI +
	JSR UpdateGraphics
+
PLA
PHP : PHB : PHK
PHA
RTS
UpdateGraphics:
;Executes a walljump check because otherwise, the code for updating the graphics would screw up walljumps when space jump was still possible.
;So, this additional walljump check skips the update & allows walljump to do its thing later on this frame.
LDA $9E9F : STA $12 ;walljump distance constant in $90
STZ $14
JSR $9D35 ;walljump check. For some reason it reads $12 and $14 as input parameters for check distance...
BCS +
LDA $0B3C : PHA	;keep momentum flag across pose change
LDA $09A2  : AND #$FDFF : STA $09A2
LDA #$000C : JSL $90F084 ;this routine immediately calls "Update Samus Pose due to Equipment Change", and then updates the Samus state handlers in $0A42/44
PLA : STA $0B3C 
+
RTS
RecoverSpaceJump:
;Jump count > 2 means they used Space & had it equipped previously
;Walljumps do not increment it because they have their own jump routine
LDA !JumpCounter : CMP #$0002 : BMI + 
	LDA $09A4 : BIT #$0200 : BEQ +
	LDA $09A2  : ORA #$0200 : STA $09A2
+
TDC : STA !JumpCounter
RTL

RefreshByWallJump:
JSL RecoverSpaceJump
INC !JumpCounter	;set it to one
STZ $0AA0
RTS

!free90 #= pc()

org $91E94A
JSR ClearLandFlag

org !unused91EC9D
ClearLandFlag:
;[A] needs to be 5 before RTS.
JSL RecoverSpaceJump
LDA #$0005
RTS

warnpc !unused91EC9DEnd
!unused91EC9D #= pc()


