LoROM

;//[2017 PHOSPHOTiDYL]
;//[BROKEN CHARGE BEAM]
;===============================================================================================;
;-----------------------------------------------------------------------------------------------;
ORG $90DDCF	;//[ran if samus isn't running]
	JSR NewBeamFire		;//JSR $B80D

ORG $90DD61
	dw NewBeamFire
ORG $90DD67
	dw NewBeamFire

ORG $90B80D	;//[($007A bytes)]
	padbyte $FF : pad $80B887
;-----------------------------------------------------------------------------------------------;
ORG !free90	;//[BROKEN CHARGE BEAM ($00AB bytes)]	
NewBeamFire:
	PHP : REP #$30							;//start it
	LDA $0CD0 : STA $0DC2						;//vanilla
	LDA $0A76 : BEQ $03 : JMP $B887					;//fire uncharged shot
	LDA $09A6 : BIT #$1000 : BNE ChargeBeam				;//if charge beam, avoid this mess
BrokenCharge:
	LDA $8B : AND $09B2 : BEQ $02 : BRA NextCheck			;//if not holding fire...
	LDA $0CD0 : CMP #$0078 : BPL Charged				;//large timer for broken charge beam (same as sba timer)
RegularShot:
	LDA $8B : AND $09B2 : BEQ ClearEnd				;//if not holding fire, clear charge & end it
	LDA $0B5E : BEQ NextCheck					;//branch if not firing already
	LDA $0CD0 : CMP #$003C : BPL Charged				;//if overcharged, fire charged shot
NextCheck:
	LDA $8B : AND $09B2 : BEQ ExtraCheck				;//if not holding fire, skip timer increase
	LDA $0CD0 : INC A : STA $0CD0 : BRA EndIt			;//else increase charge timer
ExtraCheck:
	LDA $0CD0 : BEQ EndIt : CMP #$003C : BPL ClearEnd		;//this is necessary
Charged:
	STZ $0CD0 : JSR $BCBE : JMP $B986				;//zero charge, fire charged shot
ClearEnd:
	STZ $0CD0 : JSR $BCBE : JSL $91DEBA				;//clear everything charge related
EndIt:
	PLP : RTS							;//end it

ChargeBeam:
	LDA $0B5E : BEQ AnotherCheck					;//branch if not firing already
	LDA $0CD0 : CMP #$003C : BPL Charged : BRA Uncharged		;//timer for regular charge beam
AnotherCheck:
	LDA $8B : AND $09B2 : BEQ SameCheck				;//if not holding fire
	LDA $0CD0 : CMP #$0078 : BPL Special				;//sba timer
	INC A : STA $0CD0 : BRA EndIt					;//bugfix to not fire one shot b4 holding charge
SameCheck:
	LDA $0CD0 : BEQ EndIt : CMP #$003C : BPL Charged		;//regular charged shot timer
Uncharged:
	STZ $0CD0 : JSR $BCBE : JMP $B887				;//zero charge, fire uncharged shot
Special:
	JSR $CCC0 : BCC EndIt : BRA ClearEnd				;//sba code
;-----------------------------------------------------------------------------------------------;
;===============================================================================================;
!free90 #= pc()