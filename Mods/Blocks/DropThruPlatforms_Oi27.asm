;Fall-Thru-Platforms
;---------------------------
;BTS solid from top unless holding down+jump
;Else, air.

macro hardwareDivision(divisor, dividend)
SEP #$20
LDA #$00
STA $4204
LDA #$01           ; Write $0100 to dividend
STA $4205
LDA #$02           ; Write $02 to divisor
STA $4206
NOP                ; Wait 16 machine cycles
NOP
NOP
NOP
NOP
NOP
NOP
NOP
LDA $4214          ; A = $80 (result low byte)
LDA $4215          ; A = $00 (result high byte)
LDA $4216          ; A = $00, as there are no remainders
LDA $4217          ; A = $00, as there are no remainders
endmacro

lorom
;vert collision table pointers are at 9494F5
;!94Free = $94DC00

org $9490A4
JSR VertCollision

org !free94 ;!94Free
VertCollision:
;[A] contains BTS in this moment
AND #$FF00 : CMP #$1000 : BEQ +
	RTS ;return if this is a region dependent tile
+
PHA ;keep BTS for later
LDA $0DC4 : STA $4204
SEP #$20
LDA $07A5
STA $4206
REP #$20
NOP                ; Wait 16 machine cycles
NOP
NOP
NOP
NOP
NOP
NOP
NOP
LDA $4214 : ASL #4 : CLC : ADC #$0001 : STA $16          ; Y coordinate, center of block (row)
LDA $0AFA : CLC : ADC $0B00 : CMP $16 : BPL + ;If Samus is above the block
	LDA $09B4 : ORA #$0400 : CMP $8B : BEQ ++ ;if holding jump + Down
		PLA : PLA ;pull BTS & Return address
		STZ $12
		STZ $14
		JMP $8F82 ;jump to solid collision
		SEC
		RTS		  ;return solid collision
	++
	PLA : PLA
	CLC
	RTS
+
PLA
RTS