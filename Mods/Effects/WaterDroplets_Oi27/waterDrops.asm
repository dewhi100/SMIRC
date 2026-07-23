;Water Drops Projectile + Spawner
;---
;PLM loads gfx and acts as a spawner for water droplets
;	Room Argument FTXY
;
;   F = P0VV bits
;		P = Flag, process droplets offscreen in X coordinate
;		0 = Unused
;		V = Vram placement, 0-2 what row of scratch space to put the graphics. For compatibility with other stuff using scratch space.
;	T = Type of Droplet (see line 37)
;	X = X displacement on PLM block
;	Y = Y displacement on PLM block
;
; For example, #$0000 will spawn a flat-ceiling water drop on the upper left corner of the PLM
;              #$028F will spawn a stalactite water drop on the middle bottom of the PLM.
;              #$9100 will spawn a low-delay flat-ceiling water drop that processes offscreen on the upper left corner of the PLM, and load the graphics to the 2nd row of scratch space.
  
;droplet gfx use the common palette line

;also contains a bugfix for projectiles not clearing all their ram to 0 at setup

lorom

;!84Free = $84FE00 ;for plm code
;!86Free = $86F4A6 ;for projectile code
;!8DFree = $8D8967 ;for projectile spritemaps (default overwrites unused spritemaps)
;!AnyFree = $DF8000 ;for graphics

org !free84
print "water droplet PLM:: ", pc
DropletSpawner:
{
dw .setup, .inst
.inst
dw $86C1, .preinst ;set preinstruction
dw $86B4 ;sleep

.dropletTypes
;projectile argument, spawn delay
db $00, $80 ;ceiling slow      00
db $00, $40 ;ceiling fast      01
db $01, $C0 ;stalactite slow   02
db $01, $60 ;stalactite fast   03

.dropletGfxList
;graphics, graphic size
;projectile arg should match the order of this list.
..flatCeiling
dl DropletGraphics_flatCeiling : dw DropletGraphics_flatCeiling_end-DropletGraphics_flatCeiling
..stalactite
dl DropletGraphics_stalactite : dw DropletGraphics_stalactite_end-DropletGraphics_stalactite

.setup
{
;transfer graphics & populate delay for droplet type
;[Y] PLM index

;1D77 = spawning timer actual
;1E17 = spawning timer target
;DF0C = projectile argument
;DEBC = vram graphics offset
TDC
STA $1D77,y

LDA $1DC7,y : AND #$3000
ORA #$000A
XBA
TYX
STA $7EDEBC,x ;graphics offset
;note that the actual VRAM offset is measured as XX00
;but the enemy projectile tile offset is measured as 00XX
;the bytes are the same value but swapped around.

LDA $1DC7,y : AND #$0F00 : XBA
ASL : TAX
LDA .dropletTypes,x : TAX
AND #$FF00 : XBA : STA $1E17,y ;spawning delay
LDA $1DC7,y : ASL ;setup carry with negative flag
TXA : AND #$00FF : BCC +
	ORA #$8000 ;if plm got negative flag then pass it to spawned projectiles (preserve self offscreen)
+
TYX
STA $7EDF0C,x ;projectile arg
;[X] & [Y] are both the proj index
;Add plm index*2 to the starting delay.
;to desync them.
STY $12
LDA #$004E : SEC : SBC $12 : ASL : STA $1D77,y

;only the first of each droplet type should send its gfx
;xfer gfx if:
;THIS index is the FIRST of this PLM Header && the first that has this vram index.
LDA $1DC7,y : AND #$3000 : STA $14
STY $12
STZ $16 ;reserve 16 as highest PLM with this type.
LDX #$004E
-
	LDA $1C37,x : CMP $1C37,y : BNE ++ ;if plm type == this
		LDA $1DC7,x : AND #$3000 : CMP $14 : BNE ++ ;if vram == this
			STX $16 : BRA ..out
	++
DEX : DEX : BPL -
..out
LDA $16 : CMP $12 : BNE ..noXfer ; if THIS is not the highest index,no gfx.
JSR .xferGfx
..noXfer
RTS
}
.xferGfx
{
TDC
SEP #$20
	TYX
	LDA $7EDF0C,x          ;get projectile argument
	STA $4202
	LDA #$05 : STA $4203   ;hardware math to index the gfx table
	STZ $18
	LDA $1DC8,y : AND #$30 ;grab the vram offset while waiting for hardware math
	LSR #4
	STA $19                ;each graphics line is $100 VRAM addressing units so this conveniently works with no other indexing code.
REP #$20
LDX $4216 ;this result should never be larger than FF since its max is the size of dropletGfxList.
LDA .dropletGfxList,x : STA $12
INX
LDA .dropletGfxList,x : STA $13 ; a garbage byte goes into [$14] but thats fine
INX : INX
LDA .dropletGfxList,x : STA $16
;[12] = long ptr to graphics
;[16] = gfx size
;[18] = VRAM offset into scratch space (starts at $DA00/2)
LDX $0330
LDA $13 : STA $D3,x ;BB00 graphics source
LDA $12 : STA $D2,x
LDA $16 : STA $D0,x
LDA #$DA00/2 : CLC : ADC $18 : STA $D5,x
TXA			;X is still the VRAM stack pointer, transfer to A
CLC			
ADC #$0007  ;\-bc queued 1 xfers
TAX			;|
STX $0330  	;overwrite VRAM stack pointer to account for new table size
LDA #$0000	;
STA $D0,x	;Place the 0000 table terminator at the end of our entries
RTS
}
.preinst
{
;after [type] delay
;spawn [type] droplet projectile
LDA $1D77,x : INC : CMP $1E17,x : BMI +

	;spawn the proj and set its gfx index
	LDA $7EDF0C,x
	LDY #EnvDroplet
	JSL $868097
	TAY
	LDA $7EDEBC,x
	STA $19BB,y
	
	;move it into position
	JSL $848290
	LDA $1DC7,x : AND #$000F : CLC : ADC #$0003 : STA $14 ;account for Y radius
	LDA $1DC7,x : AND #$00F0
	LSR #4
	STA $12
	LDA $1C29 : ASL #4 : CLC : ADC $12 : STA $1A4B,y
	LDA $1C2B : ASL #4 : CLC : ADC $14 : STA $1A93,y
	
	TDC
+
STA $1D77,x
RTS
}
}

!free84 #= pc()

org $868077
JSR ProjectileRamInitialize
JMP $808C
warnpc $86808C
org $8680E1
JSR ProjectileRamInitialize
JMP $80F9
warnpc $8680F9

org !free86
ProjectileRamInitialize:
;[Y] projectile index
TDC
STA $19DF,y
STA $1A27,y
STA $1A4B,y
STA $1A6F,y
STA $1A93,y
STA $1AB7,y
STA $1ADB,y
STA $1AFF,y
STA $1B23,y
STA $1BFB,y
RTS

EnvDroplet:
{
;Properties:
;CKSL DDDD DDDD DDDD
;C = collide with Samus Projectiles
;K = do NOT die on contact with Samus/Projectiles
;S = disable collision with Samus
;L = set to high prority (else low priority)
;D = Damage (12 bits)
;    __________________________________ Initialisation AI
;   |       _____________________________ Pre-instruction
;   |      |                  ________________________ Instruction list
;   |      |                 |           ___________________ X radius
;   |      |                 |          |     ________________ Y radius
;   |      |                 |          |    |          _____________ Properties
;   |      |                 |          |    |         |      ________ Touch instruction list
;   |      |                 |          |    |         |     |       ___ Shot instruction list
;   |      |                 |          |    |         |     |      |
dw .setup, .preinst_nothing, .inst : db $04, $04 : dw $7000, $0000, $0000
.setup
{
;0 = ceiling
;1 = stalactite
;caller handles positioning
;and assumes all proj ram is initialized to 0
;[Y] = projectile index
LDA $1993 : ASL : TAX ;word index while also populate Carry with negative flag
TDC : ROL : STA $1A27,y ;roll negative flag into [A] and store to $1A27
LDA ..types,x : STA $1B47,y
RTS
..types
dw .inst_ceiling    ;00
dw .inst_stalactite ;01
}

.preinst
{
..falling
;909EA1 = Samus subacceleratioin in air   = $1C00 vanilla
;909EA7 = Samus whole acceleration in air = $0000 vanilla
;$1A27 = Flag, preserve self offscreen
;$1A6F = Y sub position
;$1ADB = Y sub velocity
;$1AFF = Y whole velocity
;$1B23 = Flag, follow liquid surface
LDA $1ADB,x : CLC : ADC $909EA1 : STA $1ADB,x
LDA $1AFF,x : ADC $909EA7 : CMP #$0003 : BMI +
	LDA #$0003 ;cap the speed
+
STA $1AFF,x
LDA $1A6F,x : CLC : ADC $1ADB,x : STA $1A6F,x
LDA $1A93,x : ADC $1AFF,x : STA $1A93,x

LDA $1A4B,x : PHA
LDA $1A93,x : CLC : ADC #$0004 : PHA : STA $18 ;store for liquid checks
JSL $A0BB70
;lands on tile types:
;slope & everything bigger than 8, except D
TXY
LDA $0DC4 : ASL : TAX
LDA $7F0002,x : AND #$F000
TYX
CMP #$D000 : BEQ +
CMP #$1000 : BEQ ..land
CMP #$8000 : BCS ..land
+
;also check if landed on a liquid surface
;liquids are FX types 2/4/6
LDA $196E : BEQ +
	CMP #$0008 : BPL +
		CMP #$0006 : BEQ ..water
		;else lava/acid
		LDA $18 : CMP $1962 : BMI +
		BRA ..land_onLava
		..water
		LDA $18 : CMP $195E : BMI +
		BRA ..land_onWater
		+
+
..nothing
RTS
..land
;wake instruction list
;and align with the block.
;no support for slopes
;would break if it travelled more than its radius in px/f
LDY #$0011
JSR ..landingSound
LDA $1A93,x : AND #$FFF0 : ORA #$000C : STA $1A93,x
...merge
INC $1B47,x
INC $1B47,x
TDC : INC : STA $1B8F,x
RTS
...onLava ;turn into smoke
;some good sfx for this were 
;34 (loud)
;53 (loud)
;5D (very quiet)
;5E (puff of air, pretty appropriate)
;
LDY #$005E
JSR ..landingSound
LDA #$0000 : STA $19BB,x ;clear tiles index to look at common smoke
LDA #.inst_smoke-2 : STA $1B47,x
BRA +
...onWater ;normal landing effect
LDY #$0011
JSR ..landingSound
+
INC $1B23,x ;should always start at zero by projectile init.
BRA ...merge

..landingSound
;play [Y] sfx if onscreen
;but always if the persistance is turned on
LDA $1A27,x : BNE +
	JSR $BD2A : BNE ++ ;returns 1 if the projectile is offscreen
	+
	TYA : JSL $8090CB ;lib2 sfx if onscreen
++
RTS

..landed
;if liquid surface flag was set then follow it
LDA $1B23,x : BEQ +
	LDA $196E : CMP #$0006 : BEQ ...water
	LDA $1962 : SEC : SBC #$0004 : STA $1A93,x
	BRA +
	...water
	LDA $195E : SEC : SBC #$0004 : STA $1A93,x
+
RTS

}
.rout
{
..deleteIfOffscreen
{
;input [X] proj index
;delete self if far offscreen in X
;Y should be unlimited so they can drop from tall cielings in big rooms
LDA $1A27,x : BNE ..out
LDA $0911 : CLC : ADC #$0080 : STA $12
LDA $1A4B,x : SEC : SBC $12 : BPL ++
	EOR #$FFFF : INC
++
CMP #$0100 : BMI +
	STZ $1997,x
	PLA ;terminate inst processing
+
..out
;if you wanted them to die when out of bounds this would be the place to do it.
RTS
}
}
.inst
{
..smoke ;when lands on acid or lava
;wish we had a TSsss scorch sound
dw $8161, .preinst_landed
dw $0004, EnvDropletSpritemaps_smoke_f0
dw $0004, EnvDropletSpritemaps_smoke_f1
dw $0004, EnvDropletSpritemaps_smoke_f2
dw $0008, EnvDropletSpritemaps_smoke_f3
dw $0008, EnvDropletSpritemaps_smoke_f4
dw $8154 ;delete
..ceiling
dw .rout_deleteIfOffscreen
dw $8161, .preinst_nothing
dw $0004, EnvDropletSpritemaps_ceiling_f0
dw $0004, EnvDropletSpritemaps_ceiling_f1
dw $0004, EnvDropletSpritemaps_ceiling_f2
dw $0004, EnvDropletSpritemaps_ceiling_f3
dw $8161, .preinst_falling
dw $0004, EnvDropletSpritemaps_ceiling_f4
dw $8159 ;sleep until hits ground by preinst
dw $8161, .preinst_landed
dw $0004, EnvDropletSpritemaps_ceiling_f5
dw $0004, EnvDropletSpritemaps_ceiling_f6
dw $0004, EnvDropletSpritemaps_ceiling_f7
dw $8154 ;delete
..stalactite
dw .rout_deleteIfOffscreen
dw $8161, .preinst_nothing
dw $000C, EnvDropletSpritemaps_stalactite_f0
dw $000C, EnvDropletSpritemaps_stalactite_f1
dw $000C, EnvDropletSpritemaps_stalactite_f2
dw $000C, EnvDropletSpritemaps_stalactite_f3
dw $000C, EnvDropletSpritemaps_stalactite_f4
dw $0008, EnvDropletSpritemaps_stalactite_f3
dw $0008, EnvDropletSpritemaps_stalactite_f4
dw $0008, EnvDropletSpritemaps_stalactite_f3
dw $8161, .preinst_falling
dw $0001, EnvDropletSpritemaps_stalactite_f5
dw $8159 ;sleep until hits ground by preinst
dw $8161, .preinst_landed
dw $0004, EnvDropletSpritemaps_stalactite_f6
dw $0004, EnvDropletSpritemaps_stalactite_f7
dw $0004, EnvDropletSpritemaps_stalactite_f8
dw $8154 ;delete
}
}

!free86 #= pc()

org !free8D
EnvDropletSpritemaps:
{
.smoke
{ ;smoke are probably in $8D somewhere already if you need to save space
..f0
dw $0001 : dw $01FC : db $FC : dw $3A49
..f1
dw $0001 : dw $01FC : db $FC : dw $3A4A
..f2
dw $0001 : dw $01FC : db $FC : dw $3A4B
..f3
dw $0001 : dw $01FC : db $FC : dw $3AC7
..f4
dw $0001 : dw $01FC : db $FC : dw $3A40
}
.ceiling
{
..f0
dw $0001
dw $01FC : db $FC : dw $20D0
..f1
dw $0001
dw $01FC : db $FC : dw $20D1
..f2
dw $0001
dw $01FC : db $FC : dw $20D2
..f3
dw $0001
dw $01FC : db $FC : dw $20D3
..f4
dw $0001
dw $01FC : db $FC : dw $20D4
..f5
dw $0001
dw $01FC : db $FC : dw $20D5
..f6
dw $0001
dw $01FC : db $FC : dw $20D6
..f7
dw $0001
dw $01FC : db $FC : dw $20D7
}
.stalactite
{ ;has an extra animation frame
..f0
dw $0001
dw $01FC : db $FC : dw $20D0
..f1
dw $0001
dw $01FC : db $FC : dw $20D1
..f2
dw $0001
dw $01FC : db $FC : dw $20D2
..f3
dw $0001
dw $01FC : db $FC : dw $20D3
..f4
dw $0001
dw $01FC : db $FC : dw $20D4
..f5
dw $0001
dw $01FC : db $FC : dw $20D5
..f6
dw $0001
dw $01FC : db $FC : dw $20D6
..f7
dw $0001
dw $01FC : db $FC : dw $20D7
..f8
dw $0001
dw $01FC : db $FC : dw $20D7
}
}

!free8D #= pc()

org !free83	;can be anywhere

DropletGraphics:
.flatCeiling
incbin "water-drop-ceiling.GFX"
..end
.stalactite
incbin "water-drop-stalactite.GFX"
..end

!free83 #= pc()