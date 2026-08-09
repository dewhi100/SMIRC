lorom
;Camera rework, By Tundain.

;TODO: put mode code into !disableManualCamera == 0 blocks. space to be saved

;this patch rewrites how the camera (AKA the "main scrolling routine") works.
;the main changes are:
;-Moonfall scrolling issues fixed. If samus moves too quickly, the camera won't move as quickly as samus, but instead catch up to her at it's maximum speed
;-door entering scrolling fix. Doors will only allow samus to enter if the camera is properly aligned to a screen edge.
;-Manual mode, while holding select, pressing run will toggle manual mode. While in manual mode, samus has control over the camera, but must stay within samus's reach. This also freezes time, so you are safe from any dangers.
;-the camera always scrolls, even if samus isn't moving, so you don't have to wiggle to move the camera if samus is at the edge of the screen.
;-remove slow grapple scrolling code

;This patch, thx to making some routines obsolete, doesn't use any freespace in bank $90 and banck $80!!!

;FREESPACE! find some space in their respective banks
;!Bank94Freespace = $94B200;-door block collision checks
;!Bank88Freespace = $88EE40; fx display correctly
;!Bank82Freespace = $82F710 ; door transition cancels manual mode
;!BankB0freespace = $B0EE00 ; corner sprites during manual mode gfx

;user define
!ManualSpeed = #$0008 ; speed at which to move when in manual mode, maximum is #$0010, higher will cause scrolling issues.

;---Code defines----------
!CameraXpos = $0911
!CameraYpos = $0915
!maxspeed = #$0011 ; max distance in pixels samus can move in a frame without issues +1
!maxscrollspeed = #$0010 ; max speed camera can move without issues


;-Used RAM--- if a different patch that you're using uses these addresses already, find some other unused RAM addresses, and change the ones here. Search here for unused RAM addresses--> https://patrickjohnston.org/ASM/Lists/Super%20Metroid/RAM%20map.asm
!CameraModeIndex = $0594
!catchingupflags = $07EF



;-------------------------------------------------------------------------------------------------
;------------------------------BANK $90-----------------------------------------------------------
;----------------------main scrolling routine-------------------------------------------

;hijack
org $90EB3B ;don't draw samus if she's off-screen (now that possibility is considered)
JMP checkoffscreen

org $90B6B2
BRA $03

;-----------------------------------------
;------MAIN SCROLLING ROUTINE-------------
org $9094EC 
PHB : PHK : PLB
JSR calcHor : JSR calcVer ; prepare speeds samus moved +1
LDX !CameraModeIndex
JSR (cameramodes,x) ;  execute current camera mode
LDA $07E9 : BEQ +
LDA #$01D0 : CMP $0915 : BCC +
STA $0915
+
LDA $0AF6 : STA $0B10 : LDA $0AF8 : STA $0B12 : LDA $0AFA : STA $0B14 : LDA $0AFC : STA $0B16 ; update previous samus's positions
PLB : RTL
;-----------------------------------------
;-----------------------------------------

cameramodes:
DW default,catchingup,controlling

default:   ; default is the only mode that allows manual mode acces
LDA $0A78 : BNE +
JSR horizontalscroll : JSR verticalscroll  
JSL checkcatchingup_speed 
if !disableManualCamera == 0
BCS + ;     conditions for entering manual mode: 
else
BRA +
endif
LDA $079F : CMP #$0006 : BEQ +          ; -don't be in ceres
JSL cameramodetoggle : BEQ +             ; - press the correct buttons
LDA $0A44 : CMP #$E725 : BNE +          ; -don't already be in a locked state
LDA $0A7A : BNE +                       ; - xray is inactive
LDA $0CEE : BNE +                       ; -no powerbombs are active
LDA $0998 : CMP #$0008 : BNE +          ; gamestate must be main gameplay
LDA #$0039 : JSL $80903F 
LDA #$E713 : STA $0A42 : LDA #$E8DC : STA $0A44 : LDA #$0004 : STA !CameraModeIndex : INC !Freezetime; lock samus, set camera index, freeze time
JSL loadcornergfx
LDA #$8000 : TRB $1C23 ; disable plms
LDA #$8000 : TRB $198D ; disable projectiles
JSL $90AD22 ; clear samus projectiles (to prevent cursed-looking beams, also kills missiles/supers)
+
RTS

; runs the required catching up routine (vertical or horizontal, or both)
catchingup:
LDA !catchingupflags : BIT #$0001 : BEQ +
JSL catchinguphor
+
LDA !catchingupflags : BIT #$0002 : BEQ +
JSL catchingupver
+
LDA !catchingupflags : BNE +
STZ !CameraModeIndex
+
RTS

controlling: ; this routine lives in bank $80
if !disableManualCamera == 0
JSL controlmode
endif
RTS

;---------------------------------------------
;handle horizontal scrolling
horizontalscroll:
LDA $0A7A : BEQ +
RTS
+
LDA $0A1E : AND #$00FF : BEQ + : STA $12 
LDA $0A52 : BNE backwards
LDA $0A1F : AND #$00FF : CMP #$0010 : BEQ backwards
LDA $0B4A : CMP #$0001 : BEQ backwards
LDA $12 : CMP #$0004 : BEQ left
BRA right
backwards:
LDA $12 : CMP #$0008 : BEQ left

right:
LDX $0941 : LDA $0AF6 : SEC : SBC rightDistance,x : STA $0B0A
BRA mergehor

left:
LDX $0941 : LDA $0AF6 : SEC : SBC leftDistance,x : STA $0B0A

mergehor:
CMP !CameraXpos : BEQ + : BMI scrolleft
LDA $090F : CLC : ADC $0DA4 : STA $090F
LDA !CameraXpos : ADC $0DA2 : STA !CameraXpos
JSL $80A641
BRA +
scrolleft:
LDA $090F : SEC : SBC $0DA4 : STA $090F
LDA !CameraXpos : SBC $0DA2 : STA !CameraXpos
JSL $80A6BB
+
RTS
;---------------------------------------------
;handle vertical scrolling
verticalscroll:
LDA $0B36 : CMP #$0001 : BEQ up
LDA $0AFA : SEC : SBC $07AD : STA $0B0E
BRA mergever
up:
LDA $0AFA : SEC : SBC $07AF : STA $0B0E

mergever:
CMP !CameraYpos : BEQ + : BMI scrollup
LDA $0913 : CLC : ADC $0DA8 : STA $0913
LDA !CameraYpos : ADC $0DA6 : STA !CameraYpos
JSL $80A893
BRA +
scrollup:
LDA $0913 : SEC : SBC $0DA8 : STA $0913
LDA !CameraYpos : SBC $0DA6 : STA !CameraYpos
JSL $80A936
+
RTS 

;---------------------------------------------
;calculates horizontal distance samus moved +1
calcHor:
LDA $0AF6 : CMP $0B10
BMI .negative
LDA $0AF8 : SEC : SBC $0B12 : STA $0DA4
LDA $0AF6 : SBC $0B10 : INC : STA $0DA2
BRA +
.negative:
LDA $0B12 : SEC : SBC $0AF8 : STA $0DA4
LDA $0B10 : SBC $0AF6 : INC : STA $0DA2
+
RTS
;---------------------------------------------
;calculates vertical distance samus moved +1
calcVer:
LDA $0AFA : CMP $0B14
BMI .negative
LDA $0AFC : SEC : SBC $0B16 : STA $0DA8
LDA $0AFA : SBC $0B14 : INC : STA $0DA6
BRA +
.negative:
LDA $0B16 : SEC : SBC $0AFC : STA $0DA8
LDA $0B14 : SBC $0AFA : INC : STA $0DA6
+
RTS

rightDistance:
DW $0060,$0040,$0020,$00E0
leftDistance:
DW $00A0,$0050,$0020,$00E0

checkoffscreen: ; if samus is off-screen, don't draw her
JSL checkposition : BCS +
JSR $EB4B
+
JMP $EB3E

print "end $90: ",pc
;thx to recycling now unused code in $80, we barely place bank $90 code within the old main scrolling routine, and don't use any freespace in $90, hurray
warnpc $90973E

org $91816F ; remove dead code that would cause a crash when unlocking from station whilst manual mode is active
PHP : REP #$30
JSR $81A9
PLP : RTS

;---------------------------------------------------------------------------------------------------------------------------
;---------------------------------BANK $80----------------------------------------------------------------------------------
;-----------------some routines are moved here due to some space becoming free, so we don't use any free space in $90-----

; hijacks to prevent scrolling correction routine from capping camera position if in manual mode
org $80A64E
JMP checkcameramoderight

org $80A6C8
JMP checkcameramodeleft

org $80A8D7
JMP checkcameramodedown

org $80A943
JMP checkcameramodeup

org $80A3AB; change check for udpdating bg columns/rows to a different address, this allows bg scrolls to get updated even if time is frozen, without xray issues
LDA $0A82

;----Two routines in bank $80 become unused now, so we use that space to avoid using freespace---

org $80A528 ; checks if the screen is aligned to allow a door transition
Checkfordoorpermission_Hor:
LDA !CameraXpos : AND #$FF00 : CMP !CameraXpos
RTL


;---------CATCHING UP TO SAMUS ROUTINES----------------- the conditions for stopping to catch up, are: samus must be within the screen, and not moving too quickly
;---------horizontally---------
catchinguphor:
LDA $0DA2 : CMP !maxspeed : BPL +
JSL checkposition : BCC donehor 
+
LDA !CameraXpos : CLC : ADC #$0080 : CMP $0AF6 : BMI rightscrolling ; compare center of screen to samus x
LDA !CameraXpos : SEC : SBC !maxscrollspeed : STA !CameraXpos : RTL ;else keep scrolling left


rightscrolling:
LDA !CameraXpos : CLC : ADC !maxscrollspeed :  STA !CameraXpos : RTL; else keep scrolling right

donehor:
LDA !catchingupflags : AND #$0002 : STA !catchingupflags ; reset catching up hor flag
RTL
;---------vertically----------
catchingupver:
LDA $0DA6 : CMP !maxspeed : BPL +
JSL checkposition : BCC donever
+
LDA $0B36  : CMP #$0001 : BNE downscrolling ; check samus y direction
LDA !CameraYpos : SEC : SBC !maxscrollspeed : STA !CameraYpos : RTL ;else keep scrolling left

downscrolling:
LDA !CameraYpos : CLC : ADC !maxscrollspeed : STA !CameraYpos : RTL ; else keep scrolling right

donever:
LDA !catchingupflags : AND #$0001 : STA !catchingupflags ; reset catching up ver flag
exit:
RTL

;--------------------------------------
checkposition: ; carry clear if samus is in screen, set if crossed a boundary
LDA $0915 : CMP $0AFA : BPL + ; check upper boundary
CLC : ADC #$0100 : CMP $0AFA : BMI + ; lower boundary
LDA $0911 : CMP $0AF6 : BPL + ; left boundary
CLC : ADC #$0100 : CMP $0AF6 : BMI + ; right boundary
CLC : RTL
+
SEC : RTL
;---------if camera mode on, don't cap the camera position to the ideal position
checkcameramoderight:
STA $0939
LDA !CameraModeIndex : BNE +
JMP $A651
+
JMP $A662

checkcameramodeleft:
STA $0939
LDA !CameraModeIndex : BNE +
LDA !CameraXpos
JMP $A6CB
+
JMP $A6D9
;-------------------------------------
;---------------------------------------------
;---CATCHING UP TRIGGER CHECKS---------------
;checks if needs to start catching based on distance samus travelled this frame ; carry clear if none, set if one of both
checkcatchingup_speed:
LDA $0DA2
CMP !maxspeed : BMI +
LDA #$0002 : STA !CameraModeIndex : LDA !catchingupflags : ORA #$0001 : STA !catchingupflags : SEC : BRA ++
+
CLC
++
LDA $0DA6
CMP !maxspeed : BMI +
LDA #$0002 : STA !CameraModeIndex : LDA !catchingupflags : ORA #$0002 : STA !catchingupflags : SEC
+
RTL

checkcameramodedown:
STY $0933
LDA !CameraModeIndex : BNE +
JMP $A8DA
+
JMP $A8EB

;----------------------------------------------
cameramodetoggle: ; checks if the required buttons are held to enter/exit camera mode
LDA $8B : BIT $09BA : BEQ +
LDA $8F : BIT $09B6
+
RTL

warnpc $80A641

;-----------------------------------------------
;--------------------------------------------------------------------------


org $80A731; -------control mode--------

if !disableManualCamera == 0	
{
controlmode:
PHB : PHK : PLB
JSL checkcatchingup_speed : BCS ++ 
JSL cameramodetoggle : BEQ + 
++
LDA #$0039 : JSL $80903F
LDA #$8000 : TSB $1C23
LDA #$8000 : TSB $198D
JSL cancelcontrol ; reset scroll mode, unlock samus, unfreeze time, and reload beam gfx
PLB : RTL
+
LDY #$0000
-
LDX sprites,y
LDA $0000,x : STA $14 : LDA $0002,x : STA $12 : PHY : LDY $0004,x : PHB : PEA $B000 : PLB : PLB : LDA #$0A00 : STA $16 : JSL $81879F : PLB : PLY ; add corner sprites to screen
INY #2 : CPY #$0008 : BMI -
+
LDA !ManualSpeed : STA $0DA2 : STA $0DA6
LDA $8B : AND #$0F00 : XBA : ASL : TAX 
JMP (scrolls,x)

sprites:
DW upperleft,upperright,lowerright,lowerleft

upperleft:
DW $0010,$002C,UpperleftCorner
upperright:
DW $00F0,$002C,UpperrightCorner
lowerright:
DW $00F0,$00D4,LowerrightCorner
lowerleft:
DW $0010,$00D4,LowerleftCorner
}
endif
;directional input combinations are used as index for all eight possible movement directions
scrolls:
DW .return,.right,.left,.return,.down,.downright,.downleft,.down,.up,.upright,.upleft,.up,.return,.right,.left,.return


.downright:
JSR movedown
BRA .right

.upright:
JSR moveup

.right:
JSR moveright

.return:
PLB : RTL

.downleft:
JSR movedown
BRA .left

.upleft:
JSR moveup

.left:
JSR moveleft : PLB : RTL

.down:
JSR movedown : PLB : RTL

.up:
JSR moveup : PLB : RTL

moveright:
LDA !CameraXpos : SEC : ADC #$0008 : CMP $0AF6 : BPL + ; move downwards as long as samus is on-screen
LDA !CameraXpos : CLC : ADC !ManualSpeed : STA !CameraXpos
JSL $80A641
+
RTS

moveleft:
LDA !CameraXpos : CLC : ADC #$00FC : CMP $0AF6 : BMI + ; move upwards as long as samus is on-screen
LDA !CameraXpos : SEC : SBC !ManualSpeed : STA !CameraXpos
JSL $80A6BB
+
RTS

movedown:
LDA !CameraYpos : CLC : ADC #$0018 : CMP $0AFA : BPL + ; move downwards as long as samus is still on-screen
LDA !CameraYpos : CLC : ADC !ManualSpeed : STA !CameraYpos
JSL $80A893
+
RTS

moveup:
LDA !CameraYpos : CLC : ADC #$00DC : CMP $0AFA : BMI + ; move upwards as long as samus is on-screen
LDA !CameraYpos : SEC : SBC !ManualSpeed : STA !CameraYpos
JSL $80A936
+
RTS

checkcameramodeup:
STA $0939
LDA !CameraModeIndex : BNE +
LDA !CameraYpos
JMP $A946
+
JMP $A954

warnpc $80A893

;----------------------------------------------------
;--------------BANK $88------------------------------

; tweaks to make it so FX effects ignore time is frozen flag
org $88DA55
BRA $02
org $88DB44
BRA $02
org $88B0CE
NOP #2
org $88B3BA
BRA $02
org $88C498
BRA $02
org $88D9AF
BRA $02

;---hijacks to make liquids don't move, but still draw at the right height when manual mode is on------
org $88B382
JMP checkfreezerise_acid

org $88B3C6
JSR checkfreezetide

org $88C458
JMP checkfreezerise_water

org $88C4A6
JSR checkfreezetide

org !free88	;!Bank88Freespace
checkfreezerise_acid:
LDA !Freezetime : BNE +
JSR $B21D
JMP $B385
+
RTS

checkfreezerise_water:
LDA !Freezetime : BNE +
JSR $868C
JMP $C45B
+
RTS

checkfreezetide:
PHA
LDA !Freezetime : BNE +
JSR $B2C9
+
PLA : RTS

!free88 #= pc()

;--------------------------------
;-----------------------------------------------------------------

;----------BANK $B0-----------------------------------------------
;--------Camera corners gfx and spritemaps-------------
if !disableManualCamera == 0

org !freeB0	;!BankB0freespace
INCBIN "cameraview.bin"

UpperleftCorner:
DW $0005
DB $F4,$01,$F8,$30,$30
DB $FC,$01,$F8,$31,$30
DB $04,$00,$F8,$32,$30
DB $F4,$01,$08,$33,$30
DB $F4,$01,$00,$34,$30

UpperrightCorner:
DW $0005
DB $04,$00,$F8,$30,$70
DB $FC,$01,$F8,$31,$30
DB $F4,$01,$F8,$32,$70
DB $04,$00,$08,$33,$70
DB $04,$00,$00,$34,$70

LowerrightCorner:
DW $0005
DB $04,$00,$00,$30,$F0
DB $04,$00,$F8,$34,$F0
DB $04,$00,$F0,$33,$F0
DB $FC,$01,$00,$31,$F0
DB $F4,$01,$00,$32,$F0

LowerleftCorner:
DW $0005
DB $F4,$01,$00,$30,$B0
DB $F4,$01,$F8,$34,$B0
DB $F4,$01,$F0,$33,$B0
DB $FC,$01,$00,$31,$B0
DB $04,$00,$00,$32,$B0

!freeB0 #= pc()

endif
;-----------------------------
;------------------------------------------------


;------------BANK $94-----------------------------------------------------------------------------
;-----------door tile stuff to prevent scrolling glitches if entering door with bad camera position

org $2*9+$9494D5 : dw CheckDoorFlagH
org $2*9+$9494F5 : dw rewrittenVerDoor

org $94B14B
JMP grappleattach

org $9493CE
rewrittenVerDoor:
LDA #$E17D : STA $099C
JSR findDoor : BPL + ; if elevator door, ignore screen scroll check
LDA $0998 : CMP #$0009 : BEQ +++
JSR Checkfordoorpermission_Ver : BNE ++ ; if regular door, check if screen is aligned first
+++
STX $078D
LDA #$0009 : STA $0998
CLC : RTS
+
LDA $0A1C : CMP $0009 : BCS ++ 
LDA #$0001 : STA $0E16
++
JMP $8F82
warnpc $949411

org !free94	;!Bank94Freespace ; execute door transition if screen is aligned to scroll edge, else treat door tiles as solid
CheckDoorFlagH:
JSL Checkfordoorpermission_Hor : BEQ +
LDA $0998 : CMP #$0009 : BEQ + ; game state check bc you get to hit doors multiple times
JMP $8F49 ; samus block collision reaction - horizontal - solid
+
JMP $938B ; samus block collision reaction - horizontal - door

findDoor: ; finds the door for vertical door collision, used in subroutine to avoid having to write it twice
LDX $0DC4 : LDA $7F6401,x : AND #$FF00 : XBA : STA $078F : AND #$007F : ASL : ADC $07B5 : TAX : LDA $8F0000,x : TAX : LDA $830000,x
RTS

Checkfordoorpermission_Ver:
LDA $0A44 : CMP #$E8EC : BEQ ++
LDA $0B02 : CMP #$0002 : BEQ +
LDA !CameraYpos : AND #$FF00 : ORA #$001F : CMP !CameraYpos : RTS
+
LDA !CameraYpos : AND #$FF00 : CMP !CameraYpos
++
RTS

grappleattach:
LDA !CameraYpos : CMP $0D0C : BPL +
CLC : ADC #$0100 : CMP $0D0C : BMI +
LDX $0590 : JMP $B14E
+
RTS

!free94 #= pc()

;----------------------------------------------------
;----------------------------------------------------


;--------------------BANK $82---------------------------------------------------------------------
;-------------door transition auto cancels manual mode, and unpausing reloads corner gfx if needed-
org $82E4AA
JSR cancelmanual

org !free82	;!Bank82Freespace
cancelmanual:
JSR $DFD1
JSL cancelcontrol ; cancel manual mode in case the player barely managed to trigger it just as they hit a door block
RTS

cancelcontrol:
STZ !CameraModeIndex : LDA #$E695 : STA $0A42 : LDA #$E725 : STA $0A44 : STZ !Freezetime : JSL $90AC8D
LDA $0D32 : CMP #$C4F0 : BEQ +
LDA #$0002 : JSL $90ACF0 ; if grapple does smth, load ice beam instead
+
RTL

loadcornergfx: ; load camera gfx into beam gfx
LDX $0330 : LDA #$00A0 : STA $D0,x : LDA #$EE00 : STA $D2,x : LDA #$B0B0 : STA $D4,x : LDA #$6300 : STA $D5,x : TXA : CLC : ADC #$0007 : STA $0330
RTL

!free82 #= pc()

;------------------------
;------------------------------------

org $A09069 ; change branch so you still end up at instruction processing even if time is frozen for AI processing
BEQ +

org $A090A6
LDA #$0000
+

org $A0C2A0
JSR checkfortime

org !freeA0	;$A0F800
checkfortime:
PHA
LDA !Freezetime : BNE +
PLA : ADC #$0004 : RTS
+
PLA : RTS

!freeA0 #= pc()

org $80CB2B
DW $DF45,$AB58,$0000,$0000,$0000,$0000,$0000

