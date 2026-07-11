;Pseudo-Varia effect when holding fully charged ice beam.

;This patch intentionally conflicts with Smiley's suitdamage.asm in one spot, as this patch hijacks code that suitdamage tweaks.
;That tweak is included in this patch by default (excluding gravity from heat damage checks)
;If you WANT gravity to block heat damage, change #$0001 to #$0021 on the indicated instructions below.

;To eliminate the conflict with suitdamage.asm, delete this line from suitdamage.asm: 

;	"org $8DE37D : DB $01	;Gravity Suit no longer nullfies heat damage"

;It should be the final line in the patch.

lorom

org $8DE379 
NOP : NOP
JSL ChargedIceCheck

;Lower lava damage
org $9081F7
JSR HalfLava
BRA +
org $90820A
+

org !free90
ChargedIceCheck:
JSR CheckIce
BCS +
LDA $09A2	;if charge counter not 78 or euipped beams does not have ice, load normal item flags
AND #$0001	;CHANGE TO #$0021 TO INCLUDE GRAVITY
RTL
+
LDA #$0001	;CHANGE TO #$0021 TO INCLUDE GRAVITY
RTL

CheckIce:	;carry clear if not fully charged ice. otherwise carry set
LDA $0CD0	;charge counter
CMP #$0078	;fully charged
BEQ +
-
CLC
RTS
+
LDA $09A6	;equipped beams
BIT #$0002	;ice
BEQ -		;branch if ice not equipped
SEC
RTS

HalfLava:
JSR CheckIce
LDA #$8000	;lava damage over time
BCC +
CLC
LSR a
+
ADC $0A4E : STA $0A4E
LDA $0A4E : ADC $0000 : STA $0A4E
RTS