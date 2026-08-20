ASAR 1.90
LOROM
;---------------------------------------------------------------------------------------------------
;|x|                                         FX OVERHAUL                                         |x|
;|x|                                       Made by MFreak                                        |x|
;---------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------
;|x|                                    CONFIG                                                   |x|
;---------------------------------------------------------------------------------------------------

;--------------------------------------- COLOR OPTION ----------------------------------------------

;Change the palette index used for all color options (default: $18)
;($00 - $7F: tile palettes ;$80 - $FF: sprite palettes ;$18 - $1C: palette blend)
	!ColorOptionPaletteIndex = $18


;--------------------------------------- LIQUID / BG3 / HAZE TIDE ----------------------------------

;Set size of small tides (vanilla: $08)
	!SmallTideSize = $08

;Set speed of small tides if liquid level above set height (vanilla: $0C)
	!SmallTideRiseSpeed = $0C

;Set speed of small tides if liquid level below set height (vanilla: $12)
	!SmallTideFallSpeed = $12


;--------------------------------------- LIQUID EFFECT ---------------------------------------------

;Set default flowing speed of liquid if "flowing left" is set (vanilla: $0040)
;low byte: subpixel speed   ;high byte: pixel speed
;If set to a negative value the liquid will flow to the right.
	!LiquidHorizontalFlowSpeed = $0040


;Set transition speed of water effect for the background (vanilla: $06)
	!BackgroundWaterEffectDelay = $06

;Set transition speed of water effect for the liquid (vanilla: $0A)
	!LiquidWaterEffectDelay = $0A

;Set transition speed of heat effect for the background (vanilla: $04)
	!BackgroundLavaEffectDelay = $04

;Set transition speed of heat effect for the liquid (default: $06)
	!LiquidHeatEffectDelay = $06


;Set sound delay for the bubbling sound effect for lava (vanilla: $70)
	!LavaBubblingSoundDelay = $70


;Change the PLM required to disable water physic (default: $D70C "n00b tube")
;Setting it to zero will always disable water physic.
	!DisableWaterPhysicPLM = $D70C


;--------------------------------------- MESSAGE BOX -----------------------------------------------

;Change rather or not the outside of an open message box should adapt the atmospheric color or not (default: 1)
;[0 = no color adaption ;1 = adapt color]
	!MessageBoxAdaptColorMath = 1


;--------------------------------------- OBJECT EFFECT ---------------------------------------------

;Determine which BTS in the level will be used as index for object data of other FX effects (default: $00 [first block BTS in the room])
	!BTSObjectIndex = $00

;Set default level of detail for objects (default: $1F)
;(range: $00 - $7F, going over will loop back to zero)
	!ObjectDefaultLevelOfDetail = $1F


;--------------------------------------- PALETTE BLEND ---------------------------------------------

;If any of these settings are set to 1 (true), then the location for palette blend should be changed
;to somewhere with more freespace to utilize all palette blend indexes.

;Change if uneven index numbers can be used for palette blend. (default: 0)
	!PaletteBlendUnevenIndex = 0

;Change if the whole palette blend section should be selected per index. (default: 0)
	!PaletteBlendFullPaletteIndex = 0

;Set the pointer for palette blend (vanilla: $89AA02)
	!PaletteBlendPointer = $89AA02


;--------------------------------------- SCROLLING SKY EFFECT --------------------------------------

;Set scrolling sky scroll speed for the coral background (default: $08)
;(range: $00 - $0F ;$00 means no scroll and $0F means 1:1 scroll with foreground)
	!ScrollingSkyColarScrollSpeed = $08


;--------------------------------------- X-RAY -----------------------------------------------------

;Choose from which list of flags should be read to disable X-Ray (default: 1)
;[0 = read from animated tiles FX list ;1 = read from palette FX list]
	!DisableXRayFromPaletteTable = 1

;Choose which flags should disable X-Ray from showing blocks (default: last flag of palette/animated tiles FX)
;If multiple bits are set, then all selected ones must be set for X-Ray to not show blocks.
	!DisableXRayFlag = %10000000



;---------------------------------------------------------------------------------------------------
;|x|                                    CLEANUP                                                  |x|
;---------------------------------------------------------------------------------------------------
{
ORG $88A7D8 : PADBYTE $FF : PAD $88ADBB	;delete FX effect $22 (unused ocean effect)
ORG $88B058 : PADBYTE $FF : PAD $88B21D	;delete fireflea effect/unused message box expanding effect
ORG $88B279 : PADBYTE $FF : PAD $88D865	;delete FX effect $02-$06 (liquid effect)
ORG $88D950 : PADBYTE $FF : PAD $88DB8A	;delete FX effect $08-$0C (BG3 effect)
ORG $88DD32 : PADBYTE $FF : PAD $88DF33	;delete FX effect $2C (haze effect)

;ORG $8AB180 : PADBYTE $FF : PAD $8AE980	;delete uncompressed tile data of crateria scrolling sky background
}

;---------------------------------------------------------------------------------------------------
;|x|                                    CONFIG LIST                                              |x|
;---------------------------------------------------------------------------------------------------
{
;-------------------------------------- CONFIG TABLES ----------------------------------------------
ORG $88AA20
{
Table_WaterFX_Offset:
	DW $0000, $0001, $0001, $0000, $0000, $FFFF, $FFFF, $0000
	DW $0000, $0001, $0001, $0000, $0000, $FFFF, $FFFF, $0000

Table_HeatFX_Offset:
	DW $0000, $0001, $0001, $0000, $0000, $FFFF, $FFFF, $0000
	DW $0000, $0001, $0001, $0000, $0000, $FFFF, $FFFF, $0000

Table_BG3Effect_AnimatedTilePointer:
	DW $82FD, $82E7, $0000, $0000
	DW $0000, $0000, $0000, $0000
	DW $0000, $0000, $0000, $0000
	DW $0000, $82AB, $82C9, $0000

MACRO ObjectFlag(followSamus, applyColor, tiltShape, roundShape, X_plusSize, Y_plusSize)
	DB <Y_plusSize><<7|<X_plusSize><<6|<roundShape><<5|<tiltShape><<4|<applyColor><<2|<followSamus>
ENDMACRO

Table_Object_ExternalData:
;Object flags are defined as follows:
;(<Follow Samus>, <Apply color in object>, <Change shape to tilt>, <Change shape to round>, <Extend X size>, <Extend Y size>)
;set to 1 to enable effect
	DW $0000, $0000, $0100 : DB $50 : %ObjectFlag(1, 1, 0, 1, 0, 0)	;circle shape, follow samus
	DW $0000, $0000, $0100 : DB $50 : %ObjectFlag(1, 1, 0, 0, 0, 0)	;square shape, follow samus
	DW $0000, $0000, $0100 : DB $50 : %ObjectFlag(1, 1, 1, 0, 0, 0)	;rhombus shape, follow samus
	DW $0000, $0000, $0100 : DB $50 : %ObjectFlag(1, 1, 1, 1, 0, 0)	;star shape, follow samus
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 1, 0, 0)	;circle shape, fixed position at screen center
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)	;square shape, fixed position at screen center
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 1, 0, 0, 0)	;rhombus shape, fixed position at screen center
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 1, 1, 0, 0)	;star shape, fixed position at screen center
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
	DW $0080, $0080, $0000 : DB $40 : %ObjectFlag(0, 1, 0, 0, 0, 0)
}
WARNPC $88ADBB

;-------------------------------------- LAYER CONFIG -----------------------------------------------
ORG $8881C0
{
LayerTypeConfiguration:
	DB $00, $00	;$00 (DO NOT USE)
	DB $13, $04	;$02 (default)
	DB $11, $04	;$04 (disable L2)
	DB $13, $14	;$06 (add sprites to sublayer)
	DB $11, $06	;$08 (change L2 to sublayer)
	DB $15, $02	;$0A (swap L2 with L3)
	DB $0C, $13	;$0C (liquid)
	DB $53, $04	;$0E (disable power bomb explosion effect on L2)
	DB $4C, $13	;$10 (liquid, disable power bomb explosion effect on L2)
	DB $33, $04	;$12 Custom (disable power bomb explosion effect on L1)
	DB $12, $05	;$14 Custom (change L1 to sublayer)
	DB $16, $01	;$16 Custom (swap L1 with L3)
	DB $13, $4C	;$18 Custom (mask out L2 instead of L3 in window mode)
	DB $13, $A4	;$1A Custom (also mask out L1/sprites in window mode)
	DB $00, $00	;$1C *empty*
	DB $00, $00	;$1E *empty*
	DB $00, $00	;$20 *empty*
	DB $00, $00	;$22 *empty*
	DB $00, $00	;$24 *empty*
	DB $00, $00	;$26 *empty*
	DB $00, $00	;$28 *empty*
	DB $00, $00	;$2A *empty*
	DB $00, $00	;$2C *empty*
	DB $00, $00	;$2E *empty*
	DB $00, $00	;$30 *empty*
	DB $00, $00	;$32 *empty*
	DB $00, $00	;$34 *empty*
	DB $00, $00	;$36 *empty*
	DB $00, $00	;$38 *empty*
	DB $00, $00	;$3A *empty*
	DB $00, $00	;$3C *empty*
	DB $00, $00	;$3E *empty*
	DB $00, $00	;$40 *empty*

ColorMathConfiguration:
	DB $00, $00	;$00 (DO NOT USE)
	DB $02, $37	;$02 (default)
	DB $02, $35	;$04 (disable color L2)
	DB $02, $36	;$06 (disable color L1)
	DB $02, $27	;$08 (disable color sprites)
	DB $02, $26	;$0A (disable color L1/sprites)
	DB $02, $B7	;$0C (subtract color)
	DB $02, $B6	;$0E (subtract color, disable color L1)
	DB $02, $77	;$10 (halve color)
	DB $02, $55	;$12 (halve color, disable color L2/backdrop)
	DB $00, $37	;$14 (color mode)
	DB $00, $B7	;$16 (color mode, subtract color)
	DB $00, $A6	;$18 (color mode, subtract color, disable color L1/sprites)
	DB $06, $37	;$1A (window mode)
	DB $16, $37	;$1C (mother brain)
	DB $02, $95	;$1E Custom (subtract color, disable color L2/backdrop)
	DB $00, $25	;$20 Custom (color mode, disable color L2/sprites)
	DB $00, $A5	;$22 Custom (color mode, subtract color, disable color L2/sprites)
	DB $06, $35	;$24 Custom (window mode, disable color L2)
	DB $06, $27	;$26 Custom (window mode, disable color sprites)
	DB $06, $26	;$28 Custom (window mode, disable color L1/sprites)
	DB $06, $B7	;$2A Custom (window mode, subtract color)
	DB $06, $A6	;$2C Custom (window mode, subtract color, disable color L1/sprites)
	DB $0E, $37	;$2E Custom (window mode inverted)
	DB $0E, $B7	;$30 Custom (window mode inverted, subtract color)
	DB $00, $00	;$32 *empty*
	DB $00, $00	;$34 *empty*
	DB $00, $00	;$36 *empty*
	DB $00, $00	;$38 *empty*
	DB $00, $00	;$3A *empty*
	DB $00, $00	;$3C *empty*
	DB $00, $00	;$3E *empty*
	DB $00, $00	;$40 *empty*
	DB $00, $00	;$42 *empty*
	DB $00, $00	;$44 *empty*
	DB $00, $00	;$46 *empty*
	DB $00, $00	;$48 *empty*
	DB $00, $00	;$4A *empty*
	DB $00, $00	;$4C *empty*
	DB $00, $00	;$4E *empty*
	DB $00, $00	;$50 *empty*
	DB $00, $00	;$52 *empty*
	DB $00, $00	;$54 *empty*
	DB $00, $00	;$56 *empty*
	DB $00, $00	;$58 *empty*
	DB $00, $00	;$5A *empty*
	DB $00, $00	;$5C *empty*
	DB $00, $00	;$5E *empty*
	DB $00, $00	;$60 *empty*
	DB $00, $00	;$62 *empty*
	DB $00, $00	;$64 *empty*
	DB $00, $00	;$66 *empty*
	DB $00, $00	;$68 *empty*
	DB $00, $00	;$6A *empty*
	DB $00, $00	;$6C *empty*
	DB $00, $00	;$6E *empty*
	DB $00, $00	;$70 *empty*
	DB $00, $00	;$72 *empty*
	DB $00, $00	;$74 *empty*
	DB $00, $00	;$76 *empty*
	DB $00, $00	;$78 *empty*
	DB $00, $00	;$7A *empty*
	DB $00, $00	;$7C *empty*
	DB $00, $00	;$7E *empty*
	DB $00, $00	;$80 *empty*
}
WARNPC $888288
}

;---------------------------------------------------------------------------------------------------
;|x|                                    BANK $88                                                 |x|
;---------------------------------------------------------------------------------------------------
{
ORG $888008
	BEQ + : JSR LayerBlendingHandler
+ : LDA $1987 : BPL + : JSR PowerBombLayerBlending : PLP : RTS	;change layer blending for power bomb
+ : ASL : BPL + : JSR XRay_ShowBlocks : PLP : RTS				;change layer blending for x-ray showing blocks
+ : ASL : BPL + : JSR XRay_DisableShowBlocks : PLP : RTS		;change layer blending for x-ray not showing blocks
+ : PLP : RTS


Window1MaskSettingBits:
	DB $00, $02, $20, $22
Window1MaskLayerBits:
	DB $04, $00, $05, $01, $06, $02, $07, $03
	DB $14, $10, $15, $11, $16, $12, $17, $13

LayerBlendingHandler:
	PHB : PHK : PLB
	STZ $60 : STZ $61 : STZ $62		;disable window masking ($2123/24/25)
	LDX $1984
	LDA.w LayerTypeConfiguration,x : STA $69		;main layer ($212C)
	LDA.w LayerTypeConfiguration+1,x : STA $6B		;sub layer ($212D)
	STZ $6C		;window area main screen ($212E)
	STZ $6D		;window area sub screen ($212F)
	LDX $1986
	LDA.w ColorMathConfiguration+1,x : STA $71		;color math designation ($2131)
	LDA.w ColorMathConfiguration,x : STA $6E		;color addition ($2130)
	BIT #$04 : BEQ +++						;check if window mode set
;Set up window masking depending on sublayer bits
	LDA $6B : LSR #4 : ROR : CLC : BPL + : SEC
+ : ROL : TAX : LDA.w Window1MaskLayerBits,x : STA $6C
	AND #$03 : TAX : LDA.w Window1MaskSettingBits,x : STA $60
	LDA $6C : AND #$0C : LSR #2 : TAX : LDA.w Window1MaskSettingBits,x : STA $61
	LDA $6C : BIT #$10 : BNE + : LDA #$20 : BRA ++
+ : LDA #$22 : ++ : STA $62
;Invert window mask if inversion bit in color math designation is set
	LDA $6E : BIT #$08 : BEQ +
	LDA $60 : LSR : TSB $60
	LDA $61 : LSR : TSB $61
	INC $62
;Adapt window mask designation from screen layers
+ : LDA $69 : STA $6C
	LDA $6B : STA $6D
;Set color for color math, if:
+++ : BIT $1987 : BMI +			;power bomb not active
	LDA $1969 : BNE +			;FX entry loaded
	LDA $6E : BIT #$0C : BNE +	;window 1 not active
	JSR SetColorMath
+ : PLB : RTS


;Convert palette data to component values for color math
;(not my code, saw it posted by "MarioFanGamer" in the asm channel. This is way smarter!)
SetColorMath:
	PHP : REP #$20
	LDA (!ColorOptionPaletteIndex<<1)+$7EC000 : ASL #3	;shift green
	SEP #$21 : ROR #3							;prepare red
	XBA : AND #$5F : ORA #$40 : STA $75			;set green
	LDA (!ColorOptionPaletteIndex<<1)+$7EC001			;load for blue
	LSR : SEC : ROR : STA $76			;shift and set blue
	XBA : STA $74						;set red
	PLP : RTS


XRay_DisableShowBlocks:
	STZ $60 : STZ $61 : LDA #$80 : STA $62
	LDA $69 : LSR #5 : TAX
	JSR SwapLayerBlending
	LDA $69 : STA $6C		;adapt mainlayer to mask
	LDA $6B : STA $6D		;adapt sublayer to mask
	BRA +

XRay_ShowBlocks:
	LDA #$C8 : STA $60 : STZ $61 : LDA #$80 : STA $62
	LDA $69 : LSR #5 : TAX
	LDA #$13 : STA $69 : STA $6C		;set mainlayer and mask to default
	LDA #$04 : STA $6B : STA $6D		;set sublayer and mask to default

+ : LDA $6E : AND #$02 : ORA #$20 : STA $6E			;add restrictive color outside window
	LDA $71 : AND #$80 : ORA #$77					;adapt subract bit of color math for x-ray
	AND.l DisableColorMathOnPowerBomb,x : STA $71	;disable color math depending on power bomb setting, add halved to color math
	RTS

SwapLayerBlending:
	LDA $69 : BIT #$08 : BEQ + : AND #$1F : TRB $69 : PHA
	LDA $6B : AND #$1F : TRB $6B
	TSB $69 : PLA : TSB $6B
+ : LDA $69 : AND #$04 : BEQ + : TRB $69 : TSB $6B
+ : RTS

PowerBombLayerBlending:
	JSR SwapLayerBlending
;Set window masking to window 2 depending on sublayer (color layer forced set)
+ : LDA $6B : AND #$03 : TAX : LDA.l Window2MaskSettingBits,x : STA $60
	LDA $6B : AND #$0C : LSR #2 : TAX : LDA.l Window2MaskSettingBits,x : STA $61
	LDA $6B : BIT #$10 : BNE + : LDA #$80 : BRA ++
+ : LDA #$88 : ++ : STA $62
	LDA #$02 : TSB $6E	;force sublayer activation
;Set color math depending on extra mainlayer settings
	LDA $69 : LSR #5 : TAX
	LDA #$37 : AND.l DisableColorMathOnPowerBomb,x : STA $71
	LDA $6B : STA $6D	;adapt window mask designation from screen layers
	RTS

DisableColorMathOnPowerBomb:
	DB $FF, $FE, $F9, $F8, $EF, $EE, $E9, $E8
Window2MaskSettingBits:
	DB $00, $08, $80, $88

WARNPC $8881C0


;change FX base Y subposition from $8000 to set default screen layer value on room loading
ORG $888365 : LDA #$0002
ORG $888383 : STA $1982 : STA $1984


;DO NOT FIX this "branching error" to STZ $85. This will break the transition animation in the hex map and map section.
;ORG $8884EE : BPL $27


;X-ray HDMA beam pre-instruction: main
ORG $8886F2 : LDX #$2000 : LDA $197F : BIT.w #!DisableXRayFlag : BNE $1B	;check if FX flag is set to disable x-ray
ORG $888709 : BRA + : ORG $888718 : +
ORG $88872E : DW $89BA, $8A08		;new pointers for x-ray HDMA beam routines

;X-ray HDMA beam pre-instruction: stage "deactivate beam"
ORG $888956 : LDX #$2000 : LDA $197F : BIT.w #!DisableXRayFlag : BNE $0C
ORG $8889A7 : AND #$00F8		;increase masking to not write tiledata of BG2 in BG1

;X-ray HDMA beam pre-instruction: stage "deactivate beam"
ORG $8889BD : LDX #$2000 : LDA $197F : BIT.w #!DisableXRayFlag : BNE $0C
ORG $8889F1 : AND #$00F8		;increase masking to not write tiledata of BG2 in BG1

;X-ray HDMA beam pre-instruction: stage "deactivate beam"
ORG $888A0B : LDX #$2000 : LDA $197F : BIT.w #!DisableXRayFlag : BNE $0C



;Tourian Entrance effect
ORG $88DBAA
	JSL FX_Water : JSL $888435		;hijack patch water into tourian entrance routine
	DB $42, $10 : DW $DCFA			;spawn HDMA object for BG2 Y scroll (special routines for tourian entrance)
	RTL
;$14 bytes left


;Suit pick up color layer
ORG $88E046 : LDA #$001A
ORG $88E07C : LDA #$001A


;Phantoon FX change routine
ORG $88E451
	BVS +
	LDA #$0004 : LDX $1074 : BEQ ++				;phantoon invisible
	CPX #$FF : BEQ +++ : LDA #$0002 : BRA ++	;check if defeated, else: phantoon solid
+ : LDA #$0008									;phantoon semi-transparent
++ : STA $1984 : PLP : RTL
;5 bytes left
ORG $88E471 : +++


;Mother Brain rainbow laser color layer
ORG $88E77A : LDA #$001C
ORG $88E7C7 : LDA #$001C


;Morph ball eye laser color layer
ORG $88E933 : LDA #$001A
ORG $88E9E9 : LDA #$001A
ORG $88EA3F : LDA #$001A
ORG $88EACE : LDA #$001A
}

;---------------------------------------------------------------------------------------------------
;|x|                                    EFFECTS                                                  |x|
;---------------------------------------------------------------------------------------------------
{
ORG $88A7D8
;-------------------------------------- SCROLLING SKY ----------------------------------------------
{
;FX_ScrollingSky:
- : PHP : SEP #$20
	JSL $888435
	DB $42, $0F : DW Inst_ScrollingSky		;indirect, 1 register write twice for layer 2 screen X position
	PLP : RTL
PADBYTE $FF : PAD $88A800 : BRA -


Inst_ScrollingSky:
	DW $8655 : DB $7E
	DW $866A : DB $7E
	DW PreInst_ScrollingSky
	DW $8570 : DL $88ADBB
.loop
	DW $7777, $9F00
	DW $85EC, .loop
;0 bytes left. Check ORG of misc


;Adjust sky scrolling routine
ORG $88ADBB
	REP #$30 : LDA $0A78 : BEQ +
	LDA $85 : EOR $18B4,x : STA $85 : RTL : +	;disable effect if time is frozen
ORG $88AE4C : LDA #$9FFE						;coral background X position
ORG $88AE62 : JSR ScrollingSky_CalculateLayer2X_Position


;Return scrolling sky from main ASM
ORG $88AF8D : RTL
PADBYTE $FF : PAD $88AF99 : RTL


;Calculated for scroll of coral background
;BG2 X scroll percent * current layer 1 X position
ScrollingSky_CalculateLayer2X_Position:
	PHX : SEP #$20
	LDX $18B2 : LDA.b #!ScrollingSkyColarScrollSpeed<<4 : STA $4202 : LDA $0911 : STA $4203
	STZ $13 : NOP #2 : LDA $4217 : STA $12 : LDA $0912 : STA $4203
	REP #$20 : LDA $12 : CLC : ADC $4216 : STA $7E9FFE : LDA #$9FFE
	PLX : RTS

PreInst_ScrollingSky:
	SEP #$20 : LDA $0998 : CMP #$07 : BEQ +	: CMP #$29 : BEQ +	;depending on game state (main gameplay fading in) or (transition to demo)
	LDA #$4C : BRA ++				;change tilemap address for BG2 to: single tilemap at $4800/$4C00
+ : LDA #$48 : ++ : STA $59
	INC $091B						;set BG2 X scroll to "BG data"
	REP #$20 : RTS
}
;-------------------------------------- FIREFLEA ---------------------------------------------------
{
FX_Fireflea:
	JSL $888435
	DB $00, $32 : DW Inst_Fireflea_Main		;direct, 1 register write once for color math designation
	JMP FX_BG2_Object_Effect


Inst_Fireflea_Main:
	DW $8655 : DB $88
	DW $864C : DW HDMA_IndirectTable_Empty
	DW $85B4 : DL PreInst_Fireflea
	DW $8570 : DL Fireflea_Main
	DW $8682


PreInst_Fireflea:
	PHP
	LDA $197C : STA $1778	;set timer
	STZ $177A : STZ $177E	;zero index, kill counter of firefleas
	LDA $1980 : BNE + : INC
+ : CMP #$0050 : BMI +		;limit amount of index if overrange
	LDA #$0050 : + : STA $1980 : STA $12

	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$001F : STA $00			;$00 = red component
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$03E0 : ASL #3 : STA $02	;$03 = green component
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$7C00 : LSR #2 : STA $05	;$06 = blue component

	STZ $01 : STZ $04 : STZ $07
	SEP #$30 : LDX #$00

;red
-- : LDA $02 : STA $7E9D00,x : LDA $01 : CLC : ADC $00
- : CMP $1980 : BMI + : SEC : SBC $1980 : INC $02 : BRA -
+ : STA $01 : INX
;green
	LDA $05 : STA $7E9D00,x : LDA $04 : CLC : ADC $03
- : CMP $1980 : BMI + : SEC : SBC $1980 : INC $05 : BRA -
+ : STA $04 : INX
;blue
	LDA $08 : STA $7E9D00,x : LDA $07 : CLC : ADC $06
- : CMP $1980 : BMI + : SEC : SBC $1980 : INC $08 : BRA -
+ : STA $07 : INX

	DEC $12 : BPL --
	PLP : LDA #$0000 : STA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : RTL


Fireflea_Main:
	LDA $0797 : BNE ++				;return if still in a door transition
	LDA $197E : BIT #$0020 : BNE +	;check if x-ray should disable effect
	LDA $0A78 : BNE ++				;return if time is frozen
+ : LDA $0592 : BEQ +++				;return if powerbomb is active
++ : RTL
+++ : PHP : DEC $1778 : BEQ + : PLP : RTL	;decrement timer
+ : LDA $197C : STA $1778					;set timer for next index
	LDA $177A : BMI ++						;branch to decrement index if current index is negative (MSB set)
	CMP $1980 : BPL + : INC $177A : BRA +++	;increment index if max index not reached
+ : ORA #$8000 : STA $177A					;set MSB for index decrement
++ : DEC $177A : BMI +++					;decrement index if not below 0
+ : LDA #$0001 : STA $177A					;set index to 1 for index increment

+++ : LDA $177A : ASL : CLC : ADC $177A : TAX	;offset = index * 3
	LDA $197E : BIT #$0010 : BEQ +
	LDA $0E50 : BRA ++				;number of enemies killed in current room
+ : LDA $177E : ++ : STA $28		;number of Firefleas only killed in current room
;Prepare color component math for red and green
	LDA $1978 : ASL #3 : STA $00 : STA $26	;$00/26 = red sub intensity ;$01 = green sub intensity
	LDA $197A : ASL #3 : STA $02			;$02 = red intensity addition ;$03 = green intensity addition
	STZ $04 : STZ $10
	SEP #$20
;red
	LSR #3 : STA $27				;red intensity
	JSL $A0B6FF						;(<color intesity addition> * <amount of enemy kills>) + <current color of fireflea cycle> = new component value
	LDA $2B : CLC : ADC $7E9D00,x : BIT #$E0 : BEQ +	;if component overrange, set to max intensity
	LDA #$1F : + : STA $10
;green
	LDA $01 : ASL #3 : STA $26		;green sub intensity
	LDA $03 : AND #$1F : STA $27	;green intensity
	JSL $A0B6FF
	LDA $2B : CLC : ADC $7E9D01,x : BIT #$E0 : BEQ +
	LDA #$1F : + : STA $04
;blue
	LDA $1979 : AND #$7C : ASL : STA $26	;blue sub intensity
	LDA $197B : LSR #2 : STA $27			;blue intensity
	JSL $A0B6FF
	LDA $2B : CLC : ADC $7E9D02,x : BIT #$E0 : BEQ +
	LDA #$1F : + : ASL #2 : TSB $11
;New color value
	REP #$20
	LDA $04 : ASL #5 : ORA $10 : STA.l (!ColorOptionPaletteIndex<<1)+$7EC000
	PLP : RTL
}
;$8B bytes left

ORG $88B279
;-------------------------------------- LIQUID -----------------------------------------------------
{
FX_LavaAcid:
	LDA.w #Func_Liquid_Heat_CheckRising : STA $196C
	LDA $1978 : STA $1962		;set lava/acid height
	BRA +
FX_Water:
	LDA.w #Func_Liquid_Water_CheckRising : STA $196C
	LDA $1978 : STA $195E		;set water height
+ : LDA $197E : BIT #$0022 : BEQ +			;check: FX effects are set for background
	JSL $888435
	DB $42, $0F : DW Inst_Liquid_BG2		;indirect, 1 register write twice for layer 2 screen X position
+ : JSL $888435
	DB $42, $11 : DW Inst_Liquid_BG3		;indirect, 1 register write twice for layer 3 screen X position

	LDX $196E : CPX #$0006 : BPL +			;if effect index is water and higher: don't spawn animated tiles
	LDA.l Type_Liquid_Animation_Pointer,x : TAY : JSL $878027	;spawn animated tiles

+ : LDA $197E : BIT #$0004 : BEQ +			;check: spawn window object set
	JSL $888435								;spawn HDMA object for window 1
	DB $41, $26 : DW Inst_ExternalObject	;indirect, 2 registers write once for window 1 position
	LDA #$0004 : TRB $197E					;uncheck "BG Liquid" to not disable water physic
;Check if specific PLM has spawned to disable water physic
+ : LDX #$004E
- : LDA $1C37,x : CMP.w #!DisableWaterPhysicPLM : BEQ + : DEX #2 : BPL - : RTL
+ : LDA #$0004 : TSB $197E : RTL			;disable water physic


Type_Liquid_Animation_Pointer:
	DW $824B, $82AB, $82C9, $824B


Inst_Liquid_BG2:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW PreInst_Liquid_PrepareVariables
	DW $8570 : DL Inst_Liquid_BG2_Main
	DW $8682

Inst_Liquid_BG3:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW PreInst_Liquid_PrepareVariables
	DW $8570 : DL Inst_Liquid_BG3_Main
	DW $8682


Func_Liquid_Heat_CheckRising:
	BIT $197D : BVS +		;"large tide" checked: return
	LDA $197C : BEQ +		;rising speed not zero?
	LDA $197A : CMP $1978 : BNE ++		;rising function: base Y = target Y ?
+ : RTS
;check to invert speed to reach target Y
++ : BMI +
	LDA $197C : BPL +++ : BRA ++
+ : LDA $197C : BMI +++
++ : EOR #$FFFF : INC : STA $197C		;invert rising speed
+++ : LDA.w #Func_Liquid_Heat_WaitForRising : STA $196C : RTS		;next function: wait for liquid rising

Func_Liquid_Heat_WaitForRising:
	JSR $B21D				;handle earthquake sound effect
	LDA #$0015 : STA $183E	;earthquake pixel display
	LDA #$0020 : TSB $1840	;earthquake timer
	DEC $1980 : BEQ + : RTS								;decrement timer
+ : LDA.w #Func_Liquid_Heat_Rising : STA $196C : RTS	;next function: rise liquid

Func_Liquid_Heat_Rising:
	JSR $B21D				;handle earthquake sound effect
	LDA #$0015 : STA $183E	;earthquake pixel display
	LDA #$0020 : TSB $1840	;earthquake timer
	JSR $868C : BCS + : RTS	;rising function routine
+ : STZ $197C : LDA.w #Func_Liquid_Heat_CheckRising : STA $196C : RTS ;zero speed and return to start routine


Func_Liquid_Water_CheckRising:
	BIT $197D : BVS +		;"large tide" checked: return
	LDA $197C : BEQ +		;rising speed not zero?
	LDA $197A : CMP $1978 : BNE ++		;rising function: base Y = target Y ?
+ : RTS
;check to invert speed to reach target Y
++ : BMI +
	LDA $197C : BPL +++ : BRA ++
+ : LDA $197C : BMI +++
++ : EOR #$FFFF : INC : STA $197C		;invert rising speed
+++ : LDA.w #Func_Liquid_Water_WaitForRising : STA $196C : RTS		;next function: wait for liquid rising

Func_Liquid_Water_WaitForRising:
	DEC $1980 : BEQ + : RTS								;decrement timer
+ : LDA.w #Func_Liquid_Water_Rising : STA $196C : RTS	;next function: rise liquid

Func_Liquid_Water_Rising:
	JSR $868C : BCS + : RTS	;rising function routine
+ : STZ $197C : LDA.w #Func_Liquid_Water_CheckRising : STA $196C : RTS	;zero speed and return to start routine


Func_Liquid_Tides:
	BIT $197D : BVS +++ : BMI ++ : RTS

;Small tides:
++ : LDA.w #!SmallTideSize : STA $26

	STZ $1970 : STZ $1972						;reset FX Y offset
	LDA $1975 : AND #$00FF : ASL : TAX			;sine wave offset
	LDA $A0B3C3,x : STA $28 : BPL + : DEC $1972
+ : JSL $A0B6FF
	LDA $2A : STA $1971

	LDA $1972 : BPL +
	LDA $1974 : CLC : ADC.w #!SmallTideRiseSpeed<<4 : STA $1974 : RTS		;upper tide speed (positive sine)
+ : LDA $1974 : CLC : ADC.w #!SmallTideFallSpeed<<4 : STA $1974 : RTS		;lower tide speed (negative sine)

;Large tides:
+++ : LDA $1980 : STA $26		;tide size

	STZ $1970 : STZ $1972	;reset FX Y offset
	LDA $1975 : AND #$00FF : ASL : TAX			;sine wave offset
	LDA $A0B3C3,x : STA $28 : BPL + : DEC $1972	;current sine value
+ : JSL $A0B6FF				;tide size * current sine value
	LDA $2A : STA $1971		;= FX Y offset (high byte: offset in pixel)

	LDA $1972 : BPL +		;prepare for next tide value
	LDA $197C : AND #$FF00 : LSR #4 : CLC : ADC $1974 : STA $1974 : RTS		;upper tide speed (positive sine)
+ : LDA $197C : AND #$00FF : ASL #4 : CLC : ADC $1974 : STA $1974 : RTS		;lower tide speed (negative sine)



PreInst_Liquid_PrepareVariables:
	LDA $197E : BIT #$0008 : BEQ +	;check: toggle heat effect set
	PHX : LDA $18C0,x : AND #$00FF : TAX : INC $4301,x : PLX		;change current HDMA destination register from screen X to Y position
+ : LDA $196E : CMP #$0002 : BNE +					;check: FX effect = lava
	LDA.w #!LavaBubblingSoundDelay : STA $1938,x	;set timer for lava bubbling sound
+ : LDA #$0001 : STA $1920,x : RTS					;set timer for water/heat effect



Inst_Liquid_BG3_Main:
	LDA $196E : CMP #$0006 : BPL Inst_Water_BG3_Branch		;check: FX effect = not lava or acid
	LDA.w #Inst_Lava_BG3_Main : STA $18F0,x
Inst_Lava_BG3_Main:
	LDA $0A78 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL		;disable effect if time is frozen
+ : PHX : PHY : REP #$30
	PEA.w .return-1 : JMP ($196C)
.return
	JSR Func_Liquid_Tides
	SEP #$10
	JSR Func_Liquid_Lava_SetHeight
	JSR Func_Liquid_Lava_BubblingSound
	JSR Func_Liquid_SetEffect
	JSR Func_Liquid_FlowSpeed
	JSR Func_Liquid_Lava_SetHDMA_TablePointer
	PLY : PLX : RTL

Inst_Water_BG3_Branch:
	LDA.w #Inst_Water_BG3_Main : STA $18F0,x
Inst_Water_BG3_Main:
	LDA $0A78 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL		;disable effect if time is frozen
+ : PHX : PHY : REP #$30
	PEA.w .return-1 : JMP ($196C)
.return
	JSR Func_Liquid_Tides
	SEP #$10
	JSR Func_Liquid_Water_SetHeight
	JSR Func_Liquid_SetEffect
	JSR Func_Liquid_FlowSpeed
	JSR Func_Liquid_Water_SetHDMA_TablePointer
	PLY : PLX : RTL


Func_Liquid_Lava_SetHeight:
;Set FX Y position
	LDA $1976 : CLC	: ADC $1970 : STA $1960		;calculate water Y subposition
	LDA $1978 : ADC $1972 : STA $1962			;calculate water Y position
;Set BG3 Y position for scenery
	LDA $1962 : BMI +		;disable if negative
++ : LDA $0915 : SEC : SBC $1962 : CLC : ADC #$0100 : BMI +
	CMP #$0120 : BMI ++ : AND #$011F : ORA #$0100 : BRA ++
+ : LDA #$0000 : ++ : STA $7ECADE : RTS


Func_Liquid_Water_SetHeight:
;Set FX Y position
	LDA $1976 : CLC	: ADC $1970 : STA $195C		;calculate water Y subposition
	LDA $1978 : ADC $1972 : STA $195E			;calculate water Y position
;Set BG3 Y position for scenery
	LDA $195E : BMI +							;disable if negative
++ : LDA $0915 : SEC : SBC $195E : CLC : ADC #$0100 : BMI +
	CMP #$0120 : BMI ++ : AND #$011F : ORA #$0100 : BRA ++
+ : LDA #$0000 : ++ : STA $7ECADE : RTS


Liquid_Lava_BubblingSoundTable:
	DB $12, $13, $14, $12, $13, $14, $12, $13

Func_Liquid_Lava_BubblingSound:
	LDX $18B2 : LDA $196E : CMP #$0002 : BNE +	;check: FX effect is lava
	LDA $1962 : BMI + : DEC $1938,x : BNE +		;check: liquid Y position negative, decrement timer
	LDA.w #!LavaBubblingSoundDelay : STA $1938,x;set timer
	LDA $05E5 : AND #$0007 : TAY				;prepare bubbling sound
	LDA.w Liquid_Lava_BubblingSoundTable,y : AND #$00FF : JSL $8090CB
	LDA $05E5 : XBA : STA $05E5					;exchange bytes of random number
+ : RTS


Func_Liquid_SetEffect:
	LDX $18B2 : LDA $192D,x : AND #$00FF : CLC : ADC $0911 : STA $7ECADC
	LDA $197E : BIT #$0010 : BNE + : RTS			;check: liquid effect set
Func_BG3_SetEffect:
+ : LDX $18B2 : LDA $197E : BIT #$0008 : BNE ++		;check: heat effect flag set

	DEC $1920,x : BNE +		;decrement timer
	LDA.w #!LiquidWaterEffectDelay : STA $1920,x	;set timer
	LDA $1914,x : INC #2 : AND #$001E : STA $1914,x	;increment offset
+ : LDA $1914,x : TAX : LDY #$1E
;Water effect in liquid
- : LDA.w Table_WaterFX_Offset,y : CLC : ADC $7ECADC : STA $7E9C20,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL -
	RTS

++ : DEC $1920,x : BNE +
	LDA.w #!LiquidHeatEffectDelay : STA $1920,x
	LDA $1914,x : INC #2 : AND #$001E : STA $1914,x
+ : LDA $1914,x : TAX : LDY #$1E
;Heat effect in liquid
- : LDA.w Table_HeatFX_Offset,y : CLC : ADC $7ECADE : STA $7E9C20,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL -
	RTS


Func_Liquid_FlowSpeed:
	LDX $18B2 : LDA $197E : BIT #$0001 : BEQ +++	;"flowing left" checked
	BIT #$0040 : BEQ +								;"large tide" checked for custom flow speed
	LDA $197A : BRA ++ : + : LDA.w #!LiquidHorizontalFlowSpeed	;left: vanilla speed ;right: custom speed
++ : CLC : ADC $192C,x : STA $192C,x
+++ : RTS


Func_Liquid_Lava_SetHDMA_TablePointer:
	LDA $197E : BIT #$0010 : BEQ ++ : LDA $0915 : SEC : SBC $1962 : BRA +	;check: liquid effect set ;else: disable effect
Func_Liquid_Water_SetHDMA_TablePointer:
	LDA $197E : BIT #$0010 : BEQ ++ : LDA $0915 : SEC : SBC $195E
+ : AND #$000F : STA $12 : ASL : CLC : ADC $12
	ADC.w #HDMA_IndirectTable_BG3_Scroll : STA $18D8,x : RTS
++ : LDA $85 : EOR $18B4,x : STA $85 : RTS		;disable BG3 liquid effect


Inst_Liquid_BG2_Main:
	LDA $196E : CMP #$0006 : BPL Inst_Water_BG2_Branch			;check: FX effect = not lava or acid
	LDA.w #Inst_Lava_BG2_Main : STA $18F0,x
Inst_Lava_BG2_Main:
	LDA $0A78 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL	;disable effect if time is frozen
+ : LDA $1962 : JSR Liquid_BG2_SetScreenOffset
;Set HDMA indirect pointer
	LDX $18B2 : LDA $1962 : BMI +++
	LDA $0915 : SEC : SBC $1962 : BRA ++

Inst_Water_BG2_Branch:
	LDA.w #Inst_Water_BG2_Main : STA $18F0,x
Inst_Water_BG2_Main:
	LDA $0A78 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL
+ : LDA $195E : JSR Liquid_BG2_SetScreenOffset
;Set HDMA indirect pointer
	LDX $18B2 : LDA $195E : BMI +++
	LDA $0915 : SEC : SBC $195E
++ : CLC : ADC #$0110 : BMI +++ : CMP #$0120 : BMI ++
	AND #$012F : ORA #$0100 : BRA ++
+++ : AND #$000F
++ : STA $12 : ASL : CLC : ADC $12
	ADC #HDMA_IndirectTable_BG2_Scroll : STA $18D8,x : RTL

Liquid_BG2_SetScreenOffset:
	PHP
	CLC : ADC $0919 : ASL : CLC : ADC $1914,x : AND #$001E : STA $12
	LDA $1914,x : STA $14

	SEP #$50 : LDA $197E : AND #$0008 : BNE + : CLV : +		;check: heat effect set
	DEC $1920,x : BNE +++		;decrement timer
	BVS + : LDA.w #!BackgroundWaterEffectDelay : BRA ++ : +	;set timer for water effect
	LDA.w #!BackgroundLavaEffectDelay : ++ : STA $1920,x	;set timer for heat effect
	LDA $1914,x : INC #2 : AND #$001E : STA $1914,x			;increment offset
+++ : LDX $12 : LDY #$1E : BVS +++
;Water effect outside liquid
	LDA $197E : BIT #$0020 : BEQ ++							;check: effect outside liquid set
- : LDA.w Table_WaterFX_Offset,y : CLC : ADC $B5 : STA $7E9C00,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL - : BRA +
++ : TYX : - : LDA $B5 : STA $7E9C00,x : DEX #2 : BPL -		;else: set line offset the same as BG2 position
;Water effect inside liquid
+ : LDX $14 : LDY #$1E : LDA $197E : BIT #$0002 : BEQ ++	;check: effect inside liquid set
- : LDA.w Table_WaterFX_Offset,y : CLC : ADC $B5 : STA $7E9C40,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL -
	PLP : RTS
++ : TYX : - : LDA $B5 : STA $7E9C40,x : DEX #2 : BPL -		;else: set line offset the same as BG2 position
	PLP : RTS
;Heat effect outside liquid
+++ : LDA $197E : BIT #$0020 : BEQ ++
- : LDA.w Table_HeatFX_Offset,y : CLC : ADC $B7 : STA $7E9C00,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL - : BRA +
++ : TYX : - : LDA $B7 : STA $7E9C00,x : DEX #2 : BPL -
;Heat effect inside liquid
+ : LDX $14 : LDY #$1E : LDA $197E : BIT #$0002 : BEQ ++
- : LDA.w Table_HeatFX_Offset,y : CLC : ADC $B7 : STA $7E9C40,x
	DEX #2 : BPL + : LDX #$1E : + : DEY #2 : BPL -
	PLP : RTS
++ : TYX : - : LDA $B7 : STA $7E9C40,x : DEX #2 : BPL -
	PLP : RTS
}
;-------------------------------------- INDIRECT TABLES --------------------------------------------
{
HDMA_IndirectTable_BG3_Scroll:
	!Counter = $11
	WHILE !Counter != $00
		!EffectCounter = $20
		!Counter #= !Counter-1
		WHILE !EffectCounter != $00
			!EffectCounter #= !EffectCounter-2
			DB $81 : DW $9C20+!EffectCounter
		ENDWHILE
	ENDWHILE
	DB $00


HDMA_IndirectTable_BG2_Scroll:
	!Counter = $11
	WHILE !Counter != $00
		!EffectCounter = $20
		!Counter #= !Counter-1
		WHILE !EffectCounter != $00
			!EffectCounter #= !EffectCounter-2
			DB $81 : DW $9C00+!EffectCounter
		ENDWHILE
	ENDWHILE
	!Counter = $11
	WHILE !Counter != $00
		!EffectCounter = $20
		!Counter #= !Counter-1
		WHILE !EffectCounter != $00
			!EffectCounter #= !EffectCounter-2
			DB $81 : DW $9C40+!EffectCounter
		ENDWHILE
	ENDWHILE
	DB $00


HDMA_IndirectTable_Object:
	!Counter = $0100
	WHILE !Counter != $0000
		!Counter #= !Counter-1
		DB $81 : DW $C606
	ENDWHILE

	!Counter = $0200
	WHILE !Counter != $0000
		!Counter #= !Counter-2
		DB $81 : DW $C406+!Counter
	ENDWHILE
	!Counter = $0000
	WHILE !Counter != $0200
		!Counter #= !Counter+2
		DB $81 : DW $C406+!Counter
	ENDWHILE
	DB $81 : DW $C606
HDMA_IndirectTable_Empty:
	DB $00
}
;-------------------------------------- OBJECT -----------------------------------------------------
{
FX_Object:
	JSL $888435							;spawn HDMA object for window 1
	DB $41, $26 : DW Inst_Object		;indirect, 2 registers write once for window 1 position
	JMP FX_BG2_Effect



Inst_ExternalObject:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW $85B4 : DL PreInst_ExternalObject
	DW $85EC, Inst_ObjectBranch
Inst_Object:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW $85B4 : DL PreInst_Object
Inst_ObjectBranch:
	DW $8570 : DL Inst_Object_Main
.restore
	DW $8682
	DW $85B4 : DL PreInst_EmptyHDMATable
	DW $85EC, .restore


;$1914: X offset
;$1920: Y offset
;$192C: scroll speed
;$1938: shape starting index
;$1944: power bomb flag
;$1950: bit options
PreInst_ExternalObject:
	LDA $7F6402+!BTSObjectIndex : AND #$000F : ASL #3 : TAY	;object data index
	LDA.w Table_Object_ExternalData,y : STA $1914,x			;X offset
	LDA.w Table_Object_ExternalData+2,y : STA $1920,x		;Y offset
	LDA.w Table_Object_ExternalData+4,y : STA $192C,x		;scroll speed
	LDA.w Table_Object_ExternalData+6,y : AND #$00FF : STA $12 : STA $14		;X/Y radius
	LDA.w #!ObjectDefaultLevelOfDetail&$007F : STA $16		;default level of detail

	LDA.w Table_Object_ExternalData+7,y : STA $1950,x : BIT #$0040 : BEQ +		;bit options, check: extended X size is set
	LDA #$0100 : STA $192C,x								;scroll speed
	LDA.w Table_Object_ExternalData+4,y : STA $12			;extended X radius
+ : LDA.w Table_Object_ExternalData+7,y : BIT #$0080 : BEQ ++					;check: extended Y size is set
	LDA #$0100 : STA $192C,x								;save scroll speed
	LDA.w Table_Object_ExternalData+4,y : STA $14			;extended Y radius
	LDA.w Table_Object_ExternalData+7,y : AND #$00C0 : EOR #$00C0 : BNE +		;check: both extended size are set
	LDA.w Table_Object_ExternalData+6,y : AND #$007F : STA $16	;change to custom level of detail
	BRA ++
PreInst_Object:
	LDA $1978 : STA $1914,x			;X offset
	LDA $197A : STA $1920,x			;Y offset
	LDA $197C : STA $192C,x			;scroll speed
	LDA $1980 : STA $12 : STA $14	;X/Y radius
	LDA.w #!ObjectDefaultLevelOfDetail&$007F : STA $16	;default level of detail

	LDA $197E : STA $1950,x : BIT #$0040 : BEQ +		;bit options, check: extended X size is set
	LDA #$0100 : STA $192C,x		;scroll speed
	LDA $197C : STA $12				;extended X radius
+ : LDA $197E : BIT #$0080 : BEQ ++						;check: extended Y size is set
	LDA #$0100 : STA $192C,x		;save scroll speed
	LDA $197C : STA $14				;extended Y radius
	LDA $197E : AND #$00C0 : EOR #$00C0 : BNE +			;check: both extended size are set
	LDA $1980 : AND #$007F : STA $16	;change to custom level of detail
{;Construct shape
++ : LDA $1950,x : BIT #$0030 : BNE +	;if no shape flag is set: prepare rectangle shape
	LDX #$0000 : LDA $12 : STA $7E9300,x				;X radius
	LDA $14 : STA $7E9402,x : LDA #$FFFF : STA $7E9404,x;Y radius + terminator
	JMP PreInst_EmptyHDMATable

+ : LDA #$0080 : STA $4204 : LDY $16 : INY : STY $4206	;Max level of detail / level of detail value + 1 = amount of index for drawing shape
	LDA $1950,x : AND #$0030 : LSR #3 : TAY : LDA.w Pointer_Object_Type,y : TAY	;[Y] shape table pointer
	LDA $16 : INC : ASL : STA $1938,x : TAX				;[X] starting index of "indexed X/Y radius value table"
	LDA #$FFFF : STA $7E9404,x							;terminator of Y radius table
	STZ $1C : REP #$10
	LDA $4214 : STA $18			;result
	LDA $4216 : STA $1A			;remainder
}
{;Loop: Prepare shape values
;X lenght of current shape position * size multiplier
- : LDA $0000,y : AND #$00FF : STA $26 : LDA $12 : STA $28
	JSL $A0B6FF
	LDA $2B : STA $7E9300,x		;width value of current shape position in pixel
;Y lenght of current shape position * size multiplier
	LDA $0080,y : AND #$00FF : STA $26 : LDA $14 : STA $28
	JSL $A0B6FF
	LDA $2B : STA $7E9402,x		;height value of current shape position in pixel
;get next X index of shape
	LDA $1C : CLC : ADC $1A : STA $1C	;add remainder value
	CMP $16 : BMI +						;if sum over divider:
	SEC : SBC $16 : STA $1C : DEY		;subtract divider, decrement Y index
+ : TYA : SEC : SBC $18 : TAY			;subtract Y index by "result"
	DEX #2 : BPL -				;loop
}
;Prepare table for window 1 in power bomb explosion HDMA table
PreInst_EmptyHDMATable:
	PHB : LDA #$00FF : STA $7EC406
	LDA #$01FF : LDX #$C406 : LDY #$C408
	MVN.w $7E7E : PLB : RTL

Pointer_Object_Type:
	DW $0000, ObjectShape_Rhombus_Height, ObjectShape_Circle_Height, ObjectShape_Star_Height


;check: power bomb still active
- : LDA $0592 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL
+ : STA $1944,x
	LDA #$0001 : STA $18E4,x		;next instruction
	INC $18CC,x : INC $18CC,x : STZ $1908,x : BRA ++
Inst_Object_Main:
;data table to form object from other effects using BTS as index
	LDA $1944,x : BMI -		;check: power bomb in effect
	LDA $0A78 : BNE + : LDA $0592 : BEQ ++ : STA $1944,x	;time is frozen/power bomb activated:
+ : LDA $85 : EOR $18B4,x : STA $85 : RTL					;disable effect
++ : PHP : REP #$30

	LDA $1950,x : BIT #$0004 : BEQ +	;check, apply color in window
	JSR SetColorMath					;set color math
+ : STZ $18
	LDA $192C,x : STA $10		;speed multiplier
	LDA $1914,x : STA $22		;X offset
	LDA $1920,x : STA $24		;Y offset
	LDA $1950,x : LSR : BCS +	;check: "follow samus" set

	LDA $0911 : EOR #$FFFF : INC : STA $12			;inverted screen X position
	LDA $0915 : EOR #$FFFF : INC : STA $14 : BRA ++	;inverted screen Y position
+ : LDA $0B04 : STA $12						;samus's screen X position
	LDA $0AFA : SEC : SBC $0915 : STA $14	;samus's screen Y position
++ : JSR Inst_ScrollCalculation_BothAxis

	PHB : PEA.w $7E7E : PLB : PLB	;bank: $7E
	JSR Object_GetHDMATableIndex
;Set offset for indirect HDMA object table
	LDA #$0200 : SEC : SBC $14 : BMI ++ : CMP #$0300 : BMI + : ++ : LDA #$0300
+ : STA $14 : ASL : CLC : ADC $14 : ADC.w #HDMA_IndirectTable_Object : STA $18D8,x

	LDA $1938,x : INC #2 : STA $16 : LDY #$0000	;$16 = index amount
	LDA $18 : BEQ +++ : BRA $02		;altered table index?
- : INY #2 : CMP $9402,y : BMI -	;get index of nearest height value
	SEC : SBC $9402,y : STA $18 : DEY #2 : LDX #$01FE : BRA .drawLoop

;get [X] index for HDMA table from highest object value
+++ : LDA $9402,y : ASL : TAX : CPX #$0200 : BMI .nextRow : LDX #$01FE
.nextRow : LDA $9402,y : SEC : SBC $9404,y : STA $18
.drawLoop : DEC $18 : BMI +++
	LDA $12 : SEC : SBC $9300,y : BPL + : LDA #$0000 : + : CMP #$0100 : BPL ++ : STA $1A							;get left window position
	LDA $12 : CLC : ADC $9300,y : BMI ++ : CMP #$0100 : BMI + : LDA #$00FF : + : STA $1B : LDA $1A : BRA .saveRow	;get right window position
++ : LDA #$00FF		;empty window position
.saveRow : STA $C406,x : DEX #2 : BMI ++ : DEC $18 : BPL .saveRow	;set window position and loop
+++ : INY #2 : CPY $16 : BMI .nextRow
++ : PLB : PLP : RTL

Object_GetHDMATableIndex:
;$14 = screen Y position offset in relation to object center position
;$18 = draw height index
	LDA $9402 : CMP #$0100 : BMI +++		;check: object smaller than $0100 -> return
	LDA $14 : BMI + : CMP #$0100 : BPL ++	;screen near object center?
	LDA #$0100 : STA $18 : RTS				;set $18 near object center
;If screen in lower object half:
+ : EOR #$FFFF : CLC : ADC #$0101 : CMP $9402 : BPL +	;check: screen position outside object
	STA $18 : STZ $14 : RTS								;adjust $18, $14 offset below object center
+ : SEC : SBC $9402 : EOR #$FFFF : INC : STA $14 : RTS	;adjust offset in relation to object height
;If screen in upper object half:
++ : CMP $9402 : BPL +								;check: screen position outside object
	STA $18 : LDA #$0100 : STA $14 : RTS			;adjust $18, $14 offset above object center
+ : SEC : SBC $9402 : CLC : ADC #$0100 : STA $14	;adjust offset in relation to object height
+++ : RTS


ObjectShape_Rhombus_Width:
	DB $00, $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C, $1E
	DB $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C, $3E
	DB $40, $42, $44, $46, $48, $4A, $4C, $4E, $50, $52, $54, $56, $58, $5A, $5C, $5E
	DB $60, $62, $64, $66, $68, $6A, $6C, $6E, $70, $72, $74, $76, $78, $7A, $7C, $7E
	DB $7F, $80, $82, $84, $86, $88, $8A, $8C, $8E, $90, $92, $94, $96, $98, $9A, $9C
	DB $9E, $A0, $A2, $A4, $A6, $A8, $AA, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BC
	DB $BE, $C0, $C2, $C4, $C6, $C8, $CA, $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DC
	DB $DE, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8, $FA, $FC
ObjectShape_Rhombus_Height:
	DB $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $EC, $EA, $E8, $E6, $E4, $E2, $E0
	DB $DE, $DC, $DA, $D8, $D6, $D4, $D2, $D0, $CE, $CC, $CA, $C8, $C6, $C4, $C2, $C0
	DB $BE, $BC, $BA, $B8, $B6, $B4, $B2, $B0, $AE, $AC, $AA, $A8, $A6, $A4, $A2, $A0
	DB $9E, $9C, $9A, $98, $96, $94, $92, $90, $8E, $8C, $8A, $88, $86, $84, $82, $80
	DB $7F, $7E, $7C, $7A, $78, $76, $74, $72, $70, $6E, $6C, $6A, $68, $66, $64, $62
	DB $60, $5E, $5C, $5A, $58, $56, $54, $52, $50, $4E, $4C, $4A, $48, $46, $44, $42
	DB $40, $3E, $3C, $3A, $38, $36, $34, $32, $30, $2E, $2C, $2A, $28, $26, $24, $22
	DB $20, $1E, $1C, $1A, $18, $16, $14, $12, $10, $0E, $0C, $0A, $08, $06, $04, $02
	DB $00

ObjectShape_Circle_Width:
	DB $0F, $1B, $22, $29, $2F, $34, $38, $3C, $40, $44, $47, $4B, $4E, $51, $54, $57
	DB $59, $5C, $5E, $61, $63, $66, $68, $6A, $6C, $6E, $70, $74, $76, $78, $7A, $7C
	DB $7F, $81, $83, $84, $86, $87, $89, $8B, $8C, $8E, $90, $92, $93, $95, $96, $98
	DB $99, $9B, $9D, $9E, $A0, $A2, $A3, $A4, $A6, $A7, $A9, $AA, $AC, $AE, $B0, $B2
	DB $B4, $B6, $B8, $BA, $BC, $BE, $BF, $C0, $C1, $C3, $C4, $C5, $C6, $C8, $C9, $CA
	DB $CC, $CD, $CE, $CF, $D0, $D1, $D2, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC
	DB $DD, $DF, $E0, $E1, $E2, $E3, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE
	DB $EF, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD, $FE
ObjectShape_Circle_Height:
	DB $FF, $FE, $FD, $FC, $FB, $FA, $F9, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F0
	DB $EF, $EE, $ED, $EC, $EB, $EA, $E9, $E8, $E7, $E6, $E5, $E3, $E2, $E1, $E0, $DF
	DB $DD, $DC, $DB, $DA, $D9, $D8, $D7, $D6, $D5, $D4, $D2, $D1, $D0, $CF, $CE, $CD
	DB $CC, $CA, $C9, $C8, $C6, $C5, $C4, $C3, $C1, $C0, $BF, $BE, $BC, $BA, $B8, $B6
	DB $B4, $B2, $B0, $AE, $AC, $AA, $A9, $A7, $A6, $A4, $A3, $A2, $A0, $9E, $9D, $9B
	DB $99, $98, $96, $95, $93, $92, $90, $8E, $8C, $8B, $89, $87, $86, $84, $83, $81
	DB $7F, $7C, $7A, $78, $76, $74, $70, $6E, $6C, $6A, $68, $66, $63, $61, $5E, $5C
	DB $59, $57, $54, $51, $4E, $4B, $47, $44, $40, $3C, $38, $34, $2F, $29, $22, $1B
	DB $0F

ObjectShape_Star_Width:
	DB $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	DB $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1C, $1D, $1E, $1F, $20
	DB $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2D, $2E, $2F, $30, $31, $32
	DB $33, $35, $36, $37, $39, $3A, $3B, $3C, $3E, $3F, $40, $41, $43, $45, $47, $49
	DB $4B, $4D, $4F, $51, $53, $55, $57, $58, $59, $5B, $5C, $5E, $5F, $61, $63, $64
	DB $66, $68, $69, $6B, $6C, $6E, $6F, $72, $73, $75, $77, $78, $7A, $7B, $7D, $7F
	DB $80, $83, $86, $88, $8A, $8D, $90, $92, $94, $96, $98, $9B, $9D, $A0, $A2, $A5
	DB $A7, $AA, $AD, $B0, $B3, $B7, $BA, $BE, $C2, $C6, $CA, $CF, $D5, $DC, $E3, $EF
ObjectShape_Star_Height:
	DB $FF, $EF, $E3, $DC, $D5, $CF, $CA, $C6, $C2, $BE, $BA, $B7, $B3, $B0, $AD, $AA
	DB $A7, $A5, $A2, $A0, $9D, $9B, $98, $96, $94, $92, $90, $8D, $8A, $88, $86, $83
	DB $80, $7F, $7D, $7B, $7A, $78, $77, $75, $73, $72, $6F, $6E, $6C, $6B, $69, $68
	DB $66, $64, $63, $61, $5F, $5E, $5C, $5B, $59, $58, $57, $55, $53, $51, $4F, $4D
	DB $4B, $49, $47, $45, $43, $41, $40, $3F, $3E, $3C, $3B, $3A, $39, $37, $36, $35
	DB $33, $32, $31, $30, $2F, $2E, $2D, $2B, $2A, $29, $28, $27, $26, $25, $24, $23
	DB $22, $20, $1F, $1E, $1D, $1C, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11
	DB $10, $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01
	DB $00
}
;$7AE bytes left

ORG $88D950
;-------------------------------------- BG3 EFFECT -------------------------------------------------
{
FX_BG3Effect:
	PHB : PHK : PLB
	SEP #$20 : LDA #$5C : STA $5B : REP #$20	;set BG3 tilemap base adress/size to $5C00/32x32
	JSL $888435
	DB $42, $11 : DW Inst_BG3Effect				;indirect, 1 register write twice for layer 3 screen X position

	LDA $196E : SEC : SBC #$0008 : TAY
	LDA.w Table_BG3Effect_TileMapPointer,y : STA $1964		;get pointer for tilemap
	LDA.w Table_BG3Effect_AnimatedTilePointer,y : BEQ +		;get pointer for animated tiles, if zero: return
	TAY : JSL $878027	;spawn animated tile object
+ : PLB : JMP FX_BG2_Object_Effect

Table_BG3Effect_TileMapPointer:
	DW $98C0, $A100, $A940, $B180
	DW $B9C0, $C200, $CA40, $D280
	DW $DAC0, $E300, $EB40, $F380


Inst_BG3Effect:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW $864C : DW HDMA_IndirectTable_Empty
	DW PreInst_Liquid_PrepareVariables
	DW PreInst_BG3_PositionOffsetOption
	DW $8570 : DL PreInst_BG3Effect
	DW $8682


PreInst_BG3_PositionOffsetOption:
	LDA $197E : BIT #$0020 : BEQ +	;check: change X/Y scrolling to subpixel position values
	LDA $1978 : XBA : STA $192C,x
	LDA $197A : XBA : STA $1938,x
+ : RTS

PreInst_BG3Effect:
	LDA $0A78 : BEQ + : RTL		;return if time is frozen
+ : LDA $197C : STA $10
	LDA $192D,x : STA $22
	LDA $1939,x : STA $24
	LDA $197E : LSR : BCS +		;check: follow samus set
;Set values depending on BG2 screen position
	LDA $0911 : STA $12
	LDA $0915 : STA $14 : BRA ++
;Set values depending on samus's position
+ : LDA $0B04 : EOR #$FFFF : INC : STA $12
	LDA $0915 : SEC : SBC $0AFA : STA $14

++ : STZ $1972 : LDA $197E : BIT #$00C0 : BEQ +					;check if any tide flags are set
	PHP : REP #$30 : JSR Func_Liquid_Tides : LDX $18B2 : PLP	;calculate offset of FX height if tides are set
	BIT $197D : BVC + : LDA #$0100 : STA $10					;set 1:1 scroll speed if custom tides is set
+ : JSR Inst_ScrollCalculation_BothAxis
++ : LDA $1972 : STA $24 : STZ $22					;set tide offset for Y axis
	BIT $197D : BVC + : BPL + : STA $22 : STZ $24	;swap to X axis tides if both tide flags are set
+ : LDA $12 : CLC : ADC $22 : AND #$00FF : STA $7ECADC
	LDA $14 : CLC : ADC $24 : AND #$00FF : STA $7ECADE
	LDA $197E : BIT #$0020 : BNE ++
	LDA $192C,x : CLC : ADC $1978 : STA $192C,x
	LDA $1938,x : CLC : ADC $197A : STA $1938,x

++ : LDA $197E : BIT #$0010 : BNE + : RTL		;return if liquid effect not set
+ : JSR Func_BG3_SetEffect
	LDX $18B2 : LDA $0915 : AND #$000F : STA $12
	ASL : CLC : ADC $12 : ADC #HDMA_IndirectTable_BG3_Scroll : STA $18D8,x : RTL
}
;$109 bytes left

ORG $88DD32
;-------------------------------------- HAZE -------------------------------------------------------
{
Inst_Haze_RedComp:
	DW $8655 : DB $7E
	DW $8570 : DL PreInst_Haze_RedComp
	DW $8682

Inst_Haze_GreenComp:
	DW $8655 : DB $7E
	DW $8570 : DL PreInst_Haze_GreenComp
	DW $8682

Inst_Haze_BlueComp:
	DW $8655 : DB $7E
	DW $8570 : DL PreInst_Haze_BlueComp
	DW $8682

;Control haze fading in/out when entering/leaving a room
Haze_Fading:
	PHP : PHX : SEP #$20
	STA $1914,x : ORA $1921,x : STA $12	;set current color intensity
	BIT $197B : BPL .fadePlus	;haze direction (positive = color from bottom; negative = color from top)

	LDA $1920,x : INC : TAX		;set index
	LDA $12 : STA $7E9D00,x
- : STA $7E9D02,x : BIT #$1F : BEQ + : DEC
+ : INX #2 : CMP $7E9D02,x : BNE -
	PLX : PLP : RTS

.fadePlus
	LDA $192C,x : INC #2 : ASL : DEC : CLC : ADC $1920,x : TAX	;set index
	LDA $12 : STA $7E9D02,x
- : STA $7E9D00,x : BIT #$1F : BEQ + : DEC
+ : DEX #2 : CMP $7E9D00,x : BNE -
	PLX : PLP : RTS


Haze_GetBlueIntesity:
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC000 : AND #$7C00 : LSR #2 : XBA : RTS
Haze_GetGreenIntesity:
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC000 : AND #$03E0 : ASL #3 : XBA : RTS
Haze_GetRedIntesity:
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC000 : AND #$001F : RTS
;2 bytes left!


ORG $88DDC7
;Set up haze called by setup ASM
	LDA #$0040 : STA $1978	;set haze starting position
	LDA #$0070 : STA $197A	;set haze size
	STZ $197C				;zero haze scroll speed
	LDA #$0014 : STA $1982	;set FX A to color mode

	LDA #$0001 : JSL $8081DC : BCS +		;check if main boss in current area is dead
	LDA #$3C00 : BRA ++ : + : LDA #$000F	;set intensity (ridley alive: blue; ridley dead: red)
++ : STA.l (!ColorOptionPaletteIndex<<1)+$7EC200
;Spawn haze HDMA object if the color component of the color option is not zero
FX_Haze:
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$001F : BEQ + : JSL $888435
	DB $00, $32 : DW Inst_Haze_RedComp		;direct, 1 register write once for color math designation
+ : LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$03E0 : BEQ + : JSL $888435
	DB $00, $32 : DW Inst_Haze_GreenComp
+ : LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$7C00 : BEQ + : JSL $888435
	DB $00, $32 : DW Inst_Haze_BlueComp
+ : JMP FX_BG2_Object_Effect


;Set up bomb torizo haze
Haze_BombTorizoSetup:
	LDA #$0048 : STA $1978	;set haze starting position
	LDA #$0096 : STA $197A	;set haze size
	STZ $197C				;zero haze scroll speed
	LDA #$20A5 : STA.l (!ColorOptionPaletteIndex<<1)+$7EC200	;set torizo haze color
	LDA #$0014 : STA $1982	;set FX A to color mode
	JMP FX_Haze



Haze_SetHDMA_TablePointer:
	PHP : REP #$30 : PHX
	CPX #$0000 : BNE + : STZ $1972 : JSR Func_Liquid_Tides : LDX $18B2	;calculate offset of FX height if tides are set
+ : STZ $14 : LDA $1920,x : AND #$00FF : TAX			;[X] = haze color component offset
;check: scroll haze through X direction set
	LDA $197E : LSR : BCS + : LDA $0915 : BRA ++
+ : LDA $0911 : ++ : STA $14

	LDA $1978 : STA $24
	LDA $197E : BIT #$0010 : BEQ +		;check: force scroll to zero set
	LDA #$0000 : BRA ++
+ : LDA $197C : EOR #$FFFF : INC : BIT $197D : BVC ++	;adjust scroll speed depending on small tide flag
	LDA #$FF00 : ++ : STA $10
	JSR Haze_SetLineOffset
;copy unmodified offset data to reset to previous changes
	REP #$30 : INX : STX $12
	PHB : LDA #$9E00 : ORA $12 : TAX
	LDA #$9D00 : ORA $12 : TAY : LDA #$000F : MVN $7E7E
	PLB : PLX : PLP
	LDA $12 : DEC : ORA #$9D00 : STA $18D8,x : RTS		;set table pointer for haze color component


Haze_SetLineOffset:
	JSR Inst_ScrollCalculation_Y_Axis	;calculate haze position
	CLC : ADC $1972 : BEQ + : BPL +++	;check: haze below/on screen

+ : STA $18 : LDA $197A : BMI + : EOR #$FFFF : INC		;compare with full haze size
+ : CMP $18 : BMI + : STX $12							;check if fully in haze
	LDX $18B2 : LDA $192C,x : INC : ASL : CLC : ADC $12 : TAX : RTS		;set offset and return if haze above offscreen

+ : INX #2
- : INX #2 : LDA $7E9E00,x : AND #$00FF : CLC : ADC $18 : STA $18 : BMI -	;calculate new offset
	BEQ + : SEP #$20 : STA $7E9D00,x : RTS				;set new offset, return
+ : INX #2 : RTS

+++ : CMP #$0100 : BPL +++			;return if haze offscreen
	SEP #$20 : BIT #$80 : BEQ +		;haze partly on screen
	AND #$7F : BEQ ++ : STA $7E9D00,x : BRA +++
+ : STA $7E9D02,x
++ : INX #2
+++ : RTS
}
;$14 bytes left

ORG $88A817
;-------------------------------------- MISC -------------------------------------------------------
;Various routines, from haze code follow up to small routines
{
Haze_Transfer_FullColorRange:
	PHP : PHX : SEP #$20
	LDA $192C,x : INC #3 : STA $12
	LDA $1920,x : TAX
- : LDA $7E9D01,x : STA $7E9E01,x : INX #2 : DEC $12 : BPL -
	PLX : PLP : RTS


;$1914 : current color intensity
;$1920/1 : RAM pointer offset ($7E9D00) / color component
;$192C : max color intensity
;$1938 : pointer to get intensity of current color component
PreInst_Haze_BlueComp:
	LDA #$80A0 : STA $1920,x	;high byte: color transparency ;low byte: indirect HDMA table RAM pointer offset
	LDA #Haze_GetBlueIntesity : STA $1938,x
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$7C00 : LSR #2 : XBA : BRA PreInst_Haze_MergeComp
PreInst_Haze_GreenComp:
	LDA #$4050 : STA $1920,x
	LDA #Haze_GetGreenIntesity : STA $1938,x
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$03E0 : ASL #3 : XBA : BRA PreInst_Haze_MergeComp
PreInst_Haze_RedComp:
	LDA #$2000 : STA $1920,x
	LDA #Haze_GetRedIntesity : STA $1938,x
	LDA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : AND #$001F

PreInst_Haze_MergeComp:
	STA $192C,x									;save max color gradiant
+ : LDA.w #PreInst_Haze_FadingIn : STA $18F0,x	;set new pre-instruction pointer

	LDA $197A : BPL + : EOR #$FFFF : INC : + : STA $4204	;check if haze size is negative
	LDA $192C,x : STA $1A : TAY : STY $4206					;haze size / max color gradiant
	LDA $192C,x : STA $10 : STA $12

	PHX : PHB
	LDA $1920,x : TAX : STZ $1C
	AND #$FF00 : STA $18

	LDA $4214 : STA $14
	LDA $4216 : STA $16
;prepare indirect HDMA table with all offsets in $7E9E00:
	LDA #$0080 : ORA $18 : STA $7E9E00,x : INX #2 : BRA ++

- : LDA $1C : CLC : ADC $16 : STA $1C
	CMP $1A : BPL +
	LDA $14 : BRA ++
+ : SEC : SBC $1A : STA $1C
	LDA $14 : INC
++ : ORA $18 : STA $7E9E00,x
	INX #2 : DEC $12 : BPL -
	STA $7E9E00,x : INX #2 : LDA #$0000 : STA $7E9E00,x

;transfer table to $7E9D00:
	REP #$30
	TXA : ORA #$9E00 : TAX : EOR #$0300 : TAY
	LDA $10 : INC #3 : ASL : MVP $7E7E
	SEP #$10 : PLB : PLX

	JSR Haze_SetHDMA_TablePointer

PreInst_Haze_FadingIn:
	LDA $1914,x : CMP $192C,x : BMI PreInst_Haze_Fading		;check: current intensity is same as max intensity
	LDA.w #PreInst_Haze_Update : STA $18F0,x
	JSR Haze_Transfer_FullColorRange

PreInst_Haze_Update:
	LDA $197E : BIT #$0020 : BNE +	;check if haze should disable effect
	LDA $0A78 : BNE ++				;disable effect if time is frozen
+ : LDA $0592 : BEQ +++				;disable effect if powerbomb is active
++ : LDA $85 : EOR $18B4,x : STA $85 : RTL

+++ : JSR Haze_SetHDMA_TablePointer
	LDA $099C : CMP #$E2DB : BEQ + : RTL			;check if in door transition fading out state
+ : LDA.w #PreInst_Haze_Fading : STA $18F0,x

PreInst_Haze_Fading:
	JSR ($1938,x) : JSR Haze_Fading : RTL			;get current intensity and update haze



FX_BG2_Object_Effect:
	LDA $197E : BIT #$0004 : BEQ +		;check: spawn object set
	JSL $888435
	DB $41, $26 : DW Inst_ExternalObject;indirect, 2 registers write once for window 1 position
FX_BG2_Effect:
+ : LDA $197E : BIT #$0002 : BEQ +		;check: BG effect set
	JSL $888435
	DB $42, $0F : DW Inst_BG2Effect		;indirect, 1 register write twice for layer 2 screen X position
+ : RTL


Inst_BG2Effect:
	DW $8655 : DB $88
	DW $866A : DB $7E
	DW PreInst_Liquid_PrepareVariables
	DW $8570 : DL Inst_None_BG2_Main
	DW $8682


Inst_None_BG2_Main:
	LDA $0A78 : BEQ + : LDA $85 : EOR $18B4,x : STA $85 : RTL	;disable effect if time is frozen
+ : LDA #$0000 : JSR Liquid_BG2_SetScreenOffset
;Set HDMA indirect pointer
	LDX $18B2 : LDA $0915 : AND #$000F : ADC #$0110 : STA $12
	ASL : CLC : ADC $12 : ADC #HDMA_IndirectTable_BG2_Scroll : STA $18D8,x : RTL

;$10: scroll speed multiplier
;$12: X position of screen or samus
;$14: Y position of screen or samus
;$22: X position offset
;$24: Y position offset
Inst_ScrollCalculation_BothAxis:
	LDA $10 : BPL + : EOR #$FFFF : INC : + : STA $26
	LDA $12 : STA $28 : JSL $A0B6FF
	LDA $10 : BMI +
	LDA $22 : CLC : ADC $2B : STA $12 : BRA Inst_ScrollCalculation_Y_Axis
+ : LDA $22 : SEC : SBC $2B : STA $12
Inst_ScrollCalculation_Y_Axis:
	LDA $10 : BPL + : EOR #$FFFF : INC : + : STA $26
	LDA $14 : STA $28 : JSL $A0B6FF
	LDA $10 : BMI +
	LDA $24 : CLC : ADC $2B : STA $14 : RTS
+ : LDA $24 : SEC : SBC $2B : STA $14 : RTS


SpawnHUD_HDMA_ObjectHijack:
	JSL $888288	;enable HDMA objects
	JSL $88D865	;spawn HUD HDMA object
	RTL
}
WARNPC $88AA20
}

;---------------------------------------------------------------------------------------------------
;|x|                                    MISC.                                                    |x|
;---------------------------------------------------------------------------------------------------
{
;---------------------------------------BANK $82----------------------------------------------------

;Hijack "enable HDMA objects" in loading game data routine to spawn BG3 scroll HDMA object for HUD
ORG $82809C : JSL SpawnHUD_HDMA_ObjectHijack

ORG $828925 : LDA #$0049		;fix demo code for crateria sky changing BG2 tilemap base size
;Remove RAM clearing of $7E9C00 - $7E9FFF during door transition (RAM location used by HDMA tables)
ORG $82E6D7 : BNE +
ORG $82E6E6 : BRA + : PADBYTE $FF : PAD $82E6FF : +


;---------------------------------------BANK $83----------------------------------------------------

;Tilemap pointer
ORG $83ABF0
	DW $0000, $8000, $8840, $9080	;$00: None, $02: Lava, $04: Acid, $06: Water
	DW $98C0, $A100, $A940, $B180	;remaining pointers are BG3 tilemape pointers
	DW $B9C0, $C200, $CA40, $D280
	DW $DAC0, $E300, $EB40, $F380

;Function pointer
ORG $83AC18
	DW FX_BG2_Effect, FX_LavaAcid, FX_LavaAcid, FX_Water
	DW FX_BG3Effect, FX_BG3Effect, FX_BG3Effect, FX_BG3Effect
	DW FX_BG3Effect, FX_BG3Effect, FX_BG3Effect, FX_BG3Effect
	DW FX_BG3Effect, FX_BG3Effect, FX_BG3Effect, FX_BG3Effect
	DW $A7D8, FX_Object, FX_Fireflea, $DB8A	;$20: Scrolling Sky ;$22: Object ;$24: Fireflea ;$26 Tourian Entrance
	DW $D8DE, $D928, FX_Haze				;$28: Ceres Ridley ;$2A: Ceres Elevator ;$2C Haze


;---------------------------------------BANK $85----------------------------------------------------

;Adjust message box color math designation
ORG $85817D : STZ $70
IF !MessageBoxAdaptColorMath
	LDA #$04 : TRB $73 : BRA +	;disable color math only on BG3 (message box layer)
ELSE
	STZ $73 : LDA #$E0 : STA $2132 : BRA +	;set color math to zero
ENDIF
ORG $858190 : +

;This routine is optimized and changed from using HDMA channel 6 to 7, so multiple effects don't break when collecting items
;Sets up indirect HDMA table in RAM for message box opening/closing transition
ORG $858363
	LDA #$3000 : STA $7E3381 : LDA #$30FE : STA $7E3384
	LDA #$1242 : STA $4370
	LDA #$007E : STA $4374 : STA $4377
	LDA #$3380 : STA $4372 : STA $4375
	STZ $4378 : SEP #$20 : STZ $437A
	LDA #$FF : STA $7E3380 : LDA #$E1 : STA $7E3383 : LDA #$00 : STA $7E3386
	JSR $859B
	SEP #$20 : LDA #$80 : STA $420C : RTS		;enable HDMA channel 7
;revert HDMA channel 7 back to HUD HDMA
RestoreHDMA_PPUMessageBox:
	LDA #$1143 : STA $4370
	LDA #$D86F : STA $4372
	SEP #$20 : LDA #$88 : STA $4374 : RTS
;3 bytes left

ORG $85861C : JSR RestoreHDMA_PPUMessageBox
ORG $858651 : NOP #3	;remove "wait for lag frame"


;---------------------------------------BANK $89----------------------------------------------------

;Palette blend pointers changed for mother brain
ORG $89AB5E : LDA.l !PaletteBlendPointer,x
ORG $89AB66 : LDA.l !PaletteBlendPointer+2,x
ORG $89AB6E : LDA.l !PaletteBlendPointer+4,x

;Use $1968 as "FX header loaded" flag instead of unused "FX entry offset" value
ORG $89AB0D : STZ $1968
ORG $89AB93 : STX $1968
ORG $89ABB9 : STZ $1968

;Adjust setting FX colors to the palette
ORG $89ABFE
	BEQ +
IF !PaletteBlendUnevenIndex
	ASL
ELSE
	NOP
ENDIF
IF !PaletteBlendFullPaletteIndex
	ASL #2
ELSE
	NOP #2
ENDIF
	TAX						;check: color index zero
	LDA.l !PaletteBlendPointer-2,x : STA $7EC230		;set color index $18
	LDA.l !PaletteBlendPointer,x : STA $7EC232			;
	LDA.l !PaletteBlendPointer+2,x : STA $7EC234		;
	LDA.l !PaletteBlendPointer+4,x : STA $7EC236		;up to $1B
	BRA ++
+ : LDA #$0000 : STA.l (!ColorOptionPaletteIndex<<1)+$7EC200 : NOP		;zero palette used for color math
;Extra space from optimizating code in $89AC22:
++ : LDX $1966 : LDA $0009,x : AND #$00FF : BEQ + : STA $196E
	TAY : LDA $ABF0,y : STA $1964

;Extra space from optimizating code in $89AC54 for saving FX tiles/palette bits:
ORG $89AC54
+ : LDX $1966 : LDA $000D,x : BEQ +++ : STA $196A
IF !DisableXRayFromPaletteTable
	XBA : ENDIF
	AND #$FF00 : TSB $197E
	LDA $079F : ASL : TAY : LDA $AC46,y : STA $AF : LDY #$0000		;set pointer for palettes
-- : LSR $196A : BCS +
- : INY #2 : CPY #$0010 : BNE -- : BRA ++
+ : LDA ($AF),y : PHY : TAY : JSL $8DC4E9 : PLY : BRA -				;spawn palette FX object

++ : LDA $079F : ASL : TAY : LDA $AC56,y : STA $AF : LDY #$0000		;set pointer for animated tiles
-- : LSR $196A : BCS +
- : INY #2 : CPY #$0010 : BNE -- : BRA +++
+ : LDA ($AF),y : PHY : TAY : JSL $878027 : PLY : BRA -				;spawn animated tiles FX object
+++ : PLB : PLP : RTL
;$0E bytes left


;---------------------------------------BANK $8A----------------------------------------------------

;Fill acid and water first row of the tilemap with same tiles as other "air" tiles to remove uncolored line between air and liquid
ORG $8A8840
	DW $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E
	DW $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E
ORG $8A9080
	DW $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E
	DW $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E, $184E


;---------------------------------------BANK $91----------------------------------------------------

ORG $91CCC2 : AND #$00F8			;change masking for reading BG2 tiledata when x-ray showing blocks

ORG $91D0D6 : JSL XRayShowBlockCheckHijack
ORG $91D10E : AND #$00F8			;change masking for writing BG2 tiledata when x-ray showing blocks

;Remove fireflea FX check for disable x-ray
ORG $91D150 : NOP #8

ORG $91D176 : JSL XRayShowBlockCheckHijack
ORG $91D1A3 : JSL XRayShowBlockCheckHijack


ORG $91D283
	LDX #$2000 : LDA $197F : BIT.w #!DisableXRayFlag : BNE +	;check if FX flag is set to disable x-ray
	JSL $91D143 : BEQ + : LDX #$4000	;don't show blocks if fighting specific bosses or in specific rooms
+ : TXA : TSB $1986 : PLX : PLP : RTL

XRayShowBlockCheckHijack:
	LDA $197F : BIT.w #!DisableXRayFlag : BNE + : JSL $91D143 : RTL
+ : LDA #$0000 : RTL
;$0D bytes left


ORG $91D849		;handle visor palette, if room has no sublayer
	LDX $1982 : LDA.l ColorMathConfiguration,x : BIT #$0002 : BNE $48 : NOP


;---------------------------------------BANK $A3----------------------------------------------------

ORG $A38E73 : INC $177E : RTL	;increment fireflea killed counter
ORG $A38E95 : INC $177E : RTL	;increment fireflea killed counter


;---------------------------------------BANK $A9----------------------------------------------------

;Mother Brain sets PB to not use color math on BG1 and 2
ORG $A98D49 : LDA #$000E : STA $1984


;---------------------------------------BANK $AA----------------------------------------------------

ORG $AAC90F : JSL Haze_BombTorizoSetup		;change haze setup pointer for bomb torizo
}
