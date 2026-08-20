; enemy projectile-projectile collision fix, by H A M
; fixes the enemy projectile-projectile collision detection to rely on hitboxes and also make the collision routine happen after the pre-instruction but before setting the instruction.
; also makes enemy projectiles interact with bombs.

org $A0996C ; i'm gonna overwrite an existing vanilla routine
EnemyProjectile_ProjectileCollision:
LDX $1991 ; X = [enemy projectile index]
LDA $0CCE : ORA $0CD2 : BEQ .Return ; if no projectiles nor bombs, return
LDA $1BD7,x : BPL .Return ; if disabled collisions with projectiles, return
LDA $7EF380,x : DEC : DEC : BEQ .Return ; if interaction with projectiles is disabled, return
LDA $1BB3,x : AND #$00FF : STA $1A ; $1A = [enemy projectile X radius]
LDA $1BB4,x : AND #$00FF : STA $1C ; $1C = [enemy projectile Y radius]
TDC : TAY ; Y = 0 (projectile index)
.LoopProjectile
{
  LDA $0C18,y : BEQ .NextProjectile ; if projectile doesn't exist: next projectile
  AND #$0F00 : CMP #$0300 : BEQ .NextProjectile ; no power bombs
  CMP #$0700 : BPL .NextProjectile ; no beam or missile explosions
  CMP #$0500 : BNE .NotBomb ; branch if not bomb
  
  ;Bomb handling
  LDA $0C7C,y : BNE .NextProjectile ; if [bomb timer] != 0: next projectile
  .NotBomb
  LDA $0B64,y : SEC : SBC $1A4B,x : BPL + ; If |[projectile X position] - [enemy projectile X position]| >= [projectile X radius] + [enemy projectile X radius]: next projectile
  EOR #$FFFF : INC
  +
  SEC : SBC $0BB4,y : BCC + : CMP $1A : BCS .NextProjectile
  +
  LDA $0B78,y : SEC : SBC $1A93,x : BPL + ; If |[projectile Y position] - [enemy projectile Y position]| >= [projectile Y radius] + [enemy projectile Y radius]: next projectile
  EOR #$FFFF : INC
  +
  SEC : SBC $0BC8,y : BCC + : CMP $1C : BCS .NextProjectile
  +
  JSR HandleEnemyProjectile_ProjectileCollision ; Handle enemy projectile collision with projectile
}

.NextProjectile
INY : INY : CPY #$0014 : BMI .LoopProjectile ; go through all 10 projectile slots

.Return



DEC $1B8F,x : RTL ; restore from hijack

HandleEnemyProjectile_ProjectileCollision:
TYA : LSR : STA $18A6 ; Collided projectile index = [Y] / 2
LDA $7EF380,x : DEC : BEQ .Dud ; If enemy projectile dud shot not enabled:
LDY $1997,x : LDA $000C,y : STA $1B47,x ; Enemy projectile instruction list pointer = (enemy projectile shot instruction list)
TDC : INC : STA $1B8F,x ; Enemy projectile instruction timer = 1
LDA #$84FB : STA $1A03,x ; Enemy projectile pre-instruction = RTS
LDA $1BD7,x : AND #$7FFF : STA $1BD7,x ; Enemy projectile properties &= 7FFFh (don't detect collision with projectiles)
PHX : JSL CreateExplosion : PLX ; Create projectile explosion (see "enemy hit explosion.asm", also Y = [collided projectile index], and [X] needs to preserved for the next loop)
LDA $0C18,y : BIT #$0008 : BNE + ; If projectile is not plasma beam:
  LDA $0C04,y : ORA #$0010 : STA $0C04,y ; Flag projectile for deletion
+
RTS

.Dud
JSL $A0A8BC ; Create a dud shot
RTS

assert pc() <= $A09A5A

org $868128 ; hijack point
JSL EnemyProjectile_ProjectileCollision : BRA $00

org $828B82 : BRA $02 ; disable vanilla routine
