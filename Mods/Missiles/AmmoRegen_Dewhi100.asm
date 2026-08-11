;Missile regeneration by dewhi100
;Your missiles regenerate over time. 
;Regeneration speed is on an exponential curve based on your max missiles.
;With only 5 max missiles, regeneration is painfully slow. something like 1 missile every 45 seconds.
;With 255 missiles, you're getting a missile every couple *frames*.

LoROM

org $82DBB2	;every frame
JSR RegenAmmo		;originally LDA $09DA

org !free82
RegenAmmo:
LDA !AmmoRegenSubammo
ADC	!AmmoRegenRate_SRAM
BPL +
AND $7FFF
STA !AmmoRegenSubammo
LDA !missilesCurrent
CMP !missilesMax
BEQ ++
INC !missilesCurrent
++
LDA $09DA
RTS
+
STA !AmmoRegenSubammo
LDA $09DA
RTS

!free82 #= pc()

org $8489A9	;on ammo collect:
JSR SetAmmoRegenRate

org !free84
print pc, " - Regenerate Missiles"
SetAmmoRegenRate:
LDA !missilesMax
XBA
ORA !missilesMax
STA $4202	;writes 8-bit max HP to multiplication registers
NOP #4		;wait for result
LDA $4216
LSR #2
STA !AmmoRegenRate_SRAM
LDA !missilesMax	;hijacked instruction
RTS

!free84 #= pc()
