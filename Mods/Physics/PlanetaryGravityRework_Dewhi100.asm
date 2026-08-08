LoROM

;;Physics Refactor by dewhi100
;
;There is a lot of redundancy in the code that assigns gravity and jump speeds.
;So I cut it down a bunch and repointed some of the values into new tables
;
;As a side effect, gravity suit can have its own physics separate from air, by adding another index.

!uniqueGravitySuit = 1

;;Gravitational constants

!airSubGravity = $1C00		;vanilla $1C00
!waterSubGravity = $0800	;vanilla $0800
!lavaSubGravity = $0900		;vanilla $0900
!airGravity = 0				;vanilla 0
!waterGravity = 0			;vanilla 0
!lavaGravity = 0			;vanilla 0

;;Jumping constants (with and without Hi-jump)

!subJumpAir = $E000		;vanilla $E000
!subJumpWater = $C000	;vanilla $C000
!subJumpLava = $C000	;vanilla $C000

!subHiJumpAir = 0		;vanilla 0
!subHiJumpWater = $8000	;vanilla $8000
!subHiJumpLava = $8000	;vanilla $8000

!jumpAir = 4			;vanilla 4
!jumpWater = 1			;vanilla 1
!jumpLava = 2			;vanilla 2

!hiJumpAir = 6			;vanilla 6
!hiJumpWater = 2		;vanilla 2
!hiJumpLava = 3			;vanilla 3

;;Walljumping constants (with and without Hi-jump)

!subWalljumpAir = $A000		;vanilla $A000
!subWalljumpWater = $4000	;vanilla $4000
!subWalljumpLava = $A000	;vanilla $A000

!subHiWalljumpAir = $8000	;vanilla $8000
!subHiWalljumpWater = $8000	;vanilla $8000
!subHiWalljumpLava = $8000	;vanilla $8000

!walljumpAir = 4			;vanilla 4
!walljumpWater = 0			;vanilla 0
!walljumpLava = 2			;vanilla 2

!hiWalljumpAir = 5			;vanilla 5
!hiWalljumpWater = 0		;vanilla 0
!hiWalljumpLava = 3			;vanilla 3

;;Bombjump constants

!subBombjumpAir = $C000		;vanilla $C000
!subBombjumpWater = $1000	;vanilla $1000
!subBombjumpLava = $1000	;vanilla $1000

!bombjumpAir = 2			;vanilla 2
!bombjumpWater = 0			;vanilla 0
!bombjumpLava = 0			;vanilla 0

;;Unique Gravity Suit constants

!gravitySuitSubGravity = $1C00			;vanilla $1C00
!gravitySuitGravity = 0					;vanilla 0

!gravitySuitSubJump = $E000			;vanilla $E000
!gravitySuitJump = 4					;vanilla 4

!gravitySuitSubHiJump = 0			;vanilla 0
!gravitySuitHiJump = 6				;vanilla 6

!gravitySuitSubWalljump = $A000		;vanilla $A000
!gravitySuitWalljump = 4				;vanilla 4

!gravitySuitSubHiWalljump = $8000	;vanilla $8000
!gravitySuitHiWalljump = 5			;vanilla 5

!gravitySuitSubBombjump = $C000		;vanilla $C000
!gravitySuitBombjump = 2				;vanilla 2

;Gravity handling and utility functions ;;;;;;;;;;;;;;;;;;;;;;;;;

org $909C5B
JSR GetPhysicsIndex					;X = air/water/lava physics table index
LDA subGravityTable,x : STA $0B32	;Samus Y subacceleration
LDA gravityTable,x 	: STA $0B34		;Samus Y acceleration
RTS

GetPhysicsIndex:
if !uniqueGravitySuit != 0
	LDX.w #6
else 
	LDX.w #0
endif
LDA $09A2	;Equipment
BIT #$0020	;Gravity
BNE +
LDA $197E	;FX liquid flags
BIT #$0004	;Disable physics flag
BNE +
LDA $0AD2	;Liquid physics type
ASL : TAX
+
RTS

GetPhysicsIndexWithHiJump:
JSR GetPhysicsIndex
LDA $09A2	;Equipment
BIT #$0100	;Hi Jump
BEQ +
TXA : CLC : ADC.w #(jumpTable-subJumpTable)/2 : TAX
+
RTS

subGravityTable:
DW !airSubGravity, !waterSubGravity, !lavaSubGravity
if !uniqueGravitySuit != 0
	DW !gravitySuitSubGravity
endif

gravityTable:
DW !airGravity, !waterGravity, !lavaGravity
if !uniqueGravitySuit != 0
	DW !gravitySuitGravity 
endif

padbyte $FF
pad $909CAC

warnpc $909CAC

;Rewriting Jump/Walljump/Bombjump routines ;;;;;;;;;;;;;;;;;;;;;

org $9098BC	;Routine: Make Samus Jump
MakeSamusJump:
if !LimitedSpaceJumps_Oi27 == 0
	PHP : PHB : PHK
else
JSR CountJump
PLB : REP #$30	;the usual housekeeping (abridged)
endif
JSR GetPhysicsIndexWithHiJump
LDA subJumpTable,x : STA $0B2C	;Samus Y subspeed
LDA jumpTable,x : STA $0B2E	;Samus Y speed
JMP $99A6	;common to jump and walljump

subJumpTable:
DW !subJumpAir, !subJumpWater, !subJumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitSubJump
endif

DW !subHiJumpAir, !subHiJumpWater, !subHiJumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitSubHiJump
endif

jumpTable:
DW !jumpAir, !jumpWater, !jumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitJump
endif

DW !hiJumpAir, !hiJumpWater, !hiJumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitHiJump
endif

MakeSamusWalljump:
PHP : PHB : PHK : PLB : REP #$30	;the usual housekeeping.
JSR GetPhysicsIndexWithHiJump
LDA subWalljumpTable,x : STA $0B2C	;Samus Y subspeed
LDA walljumpTable,x : STA $0B2E	;Samus Y speed
JMP $99A6	;common to jump and walljump

subWalljumpTable:
DW !subWalljumpAir, !subWalljumpWater, !subWalljumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitSubWalljump
endif

DW !subHiWalljumpAir, !subHiWalljumpWater, !subHiWalljumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitSubHiWalljump
endif

walljumpTable:
DW !walljumpAir, !walljumpWater, !walljumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitWalljump
endif

DW !hiWalljumpAir, !hiWalljumpWater, !hiWalljumpLava 
if !uniqueGravitySuit != 0
	DW !gravitySuitHiWalljump
endif

MakeSamusBombjump:
PHP : REP #$30
JSR GetPhysicsIndex	
LDA subBombjumpTable,x : STA $0B2C	;Samus Y subspeed
LDA bombjumpTable,x : STA $0B2E	;Samus Y speed
PLP : RTS

subBombjumpTable:
DW !subBombjumpAir, !subBombjumpWater, !subBombjumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitSubBombjump
endif

bombjumpTable:
DW !bombjumpAir, !bombjumpWater, !bombjumpLava
if !uniqueGravitySuit != 0
	DW !gravitySuitBombjump
endif

padbyte $FF
pad $9099A6

warnpc $9099A6

org $90E025
JSR MakeSamusBombjump

org $91FC13
JSL MakeSamusWalljump
