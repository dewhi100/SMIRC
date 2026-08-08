;It's a mess. :)
;
;██████╗  █████╗ ███╗  ██╗██╗  ██╗██╗  ██╗ █████╗ ███╗  ██╗
;██╔══██╗██╔══██╗████╗ ██║██║ ██╔╝██║ ██╔╝██╔══██╗████╗ ██║
;██║  ██║██║  ██║██╔██╗██║█████═╝ █████═╝ ██║  ██║██╔██╗██║
;██║  ██║██║  ██║██║╚████║██╔═██╗ ██╔═██╗ ██║  ██║██║╚████║
;██████╔╝╚█████╔╝██║ ╚███║██║ ╚██╗██║ ╚██╗╚█████╔╝██║ ╚███║
;╚═════╝  ╚════╝ ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝ ╚═╝  ╚══╝
; Donkey Kong Cannon enemy; shoot Samus around!
; Recommended to use with Speedkeep: https://metroidconstruction.com/resource.php?id=368

; December 22, 2022. Releave v1.0
; Version history:
{
    ; December 22, 2022: Initial release
}
{;README
; Developed with xkas v0.06 and SMART.
; This is an ASM (A Serious Mess) file by Ob, which needs to be used alongside the included .gfx, .tpl, and .xml to add this enemy to SMART.
; This patch uses freespace from $A2:F498 to FB57, and some freespace in $90; if you change the freespace, you will need to get the debug log to set the enemy AI.
; The header addresses below assume the default freespace.
    {;===== Enemy DNA Header =====
            ;AIBank     = A2        
            ;DeathAnim  = 0000      
            ;Frozen     = 8041      
            ;Grapple    = 8014
            ;Hurt       = 804C      
            ;Init       = F498
            ;Main       = F510
            ;Powerbomb  = 0000      
            ;Shot       = 802D
            ;Touch      = F5CB
            ;Xray       = 0000
        }
; This enemy is about 2x2 tiles large that shoots Samus ala Donky Kong barrels. 
; On touching a cannon, Samus is loaded.
; Pressing "Down" will drop Samus out of the cannon; Pressing "Jump" will fire Samus.
; The cannon can move at different speeds, and shoot Samus are different speeds.
; By default, Samus is shot with bluesuit; Comment out the first lines of .firesamus to remove.
    {; Enemy Info
        ;Enemy Tilemap: Initial SHIFTING direction; [0F00] Bitwise 1/2=Up/Down, 4/8=Left/Right.
                        ;Graphically:
                            ;      1
                            ;   5     9
                            ; 4    #    8
                            ;   6     A
                            ;      2
                        ;Cannon FIRING direction [000F]
                        ;Graphically:
                            ;      0
                            ;   8     1
                            ; 7    #    2
                            ;   6     3
                            ;      4
        ;Parameter / Speed 1: Samus exit velocity; [XXYY] 0808 is a fairly powerful shot
        ;Parameter / Speed 2: Shifting speed; [XXYY] Looks up linear speeds table.


    }
; ===== General notes =====
; If the cannon moves, it will collide and bounce with solid tiles.
; The max fall speed is increased to 8h to maintain the cannon arc; the vanilla cap makes the arc linear fairly quickly. Firing a cannon downwards can exceed this cap.
; Do not overlap cannons, they fight for Samus.
}
;===== Defines =====
{
    {;Addresses

        ;Bank $90
;        !90 = $900000
;        !90UnusedSpace = $F04B
        !FallCap = $910F

        ;Bank $91
;        !91 = $910000
        !PoseChangeHandler   = $F433
        !PoseChangeAnimation = $FB08

;        ;Bank 9B
;        !9B = $9B0000
;        !9BUnusedSpace = $CBFB

        ;Bank $A0
        !A0 = $A00000
            ;LinearSpeeds Table
            !LinSpds      = $8187 ;Negative table starts at $818D
            !LinSbSpds    = $8189
        !MoveEnemyX   = $C6AB
        !MoveEnemyY   = $C786
        !AtLeastX   = $BB9B
        !AtLeastY   = $BBAD
        !MoveX      = $C6AB
        !MoveY      = $C786
        
        ;Bank $A2
;        !A2 = $A20000
;        !A2FreeSpace = $F498

    }

    !Sleep = $812F ;For draw instruction

    !EquippedItems  = $09A2

    {;Input Defines
        !SamusInput     = $8B
        !BriefInput     = $8F

        !InputTimer     = $001E ; Input lockout. Used to prevent holding Left/Right causing the cannon to bungee Samus opposite the cannon's direction.
        !InputControl   = $0A60
            !InputNormal    = $E913
            !InputRTS       = $E90E

        !DownBind       = $09AC
        !LeftBind       = $09AE
        !RightBind      = $09BE
        !ShootBind      = $09B2
        !JumpBind       = $09B4
    }

    {;Pose Defines
        !SamusPose      = $0A1C 
        !SamusXDir      = $0A1E ; Right=8, Left=4
        !SamusYDir      = $0B36 ; None=0,  Up=1,  Down=2
        !SamusFallFlag  = $0B22
        
        !LochSamusPoseR = $0019 ;Spinjump right
        !LochSamusPoseL = $001A ;Spinjump left

        !ReleasePoseR   = $0019 ;\
        !ReleasePoseL   = $001A ;} Falling

        !FireSamusPoseR = $0019 ;\
        !FireSamusPoseL = $001A ;} Spin jump; +2h for space jump, +68h for screw attack
    }

    {; Samus Defines
        !SamusMoveType = $0A1F
            !Spinning = $0003
            !Falling  = $0006
            !MorphAir = $0008
            !SpringAir = $0012 ; Using springball in air

        !ControlPointer = $0A44 ;Ram
            ;!LochedControl is set below
            !NormalControl = $E725

        !MovementHandler = $0A58
            !NormalMovement  = $A337 ;} Double set for sake of variable readability
            !LochedMovement  = $94CB ; Samus drained - crouching

        !SamusXpos      = $0AF6
        !SamusXsubpos   = $0AF8
        !SamusYpos      = $0AFA
        !SamusYsubpos   = $0AFC
        !SamusXspeed    = $0B46 ;$0DBC
        !SamusXsubspeed = $0DBE
            !SamusXtraS  = $0B42 ;Extra runspeed ala shinespark
            !SamusXtraSb = $0B44 ;Extra run subspeed ala shinesparkMorphHrEmp
        !SamusYspeed    = $0B2E
        !SamusYsubspeed = $0B2C

        !AccelMode  = $0B4A
        !MomentumFlag   = $0B3C
        
        !ZipRadius = $0008
    }

    {; Enemy defines
        !EnemyID = $0F78
        !EnemyIndex = $0E54
        !EnemyRadius = $0F82 ; X radius; should also be equal to Y radius
        !LochState  = $0FA8 ;AI var1, 0=Empty,1=Loading,2=Loaded
        !CannonDir  = $0FAA
        !CannonGrph = $0FAC
        !FireSpeeds = $0FAE
        !DonkongID = $F7D3

        ;Shifting position
        !ShiftDirection = $7E7800 ; $0b00, bits 1,2=Up,Down,,4/8=Left/Right
        !PosXspeed      = $7E7802
        !PosXsubspeed   = $7E7804
        !NegXspeed      = $7E7806
        !NegXsubspeed   = $7E7808
        !PosYspeed      = $7E780A
        !PosYsubspeed   = $7E780C
        !NegYspeed      = $7E780E
        !NegYsubspeed   = $7E7810

        !EnemyXpos = $0F7A
        !EnemyYpos = $0F7E
        !EnemyXsubpos = $0F7C
        !EnemyYsubpos = $0F80

        ;Init
        !EnemyTilemap   = $0F92 ;Set SSBD for shift speed, Bittests 
        !Param1     = $0FB4 ;Set XXYY speeds of Samus' exit
        !Param2     = $0FB6 ;Set XXYY speeds for shifting
    }

    {; Spritemap indices
     ; Samus:
        !SamusVrEnd  = $00 ;Front end of vertical barrel    
        !SamusVrEmp  = $02 ;Empty (No lights)
        !SamusVrLod  = $04 ;Loaded (red lights)

        !SamusHrEnd  = $20 ;Front end of vertical barrel    
        !SamusHrEmp  = $22 ;Empty (No lights)
        !SamusHrLod  = $24 ;Loaded (red lights)

        ;Diagonal indices are numbered from origin, 
        !SamusDgMain = $06 ;Most of the cannon, +$02 and +$20 for pieces
        !SamusDgR    = $1A ;Right edge, extends down
        !SamusDgB    = $0B ;Bottom edge, extends right
        !SamusDgLodL = $0A ;Red light, 'left' as if facing up
        !SamusDgLodR = $1B ;Red light, 'right' as if facing up
    }
}

lorom 
;===== Bank $90 =====
{
    org !free90 ;!90+!90UnusedSpace
        LochedControl:                
        {;Modifed locked state, pointer @ $0A42
            PHP : PHB : PHK : PLB : REP #$30
            JSR $E94B       ; Execute Samus movement handler
            JSR $8000       ; Animate Samus
            JSR $DCDD       ; Hud specific behavior, Projectiles
            JSL $90A91B     ; Update mini-map
            JSR $EA45       ; Pause check
            JSR $EA7F       ; Low health check
            JSR $EB02 
            PLB : PLP : RTL
        }

	!free90 #= pc()

}


;===== Bank $A2 =====
{
    org !freeA2	;!A2+!A2FreeSpace
    print pc, " - Init AI"    
    {; Initialization
        LDX !EnemyIndex

        LDA !EnemyTilemap,x : AND #$0F00 : STA !ShiftDirection,x ;Bits 1/2=Up/Down, 4/8=Left/Right
        LDA !Param1,x : STA !FireSpeeds,x ; Set Samus' exit velocity
        
        .setshiftspeeds
        {; Linear speeds table, uses Kraid extra variable space.
            LDA !Param2+$1,x : AND #$00FF
            ASL A : ASL A : ASL A : TAY
            LDA !LinSpds,y : STA !PosXspeed,x
            LDA !LinSbSpds,y : STA !PosXsubspeed,x
            LDA !LinSpds+$4,y : STA !NegXspeed,x
            LDA !LinSbSpds+$4,y : STA !NegXsubspeed,x

            LDA !Param2,x : AND #$00FF
            ASL A : ASL A : ASL A : TAY
            LDA !LinSpds,y : STA !PosYspeed,x
            LDA !LinSbSpds,y : STA !PosYsubspeed,x
            LDA !LinSpds+$4,y : STA !NegYspeed,x
            LDA !LinSbSpds+$4,y : STA !NegYsubspeed,x
        }    

        
        .setgraphics
        {; Set cannon direction and appropriate graphics index
            LDA !EnemyTilemap,x
            AND #$000F
            STA !CannonDir,x
            PHX : ASL A : ASL A
            STA !CannonGrph,x
            TAX : LDA DrawDonkong,x
            PLX : STA !EnemyTilemap,x
        }
    }

    print pc, " - Main AI"
    MainAI:
    {; Main 
        LDX !EnemyIndex
        .shifting
        {;barrel gunna move
            LDA !ShiftDirection,x : BEQ +
            LDA !Param2,x : BNE .shiftaround
            
         +  JMP .unloading 

            .shiftaround
            {
                LDA !ShiftDirection,x
                AND #$0400 : BNE .moveleft

                .moveright
                {
                    LDA !PosXsubspeed,x : STA $12
                    LDA !PosXspeed,x : STA $14
                    JSL !A0+!MoveEnemyX
                    BCC +
                    LDA !ShiftDirection,x
                    EOR #$0F00 ; If collision
                    STA !ShiftDirection,x
                    BRA +
                }
                .moveleft
                {
                    LDA !NegXsubspeed,x : STA $12
                    LDA !NegXspeed,x : STA $14
                    JSL !A0+!MoveEnemyX
                    BCC +
                    LDA !ShiftDirection,x
                    EOR #$0F00 ; If collision
                    STA !ShiftDirection,x
                }

             +  LDA !ShiftDirection,x 
                AND #$0100 : BNE .moveup 

                .movedown
                {
                    LDA !PosYsubspeed,x : STA $12
                    LDA !PosYspeed,x : STA $14
                    JSL !A0+!MoveEnemyY
                    BCC ++
                    LDA !ShiftDirection,x
                    EOR #$0F00 ; If collision
                    STA !ShiftDirection,x
                    BRA ++
                }
                .moveup
                {
                    LDA !NegYsubspeed,x : STA $12
                    LDA !NegYspeed,x : STA $14
                    JSL !A0+!MoveEnemyY
                    BCC ++
                    LDA !ShiftDirection,x
                    EOR #$0F00 ; If collision
                    STA !ShiftDirection,x
                }
            }  

     ++ .unloading
        {; Resets cannon for rentry
            LDA !LochState,x : BEQ .end

            LDA !EnemyRadius,x : ADC #$0008
            JSL !A0+!AtLeastX : BCS .ready
            ADC #$0010 ; Need more to be clear on Y
            JSL !A0+!AtLeastY : BCS .ready
            BRA .end 

            .ready
            +  STZ !LochState,x
        }

        .end
            RTL
    }

    print pc, " - Touch AI"
    TouchAI:
    {; Touch
     ; On touch, the cannon will hardset samus x/y to cannon x/y, then set samus' movement to 'in cannon' by hijacking unused movement type.
        LoadSamus:
        {; Move Samus into the cannon
            LDX !EnemyIndex
            LDA !LochState,x  : BEQ +
            BRA .loched ; When already loaded

          + LDA #!ZipRadius : STA $14 ; If within ZipRadius, lochs

            .checkdist
            {; Checks to see if Samus is fully loaded into the cannon
                JSL !A0+!AtLeastX : BCS .zip
                JSL !A0+!AtLeastY : BCS .zip
                BRA .loched
            }

            .zip
            {; Move Samus towards/into cannon to smooth entry
                STZ !SamusXspeed : STZ !SamusXsubspeed   ; Samus X speed, subspeed = 0
                STZ !SamusYspeed : STZ !SamusYsubspeed   ; Samus Y speed, subspeed = 0
                STZ !AccelMode : STZ !MomentumFlag   ; Acceleration mode, 'momentum' flag
                STZ !SamusFallFlag : STZ !SamusYDir ;Samus falling flag, Y direction 

                .zipx
                    LDA !SamusXpos : CMP $0F7A,x : BPL +
                    CLC : ADC $14 : BRA .zipy
                 +  SEC : SBC $14

                .zipy
                    STA !SamusXpos
                    LDA !SamusYpos : CMP $0F7E,x : BPL +
                    CLC : ADC $14 : BRA .endzip
                 +  SEC : SBC $14

                .endzip
                    STA !SamusYpos
                    RTL
            }

            .loched
            {; Loch-n-Load, Samus is ready to fire?
                LDA !LochState,x
                CMP #$0002 : BMI .ramrod
                RTL

                .ramrod
                    LDA !LochState,x : BNE .packed
                {; Finish setting Samus' states.
                    .packsamus
                    {; Samus to spinjumping pose
                        LDA #!Spinning : STA !SamusMoveType
                        ;LDA !CannonDir,x    ; Directions set as if projectile
                        LDA !SamusXDir : AND #$00FF : CLC : ADC #$0300
                        CMP #$0308 : BNE +
                        STA $0A22 ; Samus previous x direction/previous movetype; stops weird movement
                        LDA #!LochSamusPoseR  : BRA ++

                     +  STA $0A22
                        LDA #!LochSamusPoseL
                     ++ STA !SamusPose
                    }
                    
                    .fin
                        LDA #$0001 : STA !LochState,x
                        STZ $0B3E ;Turn off speedboosting
                        LDA #!InputRTS : STA !InputControl
                        LDA #LochedControl : STA !ControlPointer
                        LDA #!LochedMovement : STA !MovementHandler

                    .loadedgraphic
                        LDA !CannonGrph,x
                        CLC : ADC #$0002
                        PHX : TAX
                        LDA DrawDonkong,x 
                        PLX
                        STA !EnemyTilemap,x

                    .clicked
                        LDA #$0037 : JSL $809049
                }
                
                .packed
                {; State 1h
                    LDA !EnemyXpos,x : STA !SamusXpos ; Samus X = enemy X
                    LDA !EnemyYpos,x : STA !SamusYpos ; Samus Y = enemy Y
                    LDA !EnemyXsubpos,x : STA !SamusXsubpos ; Samus subpos X = enemy subpos x
                    LDA !EnemyYsubpos,x : STA !SamusYsubpos ; Samus subpos Y = enemy subpos Y
                    STZ !SamusXspeed : STZ !SamusXsubspeed   ; Samus X speed, subspeed = 0
                    STZ !SamusYspeed : STZ !SamusYsubspeed   ; Samus Y speed, subspeed = 0
                    STZ !AccelMode : STZ !MomentumFlag   ; Acceleration mode, 'momentum' flag
                    STZ !SamusFallFlag : STZ !SamusYDir ;Samus falling flag, Y direction

                    LDA !BriefInput
                    BIT !JumpBind : BNE .fire
                    BIT !DownBind  : BNE .exit ;\
                    ;BIT !JumpBind  : BNE .exit ;} Any binds wanted for exit
                    RTL
                }

                .exit 
                {; State 2h, fall out of cannon
                    LDA #$0002 : STA !LochState,x
                    STZ $0B3E
                    LDA #!InputNormal : STA !InputControl
                    LDA #!NormalControl  : STA !ControlPointer    ;\
                    LDA #!NormalMovement : STA !MovementHandler  ;} Restore control

                    ;Back to "empty" state
                    PHX : LDA !CannonGrph,x
                    TAX : LDA DrawDonkong,x
                    PLX : STA !EnemyTilemap,x

                    .releasesamus
                    {; Release from cannon as Samus falling
                        LDA #!Falling : STA !SamusMoveType
                        LDA !SamusXDir ;Samus x direction ; 8  = right, 4 = left
                        AND #$00FF : CMP #$0004 : BEQ +
                        LDA #!ReleasePoseR  : BRA ++

                     +  LDA #!ReleasePoseL
                     ++ STA !SamusPose
                        RTL
                    }

                }

                .fire ; State 3h, spin out of cannon with force
                {
                    STZ $0CD0 ; Clear beam charge counter to prevent shooting out of spinFireSpeedsparam / shoot immediately on landing w/o further pressing
                    LDA #$0003 : STA !LochState,x

                    LDA #!InputNormal : STA !InputControl
                    LDA #!NormalControl : STA !ControlPointer
                    LDA #!NormalMovement : STA !MovementHandler

                    ;Back to "empty" state
                    PHX : LDA !CannonGrph,x
                    TAX : LDA DrawDonkong,x
                    PLX : STA !EnemyTilemap,x

                    .speed
                    {; Set Samus' exit speed
                        
                        LDA !FireSpeeds+$1,x : AND #$00FF
                        STA !SamusXtraS

                        LDA !FireSpeeds,x : AND #$00FF
                        STA !SamusYspeed
                    }

                    .direction
                    {;Set Samus' direction by cannon direction
                        LDA !CannonDir,x
                        ASL A : TAX 

                        LDA SamusDirTable,x
                        AND #$FF00 : BEQ +
                        STA !SamusXDir-$1
                        BRA .y

                     +  LDA !SamusInput
                        BIT !LeftBind : BNE .verticalleft
                        BIT !RightBind : BNE .verticalright
                        BRA .y

                        .verticalright
                            LDA #$0008 : STA !SamusXDir-$1 ; Holding right on vertical cannon
                            STA $0A22 : STA $0A26 ; Sets old poses x direction; Trying to make vertical cannons give bluesuit regardless of left/right direction
                            BRA .y
                        
                        .verticalleft
                            LDA #$0004 : STA !SamusXDir-$1 ; Holding left on vertical cannon
                            STA $0A22 : STA $0A26 ; Sets old poses x direction; see above

                        .y
                            LDA SamusDirTable,x
                            AND #$00FF : STA !SamusYDir
                            LDA #$0001 : STA !SamusFallFlag

                        BRA whack ; Ran into an issue where I couldn't BRA .firesamus, "Label not found"

                        SamusDirTable: ; $XXYY
                            dw #$0001,#$0801,#$0802,#$0802,#$0002,#$0002,#$0402,#$0402,#$0401,#$0001
                            ;  0      1      2      3      4      5      6      7      8      9   
                        
                        whack:
                    }

                    .firesamus
                    {; Set Samus' pose by item equipped (Space Jump, Screw Attack) and X direction

                        LDA #!Spinning : STA !SamusMoveType
                        ; Tchaikovsky bless
                        LDA #$0004 : JSL $809049 ; "Shoot" super sound
                        LDA #$0007 : JSL $8090C1 ; "Exploded" super sound

                        LDA !EquippedItems
                        BIT #$0008 : BNE .screw
                        BIT #$0200 : BNE .space

                        .spin
                            LDA #$0030 : JSL $80902B ; Spinjump sound
                            LDA !SamusXDir ;Samus x direction ; 8  = right, 4 = left
                            AND #$00FF : CMP #$0004 : BEQ +
                            LDA #!FireSamusPoseR  : BRA ++

                         +  LDA #!FireSamusPoseL
                         ++ STA !SamusPose
                            BRA .fixposes

                        .space
                            LDA !SamusXDir ;Samus x direction ; 8  = right, 4 = left
                            AND #$00FF : CMP #$0004 : BEQ +
                            LDA #!FireSamusPoseR+2  : BRA ++

                         +  LDA #!FireSamusPoseL+2
                         ++ STA !SamusPose
                            BRA .fixposes

                        .screw
                            LDA #$0033 : JSL $80902B ; Screwjump sound
                            LDA !SamusXDir ;Samus x direction ; 8  = right, 4 = left
                            AND #$00FF : CMP #$0004 : BEQ +
                            LDA #!FireSamusPoseR+$68  : BRA ++

                         +  LDA #!FireSamusPoseL+$68
                         ++ STA !SamusPose
                            
                        .fixposes ; At this point, the pose is already loaded into A
                            STA $0A20 
                            STA $0A24 
                            STA $0A28 ;This allows speedkeep to maintain speed booster. idk
                            ;Comment this line to remove bluesuit.
                            LDA #$0401 : STA $0B3E ;to add speedbooster effect (contact damage, block destruction)
                            ;LDA #$0001 : STA $0B40 : LDA #$0003 : JSL $80914D ;Speedbooster sounds, bit awkaard with or w/o.
                            INC !MomentumFlag
                            RTL
                    }
                }
            }
        }
        
    }

    DrawDonkong: print pc, " - draw index"
        ; Draw states indexed by cannon direction for loaded, unloaded
        dw DS0,DS1,DS2,DS3,DS4,DS5,DS6,DS7,DS8,DS9,DS8,DS9,DSA,DSB,DSC,DSD,DSE,DSF,DS0,DS1
          ;0       1       2       3       4       5       6       7       8       9

    {;Draw lists
        DS0: dw $0001,SamusEmpU,$80ED,DS0
        DS1: dw $0001,SamusLodU,$80ED,DS1 
        DS2: dw $0001,SamusEmpUR,$80ED,DS2 
        DS3: dw $0001,SamusLodUR,$80ED,DS3
        DS4: dw $0001,SamusEmpR,$80ED,DS4
        DS5: dw $0001,SamusLodR,$80ED,DS5 
        DS6: dw $0001,SamusEmpDR,$80ED,DS6 
        DS7: dw $0001,SamusLodDR,$80ED,DS7 
        DS8: dw $0001,SamusEmpD,$80ED,DS8 
        DS9: dw $0001,SamusLodD,$80ED,DS9 
        DSA: dw $0001,SamusEmpDL,$80ED,DSA 
        DSB: dw $0001,SamusLodDL,$80ED,DSB 
        DSC: dw $0001,SamusEmpL,$80ED,DSC  
        DSD: dw $0001,SamusLodL,$80ED,DSD 
        DSE: dw $0001,SamusEmpUL,$80ED,DSE 
        DSF: dw $0001,SamusLodUL,$80ED,DSF  
    }

    Spritemaps:
    {
        {; Vertical Samus Donkong
            SamusEmpU:
                dw $0004
                db $F0,$81,$F0,!SamusVrEnd,$21  ; Top left
                db $00,$80,$F0,!SamusVrEnd,$61  ; Top Right
                db $F0,$81,$00,!SamusVrEmp,$21  ; Bottom Left
                db $00,$80,$00,!SamusVrEmp,$61  ; Bottom right

            SamusLodU:
                dw $0004
                db $F0,$81,$F0,!SamusVrEnd,$21  ; Top left
                db $00,$80,$F0,!SamusVrEnd,$61  ; Top Right
                db $F0,$81,$00,!SamusVrLod,$21  ; Bottom Left
                db $00,$80,$00,!SamusVrLod,$61  ; Bottom right

            SamusEmpD:
                dw $0004
                db $F0,$81,$00,!SamusVrEnd,$A1  ; Bottom Left
                db $00,$80,$00,!SamusVrEnd,$E1  ; Bottom right
                db $F0,$81,$F0,!SamusVrEmp,$A1  ; Top left
                db $00,$80,$F0,!SamusVrEmp,$E1  ; Top Right

            SamusLodD:
                dw $0004
                db $F0,$81,$00,!SamusVrEnd,$A1  ; Bottom Left
                db $00,$80,$00,!SamusVrEnd,$E1  ; Bottom right
                db $F0,$81,$F0,!SamusVrLod,$A1  ; Top left
                db $00,$80,$F0,!SamusVrLod,$E1  ; Top Right

        } 
        {; Horizontal Samus Donkong
            SamusEmpR:
                dw $0004
                db $F0,$81,$F0,!SamusHrEmp,$21  ; Top left
                db $00,$80,$F0,!SamusHrEnd,$21  ; Top Right
                db $F0,$81,$00,!SamusHrEmp,$A1  ; Bottom Left
                db $00,$80,$00,!SamusHrEnd,$A1  ; Bottom right

            SamusLodR:
                dw $0004
                db $F0,$81,$F0,!SamusHrLod,$21  ; Top left
                db $00,$80,$F0,!SamusHrEnd,$21  ; Top Right
                db $F0,$81,$00,!SamusHrLod,$A1  ; Bottom Left
                db $00,$80,$00,!SamusHrEnd,$A1  ; Bottom right

            SamusEmpL:
                dw $0004
                db $F0,$81,$F0,!SamusHrEnd,$61  ; Top left
                db $00,$80,$F0,!SamusHrEmp,$61  ; Top Right
                db $F0,$81,$00,!SamusHrEnd,$E1  ; Bottom Left
                db $00,$80,$00,!SamusHrEmp,$E1  ; Bottom right

            SamusLodL:
                dw $0004
                db $F0,$81,$F0,!SamusHrEnd,$61  ; Top left
                db $00,$80,$F0,!SamusHrLod,$61  ; Top Right
                db $F0,$81,$00,!SamusHrEnd,$E1  ; Bottom Left
                db $00,$80,$00,!SamusHrLod,$E1  ; Bottom right
        } 
        {; Diagonal Samus Donkong
            SamusEmpUR:
                dw $000A
                db $EC,$81,$EB,!SamusDgMain+$00,$21 ; Top left
                db $FC,$81,$EB,!SamusDgMain+$02,$21 ; Top Right
                db $EC,$81,$FB,!SamusDgMain+$20,$21 ; Bottom Left
                db $FC,$81,$FB,!SamusDgMain+$22,$21 ; Bottom right
                db $0C,$20,$F3,!SamusDgR+$00,$21    ; Right edge, top
                db $0C,$20,$FB,!SamusDgR+$10,$21    ; Right edge, mid
                db $0C,$20,$03,!SamusDgR+$20,$21    ; Right edge, bot
                db $F4,$21,$0B,!SamusDgB+$00,$21    ; Bot edge, left
                db $FC,$21,$0B,!SamusDgB+$01,$21    ; Bot edge, mid
                db $04,$20,$0B,!SamusDgB+$02,$21    ; Bot edge, right

            SamusLodUR:
                dw $000C
                db $F4,$21,$FB,!SamusDgLodL,$21     ; Red light
                db $FC,$21,$03,!SamusDgLodR,$21     ; Red light
                db $EC,$81,$EB,!SamusDgMain+$00,$21 ; Top left
                db $FC,$81,$EB,!SamusDgMain+$02,$21 ; Top Right
                db $EC,$81,$FB,!SamusDgMain+$20,$21 ; Bottom Left
                db $FC,$81,$FB,!SamusDgMain+$22,$21 ; Bottom right
                db $0C,$20,$F3,!SamusDgR+$00,$21    ; Right edge, top
                db $0C,$20,$FB,!SamusDgR+$10,$21    ; Right edge, mid
                db $0C,$20,$03,!SamusDgR+$20,$21    ; Right edge, bot
                db $F4,$21,$0B,!SamusDgB+$00,$21    ; Bot edge, left
                db $FC,$21,$0B,!SamusDgB+$01,$21    ; Bot edge, mid
                db $04,$20,$0B,!SamusDgB+$02,$21    ; Bot edge, right

            SamusEmpDR:
                dw $000A
                db $EC,$81,$03,!SamusDgMain+$00,$A1 ; Bot left
                db $FC,$81,$03,!SamusDgMain+$02,$A1 ; Bot Right
                db $EC,$81,$F3,!SamusDgMain+$20,$A1 ; Top Left
                db $FC,$81,$F3,!SamusDgMain+$22,$A1 ; Top right
                db $0C,$20,$03,!SamusDgR+$00,$A1    ; Right edge, bot
                db $0C,$20,$FB,!SamusDgR+$10,$A1    ; Right edge, mid
                db $0C,$20,$F3,!SamusDgR+$20,$A1    ; Right edge, top
                db $F4,$21,$EB,!SamusDgB+$00,$A1    ; Top edge, left
                db $FC,$21,$EB,!SamusDgB+$01,$A1    ; Top edge, mid
                db $04,$20,$EB,!SamusDgB+$02,$A1    ; Top edge, right

            SamusLodDR:
                dw $000C
                db $FC,$21,$F3,!SamusDgLodL,$A1     ; Red light
                db $F4,$21,$FB,!SamusDgLodR,$A1     ; Red light
                db $EC,$81,$03,!SamusDgMain+$00,$A1 ; Bot left
                db $FC,$81,$03,!SamusDgMain+$02,$A1 ; Bot Right
                db $EC,$81,$F3,!SamusDgMain+$20,$A1 ; Top Left
                db $FC,$81,$F3,!SamusDgMain+$22,$A1 ; Top right
                db $0C,$20,$03,!SamusDgR+$00,$A1    ; Right edge, bot
                db $0C,$20,$FB,!SamusDgR+$10,$A1    ; Right edge, mid
                db $0C,$20,$F3,!SamusDgR+$20,$A1    ; Right edge, top
                db $F4,$21,$EB,!SamusDgB+$00,$A1    ; Top edge, left
                db $FC,$21,$EB,!SamusDgB+$01,$A1    ; Top edge, mid
                db $04,$20,$EB,!SamusDgB+$02,$A1    ; Top edge, right
            SamusEmpDL:
                dw $000A
                db $04,$80,$03,!SamusDgMain+$00,$E1 ; Bot right
                db $F4,$81,$03,!SamusDgMain+$02,$E1 ; Bot left
                db $04,$80,$F3,!SamusDgMain+$20,$E1 ; Top right
                db $F4,$81,$F3,!SamusDgMain+$22,$E1 ; Top left
                db $EC,$21,$03,!SamusDgR+$00,$E1    ; Left edge, bot
                db $EC,$21,$FB,!SamusDgR+$10,$E1    ; Left edge, mid
                db $EC,$21,$F3,!SamusDgR+$20,$E1    ; Left edge, top
                db $04,$20,$EB,!SamusDgB+$00,$E1    ; Top edge, right
                db $FC,$21,$EB,!SamusDgB+$01,$E1    ; Top edge, mid
                db $F4,$21,$EB,!SamusDgB+$02,$E1    ; Top edge, left

            SamusLodDL:
                dw $000C
                db $04,$20,$FB,!SamusDgLodL,$E1     ; Red light
                db $FC,$21,$F3,!SamusDgLodR,$E1     ; Red light
                db $04,$80,$03,!SamusDgMain+$00,$E1 ; Bot right
                db $F4,$81,$03,!SamusDgMain+$02,$E1 ; Bot left
                db $04,$80,$F3,!SamusDgMain+$20,$E1 ; Top right
                db $F4,$81,$F3,!SamusDgMain+$22,$E1 ; Top left
                db $EC,$21,$03,!SamusDgR+$00,$E1    ; Left edge, bot
                db $EC,$21,$FB,!SamusDgR+$10,$E1    ; Left edge, mid
                db $EC,$21,$F3,!SamusDgR+$20,$E1    ; Left edge, top
                db $04,$20,$EB,!SamusDgB+$00,$E1    ; Top edge, right
                db $FC,$21,$EB,!SamusDgB+$01,$E1    ; Top edge, mid
                db $F4,$21,$EB,!SamusDgB+$02,$E1    ; Top edge, left
            
            SamusEmpUL:
                dw $000A
                db $04,$80,$EB,!SamusDgMain+$00,$61 ; Top right
                db $F4,$81,$EB,!SamusDgMain+$02,$61 ; Top left
                db $04,$80,$FB,!SamusDgMain+$20,$61 ; Bot right
                db $F4,$81,$FB,!SamusDgMain+$22,$61 ; Bot left
                db $EC,$21,$F3,!SamusDgR+$00,$61    ; Left edge, top
                db $EC,$21,$FB,!SamusDgR+$10,$61    ; Left edge, mid
                db $EC,$21,$03,!SamusDgR+$20,$61    ; Left edge, bot
                db $04,$20,$0B,!SamusDgB+$00,$61    ; Bot edge, right
                db $FC,$21,$0B,!SamusDgB+$01,$61    ; Bot edge, mid
                db $F4,$21,$0B,!SamusDgB+$02,$61    ; Bot edge, left

            SamusLodUL:
                dw $000C
                db $04,$20,$FC,!SamusDgLodL,$61     ; Red light
                db $FC,$21,$04,!SamusDgLodR,$61     ; Red light
                db $04,$80,$EB,!SamusDgMain+$00,$61 ; Top right
                db $F4,$81,$EB,!SamusDgMain+$02,$61 ; Top left
                db $04,$80,$FB,!SamusDgMain+$20,$61 ; Bot right
                db $F4,$81,$FB,!SamusDgMain+$22,$61 ; Bot left
                db $EC,$21,$F3,!SamusDgR+$00,$61    ; Left edge, top
                db $EC,$21,$FB,!SamusDgR+$10,$61    ; Left edge, mid
                db $EC,$21,$03,!SamusDgR+$20,$61    ; Left edge, bot
                db $04,$20,$0B,!SamusDgB+$00,$61    ; Bot edge, right
                db $FC,$21,$0B,!SamusDgB+$01,$61    ; Bot edge, mid
                db $F4,$21,$0B,!SamusDgB+$02,$61    ; Bot edge, left
        }

    }
    print pc, " - End of used space"
}

!freeA2 #= pc()