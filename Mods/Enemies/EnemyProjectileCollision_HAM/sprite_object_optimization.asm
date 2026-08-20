; Allows using an instruction list pointer as sprite object ID

!SpriteObjectIndex = $1844

!SpriteObjectIList = $EF78
!SpriteObjectITimer = $EFF8
!SpriteObjectAttrs = $F078
!SpriteObjectX = $F0F8
!SpriteObjectXSub = $F178
!SpriteObjectY = $F1F8
!SpriteObjectYSub = $F278
!SpriteObjectFlags = $F2F8


!SpriteObjectPointer = $B4BDA8


org $B4BC26
CreateSpriteObject:
{
  PHX : PHY : PHP : PHB
  PEA $7E00 : PLB : PLB
  REP #$30
  LDY #$003E
  .loop
    LDA !SpriteObjectIList,y : BEQ .found
    DEY : DEY : BPL .loop
    BRA .ret

.found
  STA !SpriteObjectXSub,y ; A = 0 here
  STA !SpriteObjectYSub,y
  STA !SpriteObjectFlags,y
  LDA $12 : STA !SpriteObjectX,y
  LDA $14 : STA !SpriteObjectY,y
  LDA $18 : STA !SpriteObjectAttrs,y
  LDA $16 : BMI +

if !WaveDash_Mccad != 1	 
    ASL : TAX : LDA.l !SpriteObjectPointer,x
else
    ASL : TAX : LDA.l !SpriteListRePoint,x	
endif
 +
  STA !SpriteObjectIList,y
  TAX : LDA $B40000,x : STA !SpriteObjectITimer,y
.ret
  STY $12
  PLB : PLP : PLY : PLX : RTL
}

HandleSpriteObjects:
{
  PHB : PEA $7E00 : PLB : PLB
  LDA $0A78 : BNE .ret ; return if time frozen
  LDX #$003E
  .loop
    LDY !SpriteObjectIList,x : BNE .found
    DEX : DEX : BPL .loop
    PLB : RTL

  .found
    LDA !SpriteObjectFlags,x : LSR : BCS .next ; branch if sprite object disabled
    LDA !SpriteObjectITimer,x : BMI .asm
    DEC : STA !SpriteObjectITimer,x
    BNE .next
    TYA : CLC : ADC #$0004 : STA !SpriteObjectIList,x
    TXY : TAX : LDA $B40000,x : BMI .asm2
    TYX : STA !SpriteObjectITimer,x
    DEX : DEX : BPL .loop
    PLB : RTL

  .afterASM
    LDX !SpriteObjectIndex
  .next
    DEX : DEX : BPL .loop
.ret
  PLB : RTL

.asm2
  TYX
.asm
  STA $12
  STX !SpriteObjectIndex
  PEA .next-1 : JMP ($0012)
}

assert pc() <= $B4BCF0

org $A09145 : JSL HandleSpriteObjects ; repoint
