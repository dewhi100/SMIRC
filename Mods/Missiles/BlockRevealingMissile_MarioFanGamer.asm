asar 1.90

; Modifies the change block PLMs to be affected by Missiles and Super Missiles.

;!FreeSpace = $84F1D3 ; Some freespace in bank $84.

; 1 = enabled, 0 = disabled
!PowerBombReveal = 1    ; Allow PBs to reveal blocks like bombs 
!BombBlockReveal = 0    ; Make bomb blocks being revealed by any beam
!BombBlockGrapple = 0   ; Allow Grapple Beam to reveal bomb blocks

lorom

; Internal defines, do not change

!ProjectileBeam = $0000
!ProjectileMissile = $0100
!ProjectileSuper = $0200
!ProjectileBomb = $0500
!ProjectilePower = $0300

SpecialBlocksBomb = $949D71
SuperMissileReaction = $84CF81

ProjectileIndex = $7E0DDE
ProjectileType = $7E0C18

PlmPointer = $7E1C37
PlmInstructionPtr = $7E1D27

PlmDelete = $8486BC

SpawnBombBlock1x1Plm = $84C904
SpawnBombBlock2x1Plm = $84C90A
SpawnBombBlock1x2Plm = $84C910
SpawnBombBlock2x2Plm = $84C916


; Give missiles interaction for crumble and speed blocks.
org $94A175+($B*2)
dw SpecialBlocksBomb

org $94A195+($B*2)
dw SpecialBlocksBomb


; Repoint init codes
; Respawning
org $84D0B8
dw InitBombBlock1x1
org $84D0BC
dw InitBombBlock2x1
org $84D0C0
dw InitBombBlock1x2
org $84D0C4
dw InitBombBlock2x2
; Non-Respawning
org $84D0C8
dw InitBombBlock1x1
org $84D0CC
dw InitBombBlock2x1
org $84D0D0
dw InitBombBlock1x2
org $84D0D4
dw InitBombBlock2x2


org $84CF37
PowerBombBlock:
	CMP.w #!ProjectilePower	; Rearranging some stuff.
	BEQ .Destroy
	CMP.w #!ProjectileBeam
	BNE .Display

org $84CF48
.Destroy

org $84CF60
.Display

; Super Missile blocks
org $84CF70
SuperMissileBlock:
	CMP.w #!ProjectileSuper	; Rearranging some stuff.
	BEQ .Destroy
if !PowerBombReveal
	CMP.w #!ProjectileBeam
else
	JSR CheckPbBeam
endif
	BNE .Display

org $84CF81
.Destroy

org $84CF99
.Display

; Crumble / Speed blocks
org $84CFA9
if !PowerBombReveal
	CMP.w #!ProjectileBeam
else
	JSR CheckBeamPbs
endif
	BNE $06

; Bomb blocks
org $84CEDA
BombBlock:
	LDX.w ProjectileIndex
if not(!BombBlockGrapple)
	BMI .Delete
endif
	LDA.w ProjectileType,x
	AND #$0F00
	CMP.w #!ProjectileBomb
	BEQ .Bomb
	JMP BombBlockCheck

if pc() > $84CEED
    error "There is too much code for the bomb block shot reaction"
endif

org $84CEED
.Delete

org $84CEF4
.PowerBomb

org $84CF0C
.Bomb

reset bytes

org !free84 ;!FreeSpace
InitBombBlock2x2:
    LDA #SpawnBombBlock2x2Plm
BRA InitBombMain

InitBombBlock1x2:
    LDA #SpawnBombBlock1x2Plm
BRA InitBombMain

InitBombBlock2x1:
    LDA #SpawnBombBlock2x1Plm
BRA InitBombMain

InitBombBlock1x1:
    LDA #SpawnBombBlock1x1Plm
InitBombMain:
    STA $12
JMP BombBlock

if not(!PowerBombReveal)
CheckPbBeam:
	CMP.w #!ProjectilePower
	BEQ .Okay
	CMP.w #!ProjectileBeam
.Okay
RTS
endif

BombBlockCheck:
	CMP.w #!ProjectilePower
	BEQ .PowerBomb
if not(!BombBlockReveal)
	CMP.w #!ProjectileBeam
	BEQ .Delete
endif
	LDA $12
	STA.w PlmInstructionPtr,y
RTS

.Delete
JMP BombBlock_Delete

.PowerBomb
JMP BombBlock_PowerBomb

print "Freespace use: ",bytes," bytes"
print "Freespace use end: $",pc

!free84 #= pc()