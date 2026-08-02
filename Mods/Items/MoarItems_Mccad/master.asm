lorom

;-----------------------------------------------------------------------------------------------MOAR ITEMS----------------------------------------------------------------------------------------------|
;MOAR ITEMS adds 3 new, unique upgrades to Super Metroid without overwriting or disabling any of the vanilla items, as well as PLMs to unlock them. The equipment bits are loaded to $7ED8AE.			|
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
;WAVE DASH: While spinjumping, hold run and double tap left or right to become temporarily invulerable and dash through enemies.																		|
;																																																		|
;HAMMERBALL: While in the morph ball, hold down and press 'Aim down' midair to preform an incredibly fast downward attack. Destroys speedbooster blocks and utilizes the shinespark contact damage index|
;																																																		|
;GAUSS MISSLES: A direct upgrade to your standard missiles. Greatly increases their travel speed and preforms 1.5X more damage.																			|
;																																																		|
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
;Credits: Written by MCCAD00 aka Tedicles. I cannot overstate my thanks to Smiley and PJboy, they've been a huge help to me as far as understanding how to get all of these items working. Without		|
;PJ's bank log, I would have absolutely 0 chance of being able to program any of this.																													|
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

;!Freespace82 = $82F70F ;This is vanilla's start of freespace in bank $90. Change this to your own freespace if you already put stuff at the end of bank $90. Only needs $8 bytes.
;!FreespaceCustomCode = $859643 ;All of the custom code has been placed into the freespace of bank $85. You can change this to whatever freespace you need if you dont have enough space there.
;!FreeSpaceB4 = $B4F4B8	;Used for custom sprite instructions and spritemaps
;!FreeSpace93 = $93F61D	;Unfortunately, we also need to use freespace in bank 93 to add more custom projectiles. Can repoint, but it must still be within bank 93
;!FreeSpace84 = $84EFD3	;Freespace is also used in bank 84, to add new item plms. Can repoint but it must be within bank 84

;;Main hijack, runs the custom code before processing samus's movement
ORG $828B47 : JSL !free82

ORG !free82 : JSL !free85 		;Process the custom code
JSL $A08EB6 : RTL								;Run the instruction overwritten by the hijack and then return
!free82 #= pc()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;-------------Variables---------------------------------------------------------| Uses vanilla's unused ram. Free free to change if you use any of these addresses
;Define				 ; Description    											|
;-------------------------------------------------------------------------------|
!VarWState = $7FFA02 ; Wave Dash State	(0000 idle, 0001 dash R, 0002 dash L)	|
!VarDirBttnQ = $7FFA04 ; Last pressed directional button (0001 right 0002 left)	|
!VarDirTime = $7FFA06 ; Timer for directional button queue						|
!VarPrevSX = $7FFA08 ; Samus's X position from the previous frame				|
!VarSpeedX = $7FFA0A ; Accurate version of samus's pixel speed					|
!VarMirXspd = $7FFA0C ; Mirror of samus's X speed								|
!VarMirSspd = $7FFA0E ; Mirror of samus's X subspeed								|
!VarMirXmom = $7FFA10 ; Mirror of samus's X momentum							|
!VarMirSmom = $7FFA12 ; Mirror of samus's X submomentum							|
!VarMirSmEqp = $7FFA34 ; Mirror of samus's equipped items						|
!VarStateHmB = $7FFA36 ; hammerball state. (0 inactive 1 active >1 completed)	|
;-------------Constants---------------------------------------------------------| 
;Define				 ; Description    											|
;-------------------------------------------------------------------------------|
!DashInputFr = #$0018 ; Amount of frames allowed for wave dash input			    |
!DashCooldn = #$0008 ; cooldown of wave dash in frames							|
!HamBalVelc = #$000C ; Hammer ball velocity										|
!GaussMDmg = #$0096 ; Gauss missile damage										|
!MSGWaveDsh = #$01 ; Wave dash message box index								|	;;; THE NEW ITEMS DO NOT HAVE CUSTOM MESSAGE BOXES!			
!MSGGaussMs	= #$01 ; Gauss missile message box index							|	;;; Adding the new message boxes for these items
!MSGHammer = #$01 ;Hammer ball message box index								|	;;; is up to you, and can be done with existing
;-------------------------------------------------------------------------------|	;;; resources somewhat easily.


ORG !free85 : PHP : PHB : PHX : PHY : PHK : PLB ;;;;;;;;;;Begin custom code

JSR WaveDash : JSR HammerBall		;Jump to each of the different custom item subroutines

PLY : PLX : PLB : PLP : RTL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End custom code

;WAVE DASH {	
WaveDash: 

 JSR GetStateWave : JSR StateCodeWave : JSR ButtonQueue 

ButtonQueue:
LDA $0AF6 : STA !VarPrevSX

LDA !VarWState : BNE +++																					;Only update the queue if the player isnt already dashing
LDA !VarDirTime : BEQ + : DEC A : STA !VarDirTime : BRA ++ : + : LDA #$0000 : STA !VarDirBttnQ			;If the queue timer is at 0, clear the queue. Otherwise, decrement the timer and continue
++ : LDA $8F : BIT $09B0 : BEQ + : LDA #$0001 : STA !VarDirBttnQ : LDA !DashInputFr : STA !VarDirTime 	;If the player presses right, store to the queue for defined amount of frames
+ : LDA $8F : BIT $09AE : BEQ +++ : LDA #$0002 : STA !VarDirBttnQ : LDA !DashInputFr : STA !VarDirTime	;If the player presses Left, store to the queue for defined amount of frames
+++ : RTS



GetStateWave:
LDA $7ED8AE : BIT #$0001 : BEQ ++					;Only check inputs if Wave Dash is equipped
LDA $8B : BIT $09B6 : BEQ ++							;Only check inputs if the run button is held
LDA $0A1F : AND #$00FF : CMP #$0003 : BNE ++		;Only check inputs if spinjumping
LDA $0AF6 : SEC : SBC !VarPrevSX : STA !VarSpeedX	;Calculate Samus's pixel speed

LDA $8F : BIT $09B0 : BEQ +							;If the player presses right on the DPAD
LDA !VarDirBttnQ : CMP #$0001 : BEQ SetStateWave		;While the button Q is set to right, set the state

+ : LDA $8F : BIT $09AE : BEQ ++					;If the player presses left on the DPAD
LDA !VarDirBttnQ : CMP #$0002 : BEQ SetStateWave		;While the button Q is set to right, set the state

++ : RTS
SetStateWave:
LDA !VarDirBttnQ : STA !VarWState : RTS					;Set the wave state to the direction



StateCodeWave:
LDA !VarWState : CMP #$5555 : BNE + : LDA #$0000 : STA !VarWState			;If the state is set to 5555 (default for this ram) set it to 0
+ : LDA !VarWState : BNE StateCodeWaveInit : RTS							;If the state is set, go to dash code
StateCodeWaveInit: LDA !VarDirTime : BNE + : JMP StateCodeWaveMain		;If the Directional time is unset, run the main asm
;;;Wave-Dash initialization;;;
+ : LDA #$0000 : STA !VarDirBttnQ : STA !VarDirTime						;Clear button check variables
LDA $0AF6 : SEC : SBC !VarPrevSX : STA !VarSpeedX					;Calculate Samus's pixel speed

+ : LDA #$001E : STA $18A8											;Set samus's invulnerability timer (also used as a timer for the move itself)
LDA #$0029 : JSL $80912F												;play a sound effect in library 3
LDA $0B42 : STA !VarMirXspd : LDA $0B44 : STA !VarMirSspd				;Create a mirror of samus's X speed
LDA $0B46 : STA !VarMirXmom : LDA $0B48 : STA !VarMirSmom			;Create a mirror of samus's Y speed

LDX #$0000																;Set the loop counter
- : CPX #$0020 : BEQ + : LDA WaveDashPalette,X : STA $7EC180,X	;Check the loop counter, change samus's palette
INX : INX : BRA -														;Increase the loop counter and loop

+ : LDA $09A2 : STA !VarMirSmEqp : AND #$FFF7 : STA $09A2			;Mirror samus's equipment and disable screw attack
;;;Wave-Dash main ASM;;;
StateCodeWaveMain: 
+ : LDA $18A8 : BEQ EndWaveDash															;Once the invulnerability timer is at 0, end the routine
LDA $8B : BIT $09B0 : BEQ + : LDA !VarWState : CMP #$0002 : BEQ EndWaveDash			;If you press right while going left, end the routine
+ : LDA $8B : BIT $09AE : BEQ + : LDA !VarWState : CMP #$0001 : BEQ EndWaveDash		;If you press left while going right, end the routine			
+ : LDA $0A1F : AND #$00FF : CMP #$0003 : BNE EndWaveDash : JMP WaveDashMainASM	;End routine if not spinjumping

EndWaveDash:															;;;Branch here to end wave dash
STZ $18A8																;Clear i frames
LDA #$0000 : STA !VarWState : STA !VarDirBttnQ : STA !VarDirTime		;Clear the associated variables
LDA !VarMirXspd : STA $0B42 : LDA !VarMirSspd : STA $0B44				;Reload samus's X speed
LDA !VarMirXmom : STA $0B46 : LDA !VarMirSmom : STA $0B48			;Reload samus's X momentum
JSL $91DEBA																;Reload samus's suit palette
LDA !VarMirSmEqp : STA $09A2											;Reload samus's equipment bits							
RTS																	;end routine

;execute this every frame otherwise
WaveDashMainASM: LDA $0AF6 : SEC : SBC !VarPrevSX : STA !VarSpeedX	;Calculate Samus's pixel speed
LDA !VarSpeedX : BPL + : EOR #$FFFF : INC							;Calculate samus's absolute value speed
+ : CMP #$000 : BPL + : STZ $18A8									;If her speed is below 2, cancel the dash
+ LDA !VarMirXspd : INC A : STA $0B42 									;Set samus's X speed
LDA !VarMirSspd : STA $0B44												;;Set samus's subpixel X speed
LDA !VarMirXmom : STA $0B46 : LDA !VarMirSmom : STA $0B48			;Set samus's X momentum	
STZ $0B2C : STZ $0B2E : STZ $0B32 : STZ $0B34						;Clear samus's Y speed ram	
STZ $0A6E																;Clear samus's contact damage
LDA $09DA : AND #$0003 : BNE +										;Only run every 4 frames:

LDA $0AF6 : STA $12 : LDA $0AFA : STA $14							;Setup a sprite's position
LDA #$003E : STA $16 : STZ $18 : JSL $B4BC26							;Spawn a sprite
	
+ : RTS																;Return

WaveDashPalette: DB $00,$6C,$07,$6C,$5C,$6D,$04,$7C,$80,$7D,$07,$7C,$3E,$7D,$71,$7C,$0D,$7C,$1A,$6C,$54,$6C,$0A,$6C,$11,$6C,$03,$7C,$13,$6C,$0C,$6C

;;;Hijacks {

CollisionHijackA: PHP : PHB : PHX : PHY : PHK : PLB
LDA !VarWState : BEQ + : STZ $18A8
+ : PLY : PLX : PLB : PLP
LDA #$9F55 : STA $0A6C : RTL	;Execute vanilla code and return

CollisionHijackB: PHP : PHB : PHX : PHY : PHK : PLB
LDA !VarWState : BEQ + : STZ $18A8
+ : PLY : PLX : PLB : PLP
STZ $14 : LDA $20 : RTL	;Execute vanilla code and return
;;; }

};

;HAMMERBALL {

HammerBall:

LDA $7ED8AE : BIT #$0004 : BNE + : JMP EndHMB

+ : LDA !VarStateHmB : CMP #$5555 : BNE + : LDA #$0000 : STA !VarStateHmB ;Zero out the hammerball state if its never been set

+ : LDA $0B00 : CMP #$0007 : BNE +	;Only check for inputs if samus is morphed (Y radius = 7)
LDA $0B36 : BEQ +						;Only check inputs if samus is in the air
LDA !VarStateHmB : BNE +				;Only check inputs if not already hammerballing

LDA $8B : BIT $09AC : BEQ +			;If samus is holding down
LDA $8F : BIT $09BC : BEQ +			;And presses shoot this frame

LDA #$0002 : STA $0B36					;Set samus to moving down
LDA !HamBalVelc : STA $0B2E			;set samus's vertical speed to !HamBalVelc
LDA #$0001 : STA !VarStateHmB			;Set the hammerball state
LDA #$0004 : STA $0B3F					;Set samus to bluesuit
LDA $0Af6 : STA $0AB0 : STA $0AB2		;Move echoes to samus
LDA $0AFA : STA $0AB8 : STA $0ABA		;Move echoes to samus
LDA #$0048 : JSL $8090CB				;Play a library 2 sound
LDA #$000F : JSL $80914D				;Play a library 3 sound

;;:Process hamemrball state

+ : LDA !VarStateHmB : BNE + : JMP EndHMB			;If unset, return
+ : CMP #$0001 : BEQ + : JMP BrnHMB				;If set, check if samus is still falling

+ : LDA !HamBalVelc : STA $0B2E						;Set verticle speed to !HamBalVelc
LDX $0A74 : LDA ShineSparkPalTable,X				;Load the shinespark palette depending on suit
TAX : LDX #$9E80 : JSR LoadPal						;set palette to shinespark
LDA #$0002 : STA $0A6E									;Set contact damage to shinespark
LDA $0B36 : CMP #$0002 : BEQ EndHMB					;If samus's state is falling down branch out
StopHMB: STZ $0B3F : LDA #$003C : STA !VarStateHmB	;Otherwise, clear bluesuit and set the State var to 8 (cooldown of 6 frames)
JSL $91DEBA												;Reload the suit palette
LDA $0Af6 : STA $0AB0 : STA $0AB2 : STA $12			;Move echoes to samus
LDA $0AFA : STA $0AB8 : STA $0ABA	 : STA $14			;Move echoes to samus
STZ $0AC0 : STZ $0AC2									;Zero echo speed
LDA #$0002 : STA $0B2E									;Lower samus's speed
LDA #$0016 : JSL $80914D								;Play a sound effect and return
LDA #$0011 : STA $16 : STZ $18						;Setup sprite
JSL $B4BC26												;Spawn the sprite
STZ $0A6E												;Clear contact damage
BrnHMB: LDA !VarStateHmB : CMP #$0002 : BEQ +		;If state is 2, set to 0
DEC A : STA !VarStateHmB : RTS						;Otherwise, decrement the state
+ : LDA #$0000 : STA !VarStateHmB						;Zero the state

EndHMB: RTS											;Return

;;;LoadPal: Copy of a routine in 91. Very very stupid.
LoadPal:
PHP : REP #$30 : PHB : PEA $9B00 : PLB : PLB
LDA $0000,X : STA $7EC180
LDA $0002,X : STA $7EC182
LDA $0004,X : STA $7EC184
LDA $0006,X : STA $7EC186
LDA $0008,X : STA $7EC188
LDA $000A,X : STA $7EC18A
LDA $000C,X : STA $7EC18C
LDA $000E,X : STA $7EC18E
LDA $0010,X : STA $7EC190
LDA $0012,X : STA $7EC192
LDA $0014,X : STA $7EC194
LDA $0016,X : STA $7EC196
LDA $0018,X : STA $7EC198
LDA $001A,X : STA $7EC19A
LDA $001C,X : STA $7EC19C
LDA $001E,X : STA $7EC19E
PLB : PLP : RTS

ShineSparkPalTable: DW $9C80,$9E80,$A080
; }

;GAUSS MISSLES {
CreateGaussMissile:	;;;Runs from the projectile initialization routine in $93. Checks if the projectile is a missile, and then checks for the Gauss missile item bits. If so, manually set to dataset 4.
CPY #$0002 : BNE + 												;If not missiles, return
LDA $7ED8AE : BIT #$0002 : BEQ +									;If gauss missiles are not equipped, branch out
LDY #$0008 														;Load dataset 4 (#$0008)
+ : LDA $83F1,Y : TAY : RTL										;Run vanilla code and return

SpeedupGaussY: PHA : LDA $0C18,X : CMP #$8100 : BNE ++		;Check the projectile type for missile
LDA $7ED8AE : BIT #$0002 : BEQ ++								;If gauss missiles are not equipped, branch out
LDA $0BF0,X : BMI +												;If its a missile, check the Y speed.
LDA #$0C00 : STA $0BF0,X : PLA : JSL $94A4D9 : RTL				;If positive, set speed to #$0800
+ : LDA #$F4FF : STA $0BF0,X : PLA : JSL $94A4D9 : RTL			;If negative, set speed to #$F800
++ : PLA : JSL $94A4D9 : RTL										;If its not a missile, dont change anything

SpeedupGaussX: PHA : LDA $0C18,X : CMP #$8100 : BNE ++		;Check the projectile type for missile
LDA $7ED8AE : BIT #$0002 : BEQ ++								;If gauss missiles are not equipped, branch out
LDA $0BDC,X : BMI +												;If its a missile, check the X speed.
LDA #$0C00 : STA $0BDC,X : PLA : JSL $94A46F : RTL				;If positive, set speed to #$0800
+ : LDA #$F4FF : STA $0BDC,X : PLA : JSL $94A46F : RTL			;If negative, set speed to #$F800
++ : PLA : JSL $94A46F : RTL										;If its not a missile, dont change anything

SpeedupGaussYDiag: PHA : LDA $0C18,X : CMP #$8100 : BNE ++	;Check the projectile type for missile
LDA $7ED8AE : BIT #$0002 : BEQ ++								;If gauss missiles are not equipped, branch out
LDA $0BF0,X : BMI +												;If its a missile, check the Y speed.
LDA #$0800 : STA $0BF0,X : PLA : JSL $94A4D9 : RTL				;If positive, set speed to #$0800
+ : LDA #$F7FF : STA $0BF0,X : PLA : JSL $94A4D9 : RTL			;If negative, set speed to #$F800
++ : PLA : JSL $94A4D9 : RTL										;If its not a missile, dont change anything

SpeedupGaussXDiag: PHA : LDA $0C18,X : CMP #$8100 : BNE ++	;Check the projectile type for missile
LDA $7ED8AE : BIT #$0002 : BEQ ++								;If gauss missiles are not equipped, branch out
LDA $0BDC,X : BMI +												;If its a missile, check the X speed.
LDA #$0800 : STA $0BDC,X : PLA : JSL $94A46F : RTL				;If positive, set speed to #$0800
+ : LDA #$F7FF : STA $0BDC,X : PLA : JSL $94A46F : RTL			;If negative, set speed to #$F800
++ : PLA : JSL $94A46F : RTL										;If its not a missile, dont change anything

SoundFXGauss: PHA : CPX #$0002 : BNE + 						;Check for a missile
LDA $7ED8AE : BIT #$0002 : BEQ +									;If gauss missiles are not equipped, branch out
LDA #$001f : JSL $80914D : PLA : RTL								;If so, play a library 3 sound
+ : PLA : JSL $809049 : RTL										;Otherwise, play the normal sound effect

!free85 #= pc()

ORG $938038 : JSL CreateGaussMissile

ORG $90AFCA : JSL SpeedupGaussY
ORG $90AFD2 : JSL SpeedupGaussXDiag
ORG $90AFD8 : JSL SpeedupGaussYDiag
ORG $90AFE0 : JSL SpeedupGaussX

ORG $90BEEF : JSL SoundFXGauss 		;BEEF

ORG $9383F9 : DW GaussMissleData	;Add Gauss missles to the projectile data list

;org $93ac19 ;supposedly unused
;GM_D_sprite: DW $0004 : DB $FC,$01,$EF,$DB,$AA, $FC,$01,$F7,$DA,$AA, $FC,$01,$FF,$D9,$AA, $FC,$01,$07,$D8,$AA
;GM_DL_sprite: DW $0004 : DB $FA,$01,$00,$DC,$AA, $FA,$01,$F8,$DD,$AA, $01,$00,$F8,$DE,$AA, $01,$00,$F0,$DF,$AA
;GM_L_sprite: DW $0004 : DB $F0,$01,$FC,$D4,$2A, $F8,$01,$FC,$D5,$2A, $00,$00,$FC,$D6,$2A, $08,$00,$FC,$D7,$2A		

;org $93ACFC ;also supposedly unused
;GM_UL_sprite: DW $0004 : DB $FA,$01,$F6,$DC,$2A, $FA,$01,$FE,$DD,$2A, $01,$00,$FE,$DE,$2A, $01,$00,$06,$DF,$2A		


ORG !free93
GaussMissleData:
DW !GaussMDmg 		;Damage
DW GaussMissleU		;Up, facing right
DW GaussMissleUR		;Up-right
DW GaussMissleR		;Right
DW GaussMissleDR		;Down-right
DW GaussMissleD		;Down, facing right
DW GaussMissleD		;Down, facing left
DW GaussMissleDL		;Down-left
DW GaussMissleL		;Left
DW GaussMissleUL		;Up-left
DW GaussMissleU		;Up, facing left

;;;Instruction lists

GaussMissleU: DW $000F,GM_U_sprite : DB $04,$04 : DW $0000		
				DW $8239,GaussMissleU
GaussMissleUR: DW $000F,GM_UR_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleUR
GaussMissleR: DW $000F,GM_R_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleR
GaussMissleDR: DW $000F,GM_DR_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleDR
GaussMissleD: DW $000F,GM_D_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleD
GaussMissleDL: DW $000F,GM_DL_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleDL
GaussMissleL: DW $000F,GM_L_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleL
GaussMissleUL: DW $000F,GM_UL_sprite : DB $04,$04 : DW $0000
				DW $8239,GaussMissleUL
				
;;;Spritemaps

GM_U_sprite: DW $0004 : DB $FC,$01,$EF,$D8,$2A, $FC,$01,$F7,$D9,$2A, $FC,$01,$FF,$DA,$2A, $FC,$01,$07,$DB,$2A
GM_UR_sprite: DW $0004 : DB $FF,$01,$F6,$DC,$6A, $FF,$01,$FE,$DD,$6A, $F8,$01,$FE,$DE,$6A, $F8,$01,$06,$DF,$6A
GM_R_sprite: DW $0004 : DB $F0,$01,$FC,$D7,$6A, $F8,$01,$FC,$D6,$6A, $00,$00,$FC,$D5,$6A, $08,$00,$FC,$D4,$6A
GM_DR_sprite: DW $0004 : DB $FF,$01,$00,$DC,$EA, $FF,$01,$F8,$DD,$EA, $F8,$01,$F8,$DE,$EA, $F8,$01,$F0,$DF,$EA
GM_D_sprite: DW $0004 : DB $FC,$01,$EF,$DB,$AA, $FC,$01,$F7,$DA,$AA, $FC,$01,$FF,$D9,$AA, $FC,$01,$07,$D8,$AA
GM_DL_sprite: DW $0004 : DB $FA,$01,$00,$DC,$AA, $FA,$01,$F8,$DD,$AA, $01,$00,$F8,$DE,$AA, $01,$00,$F0,$DF,$AA
GM_L_sprite: DW $0004 : DB $F0,$01,$FC,$D4,$2A, $F8,$01,$FC,$D5,$2A, $00,$00,$FC,$D6,$2A, $08,$00,$FC,$D7,$2A		
 GM_UL_sprite: DW $0004 : DB $FA,$01,$F6,$DC,$2A, $FA,$01,$FE,$DD,$2A, $01,$00,$FE,$DE,$2A, $01,$00,$06,$DF,$2A		
!free93 #= pc()			
; }


ORG $9498DC : JSL CollisionHijackA : NOP : NOP
ORG $948F49 : JSL CollisionHijackB
ORG $A0A096 : NOP : NOP : NOP		;Prevents screw attack from disabling the dash
ORG $B4BC69 : LDA SpriteListRePoint,Y

;;;Custom Sprites {
ORG !freeB4
;Wave dash particle instructions
WaveDashParticleInst:
	DW $0002, WaveDashPart00
	DW $0002, WaveDashPart00A
	DW $0002, WaveDashPart01
	DW $0002, WaveDashPart01A
	DW $0002, WaveDashPart02
	DW $0002, WaveDashPart02A
	DW $0002, WaveDashPart03
	DW $0002, WaveDashPart03A
	DW $BD07
;Wave dash particle spritemaps
WaveDashPart00: DW $0004 : DB $F8,$01,$F8,$D0,$3A, $00,$00,$F8,$D0,$7A, $F8,$01,$00,$D0,$BA, $00,$00,$00,$D0,$FA
WaveDashPart00A: DW $0004 : DB $F8,$01,$F6,$D0,$3A, $00,$00,$F6,$D0,$7A, $F8,$01,$FE,$D0,$BA, $00,$00,$FE,$D0,$FA
WaveDashPart01: DW $0004 : DB $F8,$01,$F5,$D1,$3A, $00,$00,$F5,$D1,$7A, $F8,$01,$FD,$D1,$BA, $00,$00,$FD,$D1,$FA
WaveDashPart01A: DW $0004 : DB $F8,$01,$F6,$D1,$3A, $00,$00,$F6,$D1,$7A, $F8,$01,$FE,$D1,$BA, $00,$00,$FE,$D1,$FA
WaveDashPart02: DW $0004 : DB $F8,$01,$F8,$D2,$3A, $00,$00,$F8,$D2,$7A, $F8,$01,$00,$D2,$BA, $00,$00,$00,$D2,$FA
WaveDashPart02A: DW $0004 : DB $F8,$01,$FA,$D2,$3A, $00,$00,$FA,$D2,$7A, $F8,$01,$02,$D2,$BA, $00,$00,$02,$D2,$FA
WaveDashPart03: DW $0004 : DB $F8,$01,$FB,$D3,$3A, $00,$00,$FB,$D3,$7A, $F8,$01,$03,$D3,$BA, $00,$00,$03,$D3,$FA
WaveDashPart03A: DW $0004 : DB $F8,$01,$FA,$D3,$3A, $00,$00,$FA,$D3,$7A, $F8,$01,$02,$D3,$BA, $00,$00,$02,$D3,$FA

SpriteListRePoint:
DW $BE5A,$BE6C,$BE86,$BEA4,$BEBE,$BED4,$BEEA,$BF04,$BF12,$BF1C,$BF32,$BF44,$BF56,$BF8E,$BFA0,$BFB2,$BFC4,$BFD2,$C014,$C026,$C040,$C05E,$C080,$C0FE,$C10C,$C132,$C154,$C176,$BF68,$BF74,$C198,$C1AC,$C1C0,$C1D4,$C1E8,$C1FC,$C210,$C224,$C238,$C258,$C2A0,$C2BC,$C304,$C30A,$C33E,$C35C,$C37A,$BE54,$C390,$C3A2,$C3BA,$C436,$C4B6,$C536,$C5B2,$C5C6,$C5D8,$C5DE,$C5E4,$C608,$C61C,$BE24 ;Vanilla sprites
DW WaveDashParticleInst	;Custom sprites
!freeB4 #= pc()
ORG $9AEC00 : INCBIN gfx.bin
;;; }

;;;Item Plms {

ORG !free84	;;;PLM ENTRIES
DW $EE64,PLMWaveDashInst				;Wave dash item plm
DW $EE8E,PLMBlockWaveDashInst		;Wave dash item plm (Shot block)
DW $EE64,PLMOrbWaveDashInst			;Wave dash item plm (Chozo orb)
DW $EE64,PLMGaussInst				;Gauss missile item plm
DW $EE8E,PLMBlockGaussInst			;Gauss missile item plm (Shot block)
DW $EE64,PLMOrbGaussInst				;Gauss missile item plm (Chozo orb)
DW $EE64,PLMHammerInst				;Hammerball item plm
DW $EE8E,PLMBlockHammerInst			;Hammerball item plm (Shot block)
DW $EE64,PLMOrbHammerInst			;Hammerball item plm (Chozo orb)


PLMWaveDashInst:	;;;Wave dash item plm instructions
DW $8764,$9300 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,WDEnd											;Go to end if room arg is set
DW $8A24,WDCollect,$86C1,$DF89							;Run if item collected
WDDraw: DW $E04F,$E067,$8724,WDDraw						;Draw item
WDCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0001 : DB !MSGWaveDsh						;Set equipment bit, display message box
WDEnd: DW $8724,$DFA9										;End

PLMBlockWaveDashInst:	;;;Wave dash block plm instructions
DW $8764,$9300 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
WDBShot: DW $8A2E,$E007									;Call item shot block instructions
DW $887C,WDBEnd											;Go to end if room arg is set
DW $8A24,WDBCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
WDBDraw: DW $E04F,$E067,$8724,WDBDraw					;Draw item
DW $873F,WDBDraw,$8A2E,$E020,$8724,WDBShot				;Do shot block shit
WDBCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0001 : DB !MSGWaveDsh						;Set equipment bit, display message box
WDBEnd: DW $8A2E,$E032									;Shot block reconcealing
DW $8724,$DFA9												;End

PLMOrbWaveDashInst:	;;;Wave dash orb plm instructions
DW $8764,$9300 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,WDOEnd											;Go to end if room arg is set
DW $8A2E,$DFAF,$8A2E,$DFC7								;Do chozo orb shit
DW $8A24,WDOCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
WDODraw: DW $E04F,$E067,$8724,WDODraw					;Draw item
WDOCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0001 : DB !MSGWaveDsh						;Set equipment bit, display message box
WDOEnd: DW $8724,$DFA9									;End

PLMGaussInst:	;;;Gauss missile item plm instructions
DW $8764,$9200 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,GMEnd											;Go to end if room arg is set
DW $8A24,GMCollect,$86C1,$DF89							;Run if item collected
GMDraw: DW $E04F,$E067,$8724,GMDraw						;Draw item
GMCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0002 : DB !MSGGaussMs							;Set equipment bit, display message box
GMEnd: DW $8724,$DFA9										;End

PLMBlockGaussInst:	;;;Gauss missile block plm instructions
DW $8764,$9200 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
GMBShot: DW $8A2E,$E007									;Call item shot block instructions
DW $887C,GMBEnd											;Go to end if room arg is set
DW $8A24,GMBCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
GMBDraw: DW $E04F,$E067,$8724,GMBDraw					;Draw item
DW $873F,GMBDraw,$8A2E,$E020,$8724,GMBShot				;Do shot block shit
GMBCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0002 : DB !MSGGaussMs							;Set equipment bit, display message box
GMBEnd: DW $8A2E,$E032									;Shot block reconcealing
DW $8724,$DFA9												;End

PLMOrbGaussInst:	;;;Gauss missile orb plm instructions
DW $8764,$9200 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,GMOEnd											;Go to end if room arg is set
DW $8A2E,$DFAF,$8A2E,$DFC7								;Do chozo orb shit
DW $8A24,GMOCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
GMODraw: DW $E04F,$E067,$8724,GMODraw					;Draw item
GMOCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0002 : DB !MSGGaussMs							;Set equipment bit, display message box
GMOEnd: DW $8724,$DFA9									;End

PLMHammerInst:	;;;Hammer ball item plm instructions
DW $8764,$9100 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,HBEnd											;Go to end if room arg is set
DW $8A24,HBCollect,$86C1,$DF89							;Run if item collected
HBDraw: DW $E04F,$E067,$8724,HBDraw						;Draw item
HBCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0004 : DB !MSGHammer							;Set equipment bit, display message box
HBEnd: DW $8724,$DFA9										;End

PLMBlockHammerInst:	;;;Hammer ball block plm instructions
DW $8764,$9100 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
HBBShot: DW $8A2E,$E007									;Call item shot block instructions
DW $887C,HBBEnd											;Go to end if room arg is set
DW $8A24,HBBCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
HBBDraw: DW $E04F,$E067,$8724,HBBDraw					;Draw item
DW $873F,HBBDraw,$8A2E,$E020,$8724,HBBShot				;Do shot block shit
HBBCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0004 : DB !MSGHammer							;Set equipment bit, display message box
HBBEnd: DW $8A2E,$E032									;Shot block reconcealing
DW $8724,$DFA9												;End

PLMOrbHammerInst:	;;;Hammer ball orb plm instructions
DW $8764,$9100 : DB $00,$00,$00,$00,$00,$00,$00,$00		;Load the item GFX
DW $887C,HBOEnd											;Go to end if room arg is set
DW $8A2E,$DFAF,$8A2E,$DFC7								;Do chozo orb shit
DW $8A24,HBOCollect,$86C1,$DF89							;Run if item collected
DW $874E : DB $16											;Timer = 16h
HBODraw: DW $E04F,$E067,$8724,HBODraw					;Draw item
HBOCollect: DW $8899,$8BDD : DB $02						;Set room arg, play fanfare
DW SetBit,$0004 : DB !MSGHammer							;Set equipment bit, display message box
HBOEnd: DW $8724,$DFA9									;End

SetBit:
LDA $1234
LDA $7ED8AE : ORA $0000,Y : STA $7ED8AE					;Set the item to equipped
LDA #$0168 : JSL $82E118									;Play room music after 6 seconds
LDA $0002,Y : AND #$00FF : JSL $858080					;Display message box
INY : INY : INY : RTS									;Y += 3

!free84 #= pc()

ORG $899100 : incbin itemgfx.bin

;;; }

;org $949526
;JSR IgnoreWalls : NOP
;org $94953D
;JSR IgnoreWallsVertical : NOP

org !free94
print "free94 moar: ", pc

;holy shit this actually works but need to do vertical too
IgnoreWalls:
PHA ;save A for later (it will become X). 
LDA !VarWState : BEQ +
DEX #2	;decrement X (by 2 because of course)
LDA $7F0002,x : AND #$F000 : BNE + ;branch if not air
INX #4 : LDA $7F0002,x : AND #$F000 : BNE + ;x = current block + 1 (well 2 but you get it), load that block and test if its air.
PLA : RTS ;skipp the collision routine
+
PLA : TAX : JSR ($94D5,x) : RTS	;do normal code
IgnoreWallsVertical:
PHA : LDA !VarWState : BEQ +
PLA : RTS ;skipp the collision routine
+
PLA : TAX : JSR ($94F5,x) : RTS	;do normal code
!free94 #= pc()
print "free94 moar: ", pc


;org $A098BF
;JSR WavyProjectile

;org $A08F40
;JSR WavyEnemy

org !freeA0
WavyEnemy:
LDA !VarWState : BEQ +
LDA $0F86,x : ORA #$0400 : RTS
+ LDA $0F86,x : RTS
WavyProjectile:
LDA !VarWState : BEQ +
LDA $1BD7,x : AND #$DFFF : RTS
+ LDA $1BD7,x : RTS
!freeA0 #= pc()