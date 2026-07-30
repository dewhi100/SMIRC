;Suit Aura
;-------------
lorom
!AuraRadius = 1     ;(d. pixels)
!AuraITM = $0020	;item to activate the aura:
;        			0001: Varia suit
;        			0002: Spring ball
;        			0004: Morph ball
;        			0008: Screw attack
;        			0020: Gravity suit
;        			0100: Hi-jump boots
;        			0200: Space jump
;        			1000: Bombs
;        			2000: Speed booster
;        			4000: Grapple
;        			8000: X-Ray
!AuraRAM = $0A02	;any unused RAM
!AuraPAL = $0000	;change this value to change color of aura
;#$0A00 for generic palette | but it looks bad
;#$0C00 for beam palette    | changes color depending on the equipped beam(!)
;#$0E00 for enemy palette 7 | if it were to have its own palette or something
;#$0000 for enemy hurt palette (white)


!81Free = $81EF1A	;Code to change aura palette 
!8FFree = $8FEA00	;Code to create aura. Relocatable anywhere in the ROM below $B8.
!90Free = $90F73E	;Code to create aura. Has to stay in $90.

macro AuRad(radius,code)         ;repeat INC/DEC $14 and $12 for the defined AuraRadius
 
	!counter = 0
	while !counter < <radius>
		<code>
		!counter #= !counter+1 
	endwhile
 
endmacro

;Major credit to PJ for the bank log!
;------------------------
;------------------------
org $828BA8	;hijack of main game loop where it would handle room Main ASM
JSL AURA_DrawAura

org $818A1D	;hijack samus transfer to OAM
JSR EchoesPaletteChange

org !8FFree
AURA:
.DrawAura	;relocatable anywhere in the ROM with shortRAM access
{
PHX : PHY : PHB
LDA $09A2 : BIT #!AuraITM : BNE +	;if Gravity Suit Equipped continue
..out
	PLB
	JSL $8FE8BD								;handle room main ASM.
	PLY : PLX
	RTL
+
LDA $18A8 : BNE ..out				;Quit drawing them when flashing (hurt)
LDA $0A5C : CMP #$EB87 : BPL ..out	;also quit drawing the aura if Samus is dead/others
;    $0A5C: Samus drawing handler
;    
;        $EB52: Default
;        $EB86: Firing grapple beam
;        $EBF2: RTS. Unused
;        $EBF3: End of shinespark
;        $EC14: Using elevator
;        $EC1D: Samus received fatal damage
LDX #$0000
LDA !AuraRAM : ORA #$8000 : STA !AuraRAM 		;flip neg again so $81 will mess with the palette
PEA $9200
PLB : PLB

LDA $0A1C : ASL A : TAX                 ; X = [Samus pose] * 2
LDA $929263,x : CLC : ADC $0A96			; A = [$92:9263 + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - top half)
PHA										;Push the spritemap pointer
	
TXA : ASL A : ASL A : TAX
LDA $91B62D,x : AND #$00FF : STA $12    ; $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)


LDA $0AF6 : SEC : SBC $0911 : TAX		;Adjust spritemap X for L1 X position
LDA $0AFA : SEC : SBC $0915 : TAY		;Adjust spritemap Y for L1 Y position		

STZ $14
JSR ..manipPOS			
TXA : CLC : ADC $14 : TAX
TYA : SEC : SBC $12 : TAY
PLA										;Pull spritemap pointer
JSL $8189AE								; Add Samus spritemap [A] to OAM at position ([X], [Y])

LDA $0A1C : ASL A : TAX					; X = [Samus pose] * 2
STX $24    			   					; $24 = [X]
LDA $0A1F : AND #$00FF : ASL A : TAX  	;Execute [$864E + [Samus movement type] * 2]
JSL EchoesHook							;execute some code in $90 to figure out if bottom should be drawn
BCC +    			   					; If carry set: (bottom spritemap is drawn)
LDX $24    			   					;\
LDA $92945D,x : CLC : ADC $0A96			; A = [$92:945D + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - bottom half)
PHA	
	               
TXA : ASL A : ASL A : TAX
LDA $91B62D,x : AND #$00FF : STA $12    ; $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)

LDA $0AF6 : SEC : SBC $0911 : TAX		;Adjust spritemap X for L1 X position
LDA $0AFA : SEC : SBC $0915 : TAY		;Adjust spritemap Y for L1 Y position		

STZ $14
JSR ..manipPOS	
TXA : CLC : ADC $14 : TAX
TYA : SEC : SBC $12 : TAY
PLA		   	          
JSL $8189AE			   					; Add Samus spritemap [A] to OAM at position ([X], [Y])
+
INC !AuraRAM
LDA !AuraRAM : AND #$0FFF : STA !AuraRAM		;flip pos again to play nice with OAM routine
PLB
JSL $8FE8BD								;handle room main ASM. DB will be $82 coming into here and coming out.
PLY : PLX
RTL



..manipPOS
;INC or DEC 12 and 14 depending on the position of some RAM
;00 = down, 01 = right, 02 = up, 03 = left
;12 does not need extra work since it's always positive(?)
SEP #$20
LDA !AuraRAM : CMP #$04 : BMI +
STZ !AuraRAM
+
LDA !AuraRAM
CMP #$00 : BEQ ...down
CMP #$01 : BEQ ...right
CMP #$02 : BEQ ...up
;Use like:
if !AuraRadius > 0
...left	;does extra work to make $14 a 16-bit negative.
	%AuRad(!AuraRadius,"DEC $14")
	LDA #$FF : STA $15 : BRA ...out
...up   
	%AuRad(!AuraRadius,"INC $12") 
	BRA ...out
...right
	%AuRad(!AuraRadius,"INC $14") 
	BRA ...out
...down 
	%AuRad(!AuraRadius,"DEC $12")
...out
	REP #$20
else
                error "AuraRadius cannot be less than 1."
endif
RTS
}


org !81Free
EchoesPaletteChange:
;[X] = OAM index, [Y] = tiles pointer
; More specifically, a spritemap entry is:
;     s000000xxxxxxxxx yyyyyyyy   YXpp PPPt tttt tttt
PHA
	LDA !AuraRAM : BPL +	
		PLA : AND #$F1FF : ORA #!AuraPAL : PHA	;mess with the palette
	+
PLA
STA $0372,x
RTS

org !90Free
EchoesHook:
PHB : PHX
PHK : PLB
JSR ($864E,x) ;set carry if Samus lower sprite drawn
BCS +
PLX : PLB
RTL
+
PLX : PLB
SEC			;Re-set Carry after PLB
RTL


