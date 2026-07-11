lorom

;Colors your beam red while in critical hp.
;intended for use with other things like Metroid Nerd's Power rush or Oi27's suit aura.
;by dewhi100

;Hijacks
org $90ACCD	;was LDA #$0090
JSR BeamCheckY

org $90ACFC	;was AND #$0FFF  
JSR BeamCheckA

org $90EA8C
JSR ResetLowHealth
;RTS : NOP	;replaces a BRA that points at an RTS...

org $90EAA4
JSR SetLowHealth
NOP #3 : RTS	;we assigned already

org !free90	;must be in bank 90
SetLowHealth:
LDA #$0001
STA $0A6A
LDA $09A6
JSL $90ACF0
RTS
ResetLowHealth:
STZ $0A6A
LDA $09A6
JSL $90ACF0
RTS

BeamCheckA:
LDA $0A6A : BEQ +
;if !BeamPatch_Mfreak == 0
LDA.W #(CriticalPointer-$C3C9)/2
;else
;LDA.W #(CriticalPointer-BeamPalettePointer)/2
;endif
RTS
+
LDA $09A6
AND #$0FFF
RTS
BeamCheckY:
LDA $0A6A : BEQ +
;if !BeamPatch_Mfreak == 0
LDY.W #(CriticalPointer-$C3C9)
;else
;LDY.W #(CriticalPointer-BeamPalettePointer)
;endif
+
LDA #$0090
RTS

if not(pc()%2)
NOP	;ensure we will be an odd address since $C3C9 is odd, and we are dividing the difference by 2
endif

CriticalPointer:
DW CriticalPalette
CriticalPalette:
DW $4487,$7FFF,$001F,$081A,$0016,$679F,$4F3F,$36BF,$159F,$001F,$001F,$001F,$001F,$001F,$001F,$000C

!free90 #= pc()