;May 15th, 2024. Release v0.3
;Developed with xkas v0.06
;Ob built a mess, then two years later made it less messy.

; !!! DISCLAIMER: THIS IS SEVERELY LIMITED WITHOUT ASM AND OTHER SUPER METROID HACKING EXPERIENCE !!!
; Partially because it is organized like neapolitan  ice cream

; This replaces x-ray with a bomb launcher. Holding the fire button charges up, and is added to
; the bomb speed, damage, and timer by default.

; == Core Features ==
; Enemies' vulnerablity to bombs is checked, $8X means the bomb will stick, $0X means it will explode on contact
; Bombs stick to and explode faster on shot/bomb/crumble BTS (threshold is defined)
;   -> BTS 2 (air no x-ray) is treated as a sticky surface

; == Changes made ==
; $90
; - Hud switching routine is compacted
; - X-ray handler is hijacked for bomb launcher handler
; - Arm cannon table is adjsuted to have arm cannon open with launcher
; - (Freespace) Pre-inst used to handle grenade physics
; - (Freespace) Actual bomb launcher handler
; $94
; - Modified bomb spread BTS reaction table
; - (Freespace) Special collision routine to allow launched bombs to stick to BTS
; $A0
; - Hijacked No_Damage of hit routine @dud sprite
;   - (Freespace) Doesn't spawn a dude sprite if damage is from bomb type
; - Hijacked start of enemy proj / proj collision to check bomb count
;   - (Freespace) Repeat of collision routine, but only for bombs.
;   - !!SPECIAL!! Ignores Botwoon body projectile by proj ID
; - Regular enemy bomb routine skips bomb timer check before collision
; - Hijacked Regular bomb routine after hit is detected
;   - (Freespace) Vuln check, sticky placement, or prime bombs to explode
; - Extended enemy bomb routine skips bomb timer check before collision
; - Hijacked extended after hit is detected
;   - (Freespace) Vuln check, sticky placement, or prime bombs to explode pt II electric boogaloo

; == Not Included in v0.3 ==
; - Playtesting or Balancing
; - Batteries
; - HUD Graphics
; - Item equipment screen edit
; - Item pickup message edit
; - Item PLM graphics
; - Vulnerablity / enemy changes (i.e. Vanilla keyhunters are immune to bombs)
; - Better Bomb Explosion Radius
;   (By Nodever2 and Benox50, highly reccomend) https://metroidconstruction.com/resource.php?id=469
; - A good launch charge indicator
;   (TODO: Ask TestRunner & amoeba how to adapt the HUD charge indicator from Subversion)

; == Bomb launcher parameters ==
{;
    !BombTimerLen = $0040 ;Default timer; can increase by up to 2*chargecap
        !BlockTimer = $0060 ;Threshold for early detonation on BTS
        !EnemyTimer = $0060 ;Unused, threshold for early detonation; replaced by vuln check

    !BombDamage = $001E ;Vanilla = 30h,
    !ChargeCap = $0060 ;Maximum charge value
        ;Added *1 to damage and time,  *2 added to inital velocity
    !BombDamDelay = $0006 ;Delay between hits for the same bomb explosion
    ;!!! These bombs are "plasma" bombs that hit more than once! adjust accordingly

    ; If the bombs are too laggy, consider reducing how many can be around.
    !LauncherCooldown = $000F ;Time between firing shots
    !MaxBombs = $0005
    !MaxBombsIndex = !MaxBombs*2+$000A
           
    !Gravity    = $001C ;Vanilla gravity, applied to bomb projectile.
    !BounceLoss = $00A0 ;Gives sense of inertia by subtracting speed; lower = bouncier 

    !BaseSTSpeed = $0400 ;Initital straight speed, vanilla beam value
    !BaseDGSpeed = $02AB ;Initial diagonal speed, vanilla beam value

    !LochingTime = $0010 ;Amount of charging (frames) to play the loading sounds
    !SoundThreshold = $0230 ;Minimum speed to play bouncing sound; primarily to correct for bombs that get stuck in collision and fill the sound queue
    !ChargeSound = $003B ;3B Lib 1 : "Going form world map to area map when loading saved game"
    !LaunchSound = $005E ;5E Lib 2 : "Swishing of swinging object"
    !BounceSound = $0004 ;04 Lib 3 : "Land from jump (hard)"
}

;========= DEFINES =========
{
    {;Sound routines
        ;Bank 80
        !80 = $800000
        !PlayLib1Sound = $9021
        !PlayLib2Sound = $90CB
        !PlayLib3Sound = $9125
    }

    {;Input ram
        !InputBits = $0E00
        !PreviousInput = $0DFE
        !ControllerInput = $8B
        !ShootBind = $09B2
    }

    {;Samus handlers and projectile routines
        ;Bank 90
        !90 = $900000
        !90Free = $F733
        !HUDSwitch      = $C539 ;Rewritten routine
        !HUDHandler     = $DDC8 ;X-ray's handler
        !KillPj         = $ADB7
        !BombTicker     = $C128 ;Regular timer / blinking processing
        !PjPosDirInit   = $BA56
        !PjSpeedInit    = $B1F3
        !ArmTable       = $C7D9 ;To make the arm cannon click open
;		!selTable = $DD61	;dewhi added (but IDK why. maybe used by other ASMs?)
    }

    {;Bomb init and collision
        ;Bank 93
        !93 = $930000
        !BombInit = $80A0

        ;Bank 94
        !94 = $940000
        !94Free = $B31C
        !SpreadCollision = $A621 ;Vanilla bomb spread collision handler
        !CollisionTable = $A601
    }

    {;Enemy/enemy projectile and bomb collision defines
        ;Bank A0
        !A0 = $A00000
        !A0Free = $F9D3
        {;Collision routine handlers; none of these defines are used directly, there are instead several piecemeal changes in each routine.
            !EnemyColHandler       = $9758  ; Handles Enemy / projectile / Samus collision handlers
            !ProjProjColHandler    = $996C  ; Enemy projectile / projectile collision
            !ProjColHandler        = $9B7F  ; Vanilla multisprite / projectile; condensed with common functions
            !MultiSamusColHandler  = $9A5A  ; Vanila
            !EnemyProjColHandler   = $A143  ; Vanilla regular enemy/projectile; stripped to unique elements, dependant on ProjColHandler
            !EnemySamusColHandler  = $A07A  ; Vanilla
        }
        ;Enemy Ram
        !EnemyIndex = $0E54
        !EnemyID = $0F78
        !EnemyXpos = $0F7A
        !EnemyYpos = $0F7E

        !EnemyExXPos = $187A
        !EnemyExYPos = $187C

        !EnemyPjDex = $18A6 ;Enemy projectile index
        !EnemyPjID = $1997 ;Enemy projectile ID
        !EnemyPjProp = $1BD7 ;Enemy projectile properties
        !EnemyPjXPos = $1A4B
        !EnemyPjYPos = $1A93
    }

    {;Projectile (Pj) ram address
        ;Note that bombs are processed with a +10 index, seperate from regular projectiles but same indexing.
        !PjIndex  = $0DDE
        !PjXPos   = $0B64
        !PjXsPos  = $0B8C
        !PjYPos   = $0B78 
        !PjYsPos  = $0BA0
        !PjXRad   = $0BB4 ;Unused
        !PjYRad   = $0BC8 ;Unused
        !PjXSpeed = $0BDC ;1/100 pv/frame
        !PjYSpeed = $0BF0
        !PjDir    = $0C04 
        {;Directions diagram
            ;0: Up, facing right
            ;1: Up-right
            ;2: Right
            ;3: Down-right
            ;4: Down, facing right
            ;5: Down, facing left
            ;6: Down-left
            ;7: Left
            ;8: Up-left
            ;9: Up, facing left
            ;10h+: Delete projectile

            ;Graphically:
            ;    9 0
            ;  8     1
            ;7    #    2
            ;  6     3
            ;    5 4
        }
        !PjType = $0C18
        !PjDamage = $0C2C

        !BombTimer = $0C7C
        !LaunchCharge = $0C9A ;Regularly used for y subspeeds, used here for charging effect (to avoid the flashing with the regular charge beam). Added to damage and timer.
        !BombDamTimer = $0C90 ;Projectile trail timer, used here as 'cooldown' for damage so that bombs don't dmaage every frame. Not a perfect solution.

        !PjInst = $0C54 ;Unused
        !PjPreInst = $0C68 
        !PjSprite = $0CB8 ;Unused, contender for damage routines (checking for frame of explosion)

        !PjCount = $0CCE
        !BombCount  = $0CD2

        !CoolTimer   = $0CCC ;Cooldown for shooting
        
    }
}

lorom

;big block of dewhi code. for replacing supers spot. needs refactor
; org $809AD2
; JSR LauncherFlagCheck

; ;not needed if using universal ammo
; ;org $809B0F
; ;BRA $0C

; org $809C16
; JSR LauncherFlagCheck

; org $809C34
; NOP #3

; org !free80
; LauncherFlagCheck:
; LDA $09A2	;equipped items
; BIT #!bombLauncherBitflag
; BNE + ;branch if launcher equipped
; LDA #$0000	;default: return 0 if zero
; RTS
; +
; LDA #$0001	;return 1
; RTS
; !free80 #= pc()

;===== Bank $90 ===== Samus routines.
org !90+!HUDSwitch
{; Hud item switch table; needed to fit mine, and it happened  to be fairly inefficent.
    DW SwitchCommon
	if !HUD_Index == 0
		DW SWLauncher
	else
		DW SWMissiles
	endif
	if !HUD_Index == 1
		DW SWLauncher
	else
		DW SWSupers
	endif
	if !HUD_Index == 2
		DW SWLauncher
	else
		DW SWPowerB
	endif
	if !HUD_Index == 3
		DW SWLauncher
	else
		DW SWGrapple
	endif
	if !HUD_Index == 4
		DW SWLauncher
	else
		DW SWXray
	endif

    SWMissiles: 
;		LDA $09EE			;unused ram used by the universal ammo routine to check whether any missiles have been collected. ie a "missile launcher"
;		BEQ ++
        LDA $09C6           ;\
        BNE +             ;} If [Samus missiles] = 0
;        ++ 
		SEC : RTS           ;/ Return carry set	;go here if failure
        + BRA SwitchCommon    ;go here if success

    SWSupers: 
		if !SupersNeedMains_Dewhi100 == 1
			JSR SuperEventCheck90
		else
			LDA $09CA           ;\
		endif
        BNE $02             ;} If [Samus super missiles] = 0
        SEC : RTS           ;/ Return carry set
        BRA SwitchCommon    ;

    SWPowerB: 
;		LDA $09C6			;check missiles if using universal ammo
;		CMP #$000A			;need at least as many as it costs to fire them or else you underflow
;		BMI ++
;		LDA $09D0		;check max pb instead if using universal ammo
        LDA $09CE           ;\
        BNE +             ;} If [Samus power bomes] = 0
;        ++ 
		SEC : RTS           ;/ Return carry set
        + BRA SwitchCommon    ;

    SWGrapple: 
        LDA $09A2           ;\
        BIT #$4000          ;} If not equipped grapple:
        BNE $02             ;|
        SEC : RTS           ;/Return carry set

        LDA $0D32           ;\
        CMP #$C4F0          ;} If [grapple function] != inactive
        BNE +               ;/ Return carry clear
        LDA #$C4F0          ;\
        STA $0D32           ;} Grapple function = inactive
        BRA SwitchCommon    ;
     +  CLC : RTS
        
	SWXray:
		LDA $09A2
		BIT #$8000	;Xray
		BNE +
		SEC : RTS
		+ BRA SwitchCommon

    SWLauncher: 
        LDA $09A2       ;\
        BIT #!bombLauncherBitflag      ;} Check item equipped
        BNE +         ;/
		-
        SEC : RTS       ;} Return if not
		+
;		LDA $09C6 : BEQ -	;check for missiles if using universal ammo
        STZ $0C9A

    SwitchCommon:
        STZ $0CD0       ; Clear beam charge counter
        JSR $BCBE       ; Clear charge animation state
        JSL $91DEBA     ; Load Samus suit palette
        CLC : RTS       ;

warnpc $90C5C4
			
}

org $90dd61			;hud handlers.	may comment some entries depending on what other ASM you use (ex. charge missiles) and how you want to arrange hud
dw $B80D ; Nothing
	if !HUD_Index == 0
		dw BombLauncherHandler ; Bomb Launcher replaces Super missiles
	else
		dw $BE62 ; Missiles
	endif
	if !HUD_Index == 1
		dw BombLauncherHandler ; Bomb Launcher replaces Super missiles
	else
		dw $BE62 ; Super Missiles (same as missiles)
	endif
	if !HUD_Index == 2
		dw BombLauncherHandler ; Bomb Launcher replaces Super missiles
	else
		dw $B80D ; Power bombs
	endif
	if !HUD_Index == 3
		dw BombLauncherHandler ; Bomb Launcher replaces Super missiles
	else
		dw $DD6F ; Grapple
	endif
	if !HUD_Index == 4
		dw BombLauncherHandler ; Bomb Launcher replaces Super missiles
	else
		dw $DDC8 ; X-ray
	endif

;org !90+!HUDHandler
{;Hijack
;    JSR BombLauncherHandler : RTS
}

org !90+!ArmTable ;Arm Cannon state: 00/01 is Close/Open by HUD index.
	DB $00				;nothing selected
	DB $01				;Missiles
	DB $01				;Supers
	if !HUD_Index == 2
		DB $01			;If using Bomb Launcher here
	else
		DB $00			;Power Bombs
	endif
	DB $01				;Grapple
	if !HUD_Index == 4
		DB $01			;If using Bomb Launcher here
	else
		DB $00			;X-Ray
	endif

org !free90
    print pc, " - Bomb launcher pre inst"
    PreInst:
{;Preinstructions for grenade variant of bomb
    LDA !PjDir,x : BIT #$8000 : BNE .activeBomb ;If sticky, it will complete its explosion
    AND #$00F0 : BEQ .activeBomb
    JSL !90+!KillPj : RTS

    .activeBomb
        JSR !BombTicker
        LDA !BombDamTimer,x : BEQ +
        DEC A : STA !BombDamTimer,x 
        ;check for stuck?
     +  LDA !PjDir,x : BIT #$8000 : BEQ ++ ;If sticky, don't run physics / bouncing.
        JSL !94+!SpreadCollision : RTS
     ++ LDA !BombTimer,x : BNE .yLogic ;Timer is over, exploding time
        JMP .endPreInst

    .yLogic
    {;
        .yMove
        {;
            STZ $14
            LDA !PjYSpeed,x : ADC #!Gravity : STA !PjYSpeed,x ;Apply gravity
            BPL + : DEC $14 ;\
         +  STA $13         ;} Carries value

            LDA !PjYsPos,x : CLC : ADC $12 : STA !PjYsPos,x ;Apply speed to Ysubpos
            LDA !PjYPos,x : ADC $14 : STA !PjYPos,x         ;and Ypos
        }

        .yCol
        ;Check for a collision
        PHX : JSL !94+!SpreadCollision
        PLX : BCC .xLogic ;If no collision, move on

        .yBounce
        {; Play sound and reverse speed
            LDA !PjYSpeed,x : EOR #$FFFF : BPL +
            ADC #!BounceLoss : BRA ++
         +  SBC #!BounceLoss
         ++ STA !PjYSpeed,x

            LDA !PjYsPos,x : CLC : SBC $12 : STA !PjYsPos,x     ;Reverse movement
            LDA !PjYPos,x : SBC $14 : STA !PjYPos,x             ;to avoid stuck
        }

        .playSoundY
        {;this method was to avoid a spammy audio bug.
            LDA $13 : BPL +
            EOR #$FFFF
         +  CMP #!SoundThreshold : BMI .xLogic
            LDA #!BounceSound : JSL !80+!PlayLib3Sound
        }
        
    }

    .xLogic
    {;Mostly a repeat. Writing it all out for processing speed.
        .xMove
        {;
            STZ $14
            LDA !PjXSpeed,x
            BPL + : DEC $14 ;\
         +  STA $13         ;} Carries value

            LDA !PjXsPos,x : CLC : ADC $12 : STA !PjXsPos,x ;Apply speed to X subpos
            LDA !PjXPos,x : ADC $14 : STA !PjXPos,x         ;and Xpos
        }
        .xCol
        ;Check for a collision
        PHX : JSL !94+!SpreadCollision
        PLX : BCC .endPreInst ;If no collision, move on

        .xBounce
        {; Play sound and reverse speed
            LDA !PjXSpeed,x : EOR #$FFFF : BPL +
            ADC #!BounceLoss : BRA ++
         +  SBC #!BounceLoss
         ++ STA !PjXSpeed,x

            LDA !PjXsPos,x : CLC : SBC $12 : STA !PjXsPos,x ;Reverse movement
            LDA !PjXPos,x : SBC $14 : STA !PjXPos,x         ;to avoid stuck
        }

        .playSoundX
        {;this method was to avoid a spammy audio bug.
            LDA $13 : BPL +
            EOR #$FFFF
         +  CMP #!SoundThreshold : BMI .endPreInst
            LDA #!BounceSound : JSL !80+!PlayLib3Sound
        }
    }
    print pc, " - end of preinst"
    .endPreInst
        RTS

}

    print pc, " - Bomb Launcher Handler"
    BombLauncherHandler:
{;
    PHP : REP #$30 ;switch to 16b mode?
    LDA !InputBits : BIT !ShootBind : BNE .canLaunch

    LDA !PreviousInput : BIT !ShootBind : BNE .charging
    PLP : RTS ;If not

    .charging
    {;
        LDA !ControllerInput : BIT !ShootBind : BEQ .canLaunch ;If not held

        LDA !LaunchCharge : CMP #!ChargeCap : BPL .HandlerReturn ;Held, full charge, waiting.
        INC A : INC A : STA !LaunchCharge ;Inc charge
        CMP #!LochingTime : BNE .HandlerReturn

        LDA #!ChargeSound : JSL !80+!PlayLib2Sound ;Waits a little to play the loading sound.
        BRA .HandlerReturn
    }

    .CannotLaunch ;
        DEC !BombCount : STZ !LaunchCharge
    .HandlerReturn
        PLP : RTS

    .canLaunch
    {;Check cooldown timer
        INC !BombCount
        LDA !CoolTimer : AND #$00FF : BNE .CannotLaunch
    }
    print pc, " - start of launching"
    .LaunchBomb
    {;
        LDA #!LauncherCooldown : STA !CoolTimer
;		DEC $09C6 ;make it cost ammo (universal ammo ie missiles) 
;		BNE + 
;		STZ $09D2	;item cancel if out of ammo
;		+
        LDX #$000A ;Start of bomb indices relative to proj address
        .loop
        {;Cycle for empty proj slot
            LDA !PjType,x : BEQ .setupBomb
            INX : INX : CPX #!MaxBombsIndex
            BMI .loop : BRA .CannotLaunch
        }

        .setupBomb
        {
            STX $14
            LDA #$8500 : STA !PjType,x 
            LDA #PreInst : STA !PjPreInst,x 
            JSL !93+!BombInit : JSR !PjPosDirInit

            JSR .bombSpeed

            LDA !PjYSpeed,x : BPL +
            SBC #$0080 : STA !PjYSpeed ;A little extra y velocity up velocity so it's less 'drop like a brick'

         +  LDA #!BombTimerLen : ADC !LaunchCharge : STA !BombTimer,x ;Add charge to timer
            LDA #!BombDamage : CLC : ADC !LaunchCharge : STA !PjDamage,x 
            LDA #$0002 : JSL !80+!PlayLib1Sound ;cut charge sound if early release
            STZ !LaunchCharge ;Reset charge counter

            LDA #!LaunchSound : JSL !80+!PlayLib2Sound ;thonk
            PLP : RTS
        }
    }
        
    .bombSpeed
    {; Set inital speeds of projectiles; stripped from other routines, might have redunancies
        PHP : PHB : PHK : PLB : REP #$30
        LDX $14 : LDA !PjDir,x : AND #$000F : ASL A : TAX ;table lookup
        LDA !LaunchCharge : ASL A : ASL A ; Add charge time *2 to inital velocity
        JMP (.directionSpeedTable,x) 

        .st ;Straights
            ADC #!BaseSTSpeed
            BRA .setSpeed

        .dg ;Diagonals
            ADC #!BaseDGSpeed

        .setSpeed
            STA $16 : LDX $14 : STX $12 : JSR !PjSpeedInit
            PLB : PLP : RTS

        .directionSpeedTable
            dw .st, .dg, .st, .dg, .st, .st, .dg, .st, .dg, .st
    }
}
!free90 #= pc()

;===== Bank $94 ===== Projectile block collisions
org !free94
    StickyColiisions:
    {;
        SpecialStick: ;Stick to the air no x-ray
        {; This uses the x-ray blocking blocks as part of the botwoon scheme :)
            PHX : PHA : LDX !PjIndex

            LDA !PjDir,x : ORA #$8000 : STA !PjDir,x ;If sticky, stop bothering with physic processing.
            STZ !PjXSpeed,x : STZ !PjYSpeed,x  ;Stop bomb speed
            ;LDA !BombTimer,x : CMP #!BlockTimer : BMI .goBoom ;Change to wait for botwoon
            PLA : PLX : SEC : RTS
        }

        StickyHCopy:
            JMP $9411 : BCC StickyBlock : RTS

        StickyVCopy:
            JMP $9447 : BCC StickyBlock : RTS

        StickyBlock:
        {
            PHX : PHA : LDX !PjIndex

            LDA !PjDir,x : ORA #$8000 : STA !PjDir,x ;If sticky, stop bothering with physic processing.
            STZ !PjXSpeed,x : STZ !PjYSpeed,x  ;Stop bomb speed
            LDA !BombTimer,x : CMP #!BlockTimer : BMI .goBoom
            PLA : PLX : SEC : RTS
        
            .goBoom
                LDA #$0001 : STA !BombTimer,x ;Timer = 1 to run explosion routine next frame
                PLA : PLX : CLC : RTS

        }
    }
!free94 #= pc()

org !94+!CollisionTable
    dw  $9D59
;This section commented unless/until Mfreak's Beam Overhaul is added
;	if !BeamPatch_Mfreak == 1
;		DW BombSpreadSlopeCollision
;	else
		dw $9D5D
;	endif
	dw SpecialStick,$9D59,$9D5B,StickyHCopy,$9D59,$9D59,$9D5B,$9D5B,$9D5B,StickyBlock,StickyBlock,StickyVCopy,$9D5B,StickyBlock
        ; Indexed as BTS; Sticks to [B] Crumble, [C] Shot, [F] Bomb, and solid vertical / horizontal copies of those.

;===== Bank $A0 ===== And now the pandoras box of making bombs stick to enemies. :D

    ; Explosions are cooler when they aren't jsut deleted. However, 5x or 10x dud shots looks dumb.

org !A0+$A7B6
    JMP NoBombDud

    ; If you can fire bombs, you'd want to be able to blow up stuff like kago swarms. Did you know there is no just routine in ba sing se? :(
    ; I did spend some time trying to rewrite and merge other routines, but my sanity dipped and I decided I wanted a done project.

org !A0+$9975
{;Writing over debug (lda/sta processing stage)
    LDA !PjCount : BNE regularProjProj
    JMP EnemyProjectileBomb
}
org !A0+$9984 : regularProjProj: : LDA #$0022 ;Probably don't need to actually write anything here, but I was not sure if the label would work and didn't bothing testing otherwise.
    
    ;Regular enemies need changes, but not huge rewrites.

org !A0+$A280 : NOP #5 ;Disable the "not exploding" check pre-collision
org !A0+$A2D2 ;Hijack after collision detected
    JMP EnemyBomb

    ;Extend spritemap hijack

org !A0+$9D91 : NOP #8 ;Disable the "not exploding" check pre-collision
org !A0+$9E41 ;Hijack after collision detected
    JMP ExtendedEnemyBomb

org !freeA0
    print pc, " - Start of A0 free"
    NoBombDud:
{;Check for bomb id, else return and finish spawning dud sprite for No_Damage
    LDA !PjType,x : AND #$0F00 : CMP #$0500 : BEQ .doneDud
    LDA !PjXPos,x : STA $12 : LDA !PjYPos,x : STA $14

    .doneDud
    JMP $A7C0
}
    print pc, " - Enemey projectile bomb interaction"
    EnemyProjectileBomb:
{;As with the other projectile routines, the only reason bombs are seperate is because of logistical quirks.
 ;Bombs use different indices and counters than regular projectiles, maybe because SBA or bomb spread.
 ;Additional special interactions used for Botwoon's body, ID=$EBA0
    LDA !BombCount : BNE .startLoop
    PLB : PLP : RTL
    
    .startLoop
        LDA #$0022 : STA !EnemyPjDex

    .loopEnemyPj
        LDX !EnemyPjDex : LDA !EnemyPjID,x : BEQ .nextEnemyPj ;Checks if an enemy proj exists
        CMP #$EBA0 : BEQ .nextEnemyPj ;Botwwon's body check
        LDA !EnemyPjProp,x : BPL .nextEnemyPj ;Checks if collisions are enabled
        LDY #$000A ;Start of bomb index

    .loopBombs
        LDA $7EF380,x : CMP #$0002 : BEQ .nextEnemyPj ;checks another 'no interaction with projects' flag.
        LDA !PjType,y : BEQ .nextBomb           ;If no proj here. move on
        AND #$0F00 : CMP #$0300 : BEQ .nextBomb ;If powerbomb, move on
        ;Original routine checked for bomb type and moved on, thought it wouldn't have ever happened anyway.
        ;Also checks for 'projectile explosion' which... maybe? I want the bomb explosion to keep ticking though.
        LDA !PjXPos,y : AND #$FFE0 : STA $12
        LDA !EnemyPjXPos,x : AND #$FFE0 : CMP $12 : BNE .nextBomb

        LDA !PjYPos,y : AND #$FFE0 : STA $12
        LDA !EnemyPjYPos,x : AND #$FFE0 : CMP $12 : BNE .nextBomb
        
    ;collision
        LDA !BombTimer,y : BNE .setExplode ;Explode on collsiion, but don't do damage until exploding
        LDA !BombDamTimer,y : BNE .nextBomb ;Bomb deals damage multiple times, but not every frame
        LDA #!BombDamDelay : STA !BombDamTimer,y
        JSR $99F9 ;default collision handing
        LDA !PjDir,y : AND #$000F : STA !PjDir,y ;Unflag bombs to delete. I want the full bomb epxlosion / animation to go off, and damage is distributed over the frames.
        BRA .nextBomb

    .setExplode
        LDA #$0001 : STA !BombTimer,y ;Make the bomb explode outright
        LDA #$0000 : STA !PjXSpeed,y : STA !PjYSpeed
        
    .nextBomb
        INY : INY : CPY #!MaxBombsIndex : BMI .loopBombs

    .nextEnemyPj
        LDA !EnemyPjDex : DEC A : DEC A : STA !EnemyPjDex : BMI .done ;Original dec dec lda is 9 bytes, this is 8. Does it run faster? Idk.
        JMP .loopEnemyPj

    .done
        PLB : PLP : RTL
}
    print pc, " - Regular enemy bomb interaction"
    EnemyBomb:
{
    LDA !BombTimer,y : BEQ .exploding ;Self explanatory

    .checkVuln ;Uses te bomb vulnerablity to decide whether to stick or explode immediately
    LDA !EnemyID,x : TAX : LDA $A0003C,x : BNE + : LDA #$EC1C ;Get vulnerablity pointer from header / default
 +  TAX : LDA $B4000E,x : LDX !EnemyIndex : AND #$00FF ;Get bombs vulnerablity and return to current enemy index
    AND #$0080 : BNE .sticking ;Some enemies make sense to explode, but enemy Vuln $8X will make it stick instead.

    .setExplode
        LDA #$0001 : STA !BombTimer,y

    .sticking
        ;Cool sticking would save an offset and keep position the bomb to that offset; i.e. it'd stay on the edge of an enemy.
        ;But that needs some more work because a) needs to be moved into the hitbox enough to look attached and b) could adversely affect explosion radius
            ;For a) I'd want to flag it so that speed is applied one more time before geting 'STZ'd', and the offset could be saved in the ram used by SBAs
        LDA #$0000 : STA !PjXSpeed,y : STA !PjYSpeed,y
        LDA !PjDir,y : ORA #$8000 : STA !PjDir,y
        LDA !EnemyXpos,x : STA !PjXPos,y
        LDA !EnemyYpos,x : STA !PjYPos,y
    
    .done
        JMP $A2E6

    .exploding
        LDA !BombDamTimer,y : BNE .sticking ;Bomb deals damage multiple times, but not every frame
        LDA #!BombDamDelay : STA !BombDamTimer,y
        JMP $A2E0 ;Returns to the JSL to run enemy shot.
}
    print pc, " - Extended enemy bomb interaction"
    ExtendedEnemyBomb:
{
    LDA !BombTimer,y : BEQ .exploding ;Self explanatory

    .checkVuln ;Uses the bomb vulnerablity to decide whether to stick or explode immediately
    LDA !EnemyID,x : TAX : LDA $A0003C,x : BNE + : LDA #$EC1C ;Get vulnerablity pointer from header / default
 +  TAX : LDA $B4000E,x : LDX !EnemyIndex ;Get bombs vulnerablity and return to current enemy index
    AND #$0080 : BNE .sticking ;Some enemies make sense to explode, but enemy Vuln $8X will make it stick instead.

    .setExplode
        LDA #$0001 : STA !BombTimer,y

    .sticking
        LDA #$0000 : STA !PjXSpeed,y : STA !PjYSpeed,y
        LDA !PjDir,y : ORA #$8000 : STA !PjDir,y
        LDA !EnemyExXPos : STA !PjXPos,y
        LDA !EnemyExYPos : STA !PjYPos,y
    
    .done
        JMP $9E8C

    .exploding
        LDA !BombDamTimer,y : BNE .sticking ;Bomb deals damage multiple times, but not every frame
        LDA #!BombDamDelay : STA !BombDamTimer,y
        JMP $9E4A ;Returns to the JSL to run enemy shot.
}
!freeA0 #= pc()