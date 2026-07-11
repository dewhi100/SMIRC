lorom

;!free90 = 90F63A

org $90BB30	;was LDA $0CD0

JSR chargeHeal

org !free90
chargeHeal:
if !HealsCutoff == 1
	LDA $0A6A : BEQ +	;Dont heal if alarm is off.
endif
LDA $0CD0
CMP #$0078 : BMI +
LDA $0B46 : BNE +
LDA $0A20
AND #$00FF
CLC : SBC #$0009 : BPL +	;poses 0...8 are standing still
LDA $09C2
INC
if !HealsCutoff == 2
	if !HealthAlarmRevamp_MetroidNerd == 1
		CMP !lowHealthThreshold : BPL +	;custom
	else
		CMP #$001E : BPL +	;vanilla
	endif
endif
STA $09C2
+
LDA $0CD0
RTS

!free90 #= pc()