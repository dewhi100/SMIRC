lorom

;State check- if enough time has passed in game, trigger state
;first argument- hours
;second argument- minutes

;Paste this into project.xml with the other state conditions (at the end of the file)
;Replace the ???? with the address of TimeElapsedState as given by the print statement
;    <StateCondition TestCodeAddress="????">
;      <Arguments>
;        <ArgType Name="Hours" Type="Byte" Action="Events" />
;        <ArgType Name="Minutes" Type="Byte" Action="Events" />
;      </Arguments>
;      <Name>Required time has elapsed</Name>
;    </StateCondition>

;Can go in any bank
org !free80
SetCarryIfEnoughTimeElapsed:
;SEP #$20 	;Set one-byte accumulator
;JSR CalculateMinutesElapsed
;CMP $0000,x	;Target minutes elapsed
LDA $0000,x
AND #$00FF
CMP $09E0	;Game time in hours
BMI +	;More than enough hours have passed
BNE ++	;Not enough hours have passed
LDA $0000,x
XBA : AND #$00FF
CMP $09DE
BMI +	;More than enough minutes have passed
BEQ +	;Just enough minutes have passed
;PLP
++
CLC			;Target time has not elapsed
RTL
+
SEC			;Target time has elapsed
RTL

warnpc !free80End
!free80 #= pc()


org !free8F
print "TimeElapsedState: ", pc
UseStateIfTimeElapsed:
JSL SetCarryIfEnoughTimeElapsed
BCC +
LDA $0002,x
TAX
JMP $E5E6
+
INX
INX
INX
RTS

!free8F #= pc()