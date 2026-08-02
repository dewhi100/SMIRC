;An advanced, as-yet-unreleased version of Oi27's instant pickups patch.
;Way cooler, as it lets you choose what kind of fanfare you want, per item.
;options include vanilla, instant (as per the patch on metconst), message box with custom sounds (look futher down in the file)
;oh, and an option for message box the first time you pick up a tank, but instant for all the others of the same kind.

;as it is, all three PLM types for a given item do the same thing.
;you can either add more "routine" params, or just treat them as defaults and override them when you call the macros by passing whatever

;----------INSTANT-PICKUPS-----------------
;!80Free = $80DA00
;!83Free = $83F720
;!84Free = $84EFD3
;!85Free = $859643

;sadly, labels donr work in IF statements. so, use params
!REPLACEFANF := !free84
!INSTAPICK := !free84+2
!VANILLAFANF = $848BDD		;for debugging. broken anyway due to other changes in this patch

;Possible values: VANILLAFANF, INSTAPICK, REPLACEFANF
!energyRoutine = !INSTAPICK
!reserveRoutine = !INSTAPICK
!missileRoutine = !INSTAPICK
!superMissileRoutine = !INSTAPICK
!powerBombRoutine = !INSTAPICK

!equipmentRoutine = !REPLACEFANF	;common to ALL equipment pickups
!grappleRoutine = !REPLACEFANF
!xrayRoutine = !REPLACEFANF	
!beamsRoutine = !REPLACEFANF		;common to ALL beam pickups

;!universalAmmoRoutine = !REPLACEFANF	;if using Tundain's universal ammo

macro fanfareTanks(mode, idx)	;vanilla fanfare code. idx is 2 bytes message box index
	if <mode> == !INSTAPICK
		NOP #14
	else
		LDA #$0168 		;\
		JSL $82E118		; Play room music track after 6 seconds
		LDA.w #<idx>		;
		JSL $858080		;/	
	endif
endmacro

macro fanfareBeamsItems(mode)	;vanilla msg box code used for beams and non-hud items
	if <mode> == !VANILLAFANF
	LDA #$0168
	JSL $82E118
	else
	NOP #7
	endif
	if <mode> == !INSTAPICK
		NOP #10
	else
		LDA $0002,y		;\
		AND #$00FF 		; Display message box [[Y] + 2]
		JSL $858080		;/
	endif
endmacro

macro fanfareHudRoutine(mode, idx) ;idx = message box index
	NOP #7
	if <mode> == !INSTAPICK
		NOP #7
	else
		LDA.w #<idx>
		JSL $858080
	endif
endmacro

macro plmData(mode, idx)
	dw $8899
	dw <mode>
	if <mode> == !INSTAPICK
		db <idx>
	else
		db $02
	endif
endmacro

;!msgRam = $0B0C	;Unused RAM, high byte is used to store the message to flash, low byte is the timer.
;!ammoFlags = $09F0	;Unused SRAM for first-ammo flags to store to.
!charcount = #$0007	;The number of characters in each message. You could increase this to #$0009 if your hack doesn't use reserve tanks, or more than that if you made the ammo icons smaller.	
!charcount2 = #$000E	;The number of characters in each message, times two for indexing purposes. 
!flashtime = #$0078	;Number of frames to flash the message for.
{;Letter Defines for Instant Pickup HUD messenger
!A = $E0
!B = $E1
!C = $E2
!D = $E3
!E = $E4
!F = $E5
!G = $E6
!H = $E7
!I = $E8
!J = $E9
!K = $EA
!L = $EB
!M = $EC
!N = $ED
!O = $EE
!P = $EF
!Q = $F0
!R = $F1
!S = $F2
!T = $F3
!U = $F4
!V = $F5
!W = $F6
!X = $F7
!Y = $F8
!Z = $F9
!SB = $4E ;this is for a space/blank tile
}
}
;------------------------------------------
;Fanfare or no fanfare can be chosen for certain sets of items:
;-Normal Equipment
;-Beams
;-Grapple
;-Xray
;-Energy Tanks
;-Missiles
;-Supers
;-Power Bombs
;-Reserve Tanks

;Each of these have their own pickup routine. To re-add fanfare, 
;-comment them out from the "instant pickups" 
;-uncomment the vanilla version in "normal fanfare"
;For vanilla behavior, this comment/uncomment must be done for all normal, chozo, and shotblock variants of the item.

;----------------------------------------------------

		;pickup routines: $0E bytes each, $11 for equip/beams
		{
			;Ammo:
			{
			org $848975		;Energy Tanks
			%fanfareTanks(!energyRoutine, !EnergyTankMessageIndex)

			if !ReserveTankBugfixes_Nodever2 == 0
			org $848998		;Reserve Tanks
			%fanfareTanks(!reserveRoutine, !ReserveTankMessageIndex)
			else
			org $84899B		;Reserve Tanks
				if !energyRoutine == !INSTAPICK	;intentionally using the energy routine. see below.
					NOP #11
				else
					LDA #$0168
					JSL $82E118
					LDA.w #<!ReserveTankMessageIndex>
				endif
				JMP $8983		;makes reserves do whatever e-tanks do, but thats the price you pay for compatability and no freespace usage
			endif
			

			org $8489C1		;Missile Tanks
			%fanfareTanks(!missileRoutine, !MissileTankMessageIndex)
			
			org $8489EA		;Super Missile Tanks
			if !SupersNeedMains_Dewhi100 == 0
			%fanfareTanks(!superMissileRoutine, !SuperMissileTankMessageIndex)
			else
				if !superMissileRoutine == !INSTAPICK
					NOP #14
				else
					LDA #$0168
					JSL $82E118
					JSR PickMessage	;from Supers Need Mains
					JSL $858080
				endif
			endif

			org $848A13		;Power Bomb Tanks
			%fanfareTanks(!powerBombRoutine, !PowerBombTankMessageIndex)
			
			}
			;Majors:
			{
			org $8488DE		;Beams
			%fanfareBeamsItems(!beamsRoutine)
			
			org $848905		;Normal Equipment
			%fanfareBeamsItems(!equipmentRoutine)

			org $848930		;Grapple
			%fanfareHudRoutine(!grappleRoutine, !GrappleMessageIndex)

			org $848957		;Xray
			%fanfareHudRoutine(!xrayRoutine, !XRayMessageIndex)
			}
		}
		;instruction lists:
		{
		;Energy Tank
		org $84E0B1	;normal
		%plmData(!energyRoutine, $00)
		org $84E46D	;Chozo orb
		%plmData(!energyRoutine, $00)
		org $84E938	;hidden
		%plmData(!energyRoutine, $00)

		;Missile Tank
		org $84E0D6	;normal
		%plmData(!missileRoutine, $01)
		org $84E49F	;Chozo orb
		%plmData(!missileRoutine, $01)
		org $84E970	;hidden
		%plmData(!missileRoutine, $01)

		;Super Tank
		org $84E0FB	;normal
		%plmData(!superMissileRoutine, $02)
		org $84E4D1	;Chozo orb
		%plmData(!superMissileRoutine, $02)
		org $84E9A8 ;hidden
		%plmData(!superMissileRoutine, $02)

		;Power Bomb Tank
		org $84E120	;normal
		%plmData(!powerBombRoutine, $03)
		org $84E503	;Chozo orb
		%plmData(!powerBombRoutine, $03)
		org $84E9E0	;hidden
		%plmData(!powerBombRoutine, $03)

		;Bombs
		org $84E14D	;normal
		%plmData(!equipmentRoutine, $04)
		org $84E53D	;Chozo orb
		%plmData(!equipmentRoutine, $04)
		org $84EA20	;hidden
		%plmData(!equipmentRoutine, $04)

		;Charge
		org $84E17B	;normal
		%plmData(!beamsRoutine, $05)
		org $84E578	;Chozo orb
		%plmData(!beamsRoutine, $05)
		org $84EA61	;hidden
		%plmData(!beamsRoutine, $05)
		
		;Ice Beam
		org $84E1A9	;normal
		%plmData(!beamsRoutine, $06)
		org $84E5B3	;Chozo orb
		%plmData(!beamsRoutine, $06)
		org $84EAA2	;hidden
		%plmData(!beamsRoutine, $06)

		;Hi-Jump
		org $84E1D7	;normal
		%plmData(!equipmentRoutine, $07)
		org $84E5EE	;Chozo orb
		%plmData(!equipmentRoutine, $07)
		org $84EAE3	;hidden
		%plmData(!equipmentRoutine, $07)

		;Speed Booster
		org $84E205	;normal
		%plmData(!equipmentRoutine, $08)
		org $84E629	;Chozo Orb
		%plmData(!equipmentRoutine, $08)
		org $84EB24	;hidden
		%plmData(!equipmentRoutine, $08)

		;Wave Beam
		org $84E233	;normal
		%plmData(!beamsRoutine, $09)
		org $84E66D	;Chozo orb
		%plmData(!beamsRoutine, $09)
		org $84EB65	;hidden
		%plmData(!beamsRoutine, $09)

		;Spazer Beam
		org $84E261	;normal
		%plmData(!beamsRoutine, $0A)
		org $84E6A8	;Chozo Orb
		%plmData(!beamsRoutine, $0A)
		org $84EBA6	;hidden
		%plmData(!beamsRoutine, $0A)

		;Springball
		org $84E28F	;normal
		%plmData(!equipmentRoutine, $0B)
		org $84E6E3	;Chozo orb
		%plmData(!equipmentRoutine, $0B)
		org $84EBE7	;hidden
		%plmData(!equipmentRoutine, $0B)

if !M2anim_Oi27 == 0
		;Varia Suit
		org $84E2C1	;normal
		%plmData(!equipmentRoutine, $0C)
		org $84E71E	;Chozo orb
		%plmData(!equipmentRoutine, $0C)
		org $84EC28	;hidden
		%plmData(!equipmentRoutine, $0C)
endif

		;Gravity Suit
		org $84E2F6	;normal
		%plmData(!equipmentRoutine, $0D)
		org $84E760	;Chozo orb
		%plmData(!equipmentRoutine, $0D)
		org $84EC70	;hidden
		%plmData(!equipmentRoutine, $0D)

		;X-Ray
		org $84E32B	;normal
		%plmData(!xrayRoutine, $0E)
		org $84E7A2	;Chozo orb
		%plmData(!xrayRoutine, $0E)
		org $84ECB8	;hidden
		%plmData(!xrayRoutine, $0E)

		;Plasma Beam
		org $84E358	;normal
		%plmData(!beamsRoutine, $0F)
		org $84E7DC	;Chozo orb
		%plmData(!beamsRoutine, $0F)
		org $84ECF8	;hidden
		%plmData(!beamsRoutine, $0F)

		;Grapple
		org $84E386	;normal
		%plmData(!grappleRoutine, $10)
		org $84E817	;Chozo orb
		%plmData(!grappleRoutine, $10)
		org $84ED39	;hidden
		%plmData(!grappleRoutine, $10)

		;Space Jump
		org $84E3B3	;normal
		%plmData(!equipmentRoutine, $11)
		org $84E851	;Chozo orb
		%plmData(!equipmentRoutine, $11)
		org $84ED79	;hidden
		%plmData(!equipmentRoutine, $11)

		;Screw Attack
		org $84E3E1	;normal
		%plmData(!equipmentRoutine, $12)
		org $84E88C	;Chozo orb
		%plmData(!equipmentRoutine, $12)
		org $84EDBA	;hidden
		%plmData(!equipmentRoutine, $12)

		;Morph Ball
		org $84E40F	;normal
		%plmData(!equipmentRoutine, $13)
		org $84E8C7	;Chozo orb
		%plmData(!equipmentRoutine, $13)
		org $84EDFB	;hidden
		%plmData(!equipmentRoutine, $13)

		;Reserve Tank
		org $84E43D ;normal
		%plmData(!reserveRoutine, $14)
		org $84E902	;Chozo orb
		%plmData(!reserveRoutine, $14)
		org $84EE3C	;hidden
		%plmData(!reserveRoutine, $14)
		
		}

;---------------Reduced Fanfare----------------------
org $858490	;Reduce message box duration for items.
LDX #$0030

org $858469	;hijack message box opener for sound effect
JSR PICKUPSOUND

org !free85 ;!85Free
PICKUPSOUND:	;Pick [A] sound off of table, return [A] and [X] same as before routine.
JSR $859B	;Code overwritten
PHA : PHX
LDA $1C1F	;message box index
ASL : TAX : LDA .soundtable,x
BIT #$0100 : BNE .lib2
BIT #$0200 : BNE .lib3
.lib1
AND #$00FF
JSL $809021	: BRA .out	;Play Lib1 Sound
.lib2
AND #$00FF
JSL $8090A3	: BRA .out	;Play Lib2 Sound
.lib3
AND #$00FF
JSL $809125				;Play Lib3 Sound
.out
PLX : PLA
RTS
;High byte is sound library:
;00 = lib1
;01 = lib2
;02 = lib3
.soundtable	;each equipment can have its own sound; recycles message box indices
;        Etank        Supers        Grapple        Varia          Morph       Hijump         Speed          Ice         Spazer          Bombs  Mapdata     AmmoStat    SaveComp       GravSuit  Unused       Unused                                                                                                                       
;  No$00   |   Missile   |     PBs     |     Xray    |    Spring   |    Screw    |    Space    |    Charge   |    Wave     |    Plasma   |      | EnergyStat  |  SaveStat   |  ResTank    |      |    Unused   |    
;  |       |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |    
dw $0000,  $0101, $0106, $016D, $0103, $0005, $0217, $012F, $0170, $015C, $010B, $021D, $002A, $020F, $0017, $020A, $0028, $0026, $0126, $0108, $0000, $0000, $0000, $0000, $0000, $020D, $010D, $0000, $0000, $0000

!free85 #= pc()

;----------------------------------------------------

org !free84 ;!84Free	;Freespace in $84.

REPLACEFANF:	;Replacement to skip $8BDD fanfare instuction.
INY
RTS

INSTAPICK:
JSR FIRSTAMMO	;do this first because if 1st ammo, all the instapick stuff is skipped.
PHX  
;So, in the current config with REDUCED fanfare, the ammo and Rtanks are the only thing that uses this.
LDA $0000,y : AND #$00FF : XBA : ADC !flashtime : STA !msgRam	;\
																;/Retrieves what message to flash from PLM instruction. Lives in high byte of timer.
;Uncomment to re-add a unique instpick sfx for ammo/etanks
;		;Or, play a special sfx for each type.
;		LDA $0000,y : AND #$00FF : BEQ .energy
;		CMP #$0004 : BPL .clack	
;		;Goto clack if message index greater than 3
;
;		.ammo
;		LDA #$0003 : BRA .lib2
;		.energy
;		LDA #$0001
;		.lib2
;		JSL $8090A3
;		BRA .out

;Default to the clack sound. Used by Rtanks.
.clack
LDA #$000D
.lib3
JSL $809139	;lib3
.out
PLX 
INY
RTS

FIRSTAMMO:
;Since I like the possibility of starting with ammo, this should be its own flag
;!ammoFlags = 0000 0000 000R PSME
;input [Y] = instruction pointer

;But first, a special exception for reserve tanks
LDA $0000,y : AND #$00FF : CMP #$0014 : BNE +
	LDA #$0004 : BRA .resTanksEX
+
CMP #$0004 : BPL .notammo
.resTanksEX
PHA : PHX

	;In here: check our flags to see if it should do this or instant pick
	ASL A : TAX
	LDA !ammoFlags : BIT .flagtable,x : BNE .fixstack
	;Branch fails so mark that ammo as collected
	ORA .flagtable,x : STA !ammoFlags

PLX : PLA
;[A] = instant message index, which happens to coincide with the first few real message boxes.
INC A	;fix for base 0 vs. base 1
CMP #$0005 : BNE +
LDA #$0019	;get reserve tank message box
+
JSL $858080
INY	;Skip arg for instpick to not break inst list.
PLA	;pull the first return address
RTS	;Return all the way to the PLM handler

.flagtable
dw $0001	;energy 
dw $0002 	;missile
dw $0004 	;super
dw $0008 	;powerbomb
dw $0010	;reserves

.fixstack
PLX : PLA
.notammo			;If not ammo, do the instapick routine always. Tundain's ammo tanks trigger this too, because I (dewhi) am too lazy to put logic in like the reserves have.
.out
RTS

!free84 #= pc()

;------------------Display PLM Message-------------------------
org $828957	;hijack of main game loop
JSR MESSENGER82	

org !free82 ;!83Free		;Freespace in $82. Can be anywhere but calls locally from bank 82
MESSENGER82:
PHK
PLB
STZ $0590		;original code replaced by JSR
STZ $071D		;/
LDA !msgRam : AND #$00FF : BEQ QUIT


	PHX : PHY


	LDA #$0000 : TAX : TAY
	LDA !msgRam : AND #$FF00 : XBA : JSR MULTBY7 : TAY	;Get message location
	-							;\
	LDA IMESSAGETABLES,y : AND #$00FF : JSR PALCOL : STA $7EC60A,x	;|-Print characters to screen
	INY : INX : INX						;|
	CPX !charcount2 : BMI -					;/



	PLX : PLY




DEC !msgRam
LDA !msgRam : AND #$00FF : BEQ RESETHUD
RTS

;-------------------cleanup HUD from here---------------------
RESETHUD:
PHX
LDX #$0000
-				;\
LDA #$2C0F : STA $7EC60A,x	;|-Loop through all indices and turn them black
INX : INX			;|
CPX !charcount2 : BMI - 	;/
PLX

QUIT:
STZ !msgRam
RTS

;--------------------SubRoutines Below------------------------
MULTBY7:					;\
BEQ +		;handle if the index is 0	;|
						;|-Multiply by 7 to get the base message
	PHX : TAX : LDA #$0000			;| index, which is then added to in the
	-					;| dislay loop to get each character.
	CLC					;| 
	ADC !charcount				;|
	DEX : CPX #$0000 : BNE -		;|
						;|
	PLX					;/

+
RTS

;----------

PALCOL:
PHA

LDA !msgRam : AND #$0004 : BEQ +	;If the fours bit is on, add 08 to the 
					;high bytes of the character. Change the BEQ
	PLA : CLC : ADC #$0800 : RTS	;to a BRA if you don't want the message to flash.
+
PLA : CLC : ADC #$1C00			;else, add 1C to make it yellow
RTS

;--------------------List of Messages--------------------------

;org $83F800 ;Zero indexed. PLM messages are listed in order of PLM entry. They go up to message #$0014.
IMESSAGETABLES:
db !E, !N, !E, !R, !G, !Y, !SB		;0 (yes the indexing starts at 1)
db !M, !I, !S, !S, !I, !L, !E		
db !S, !U, !P, !E, !R, !S, !SB		
db !P, !B, !S, !SB, !SB, !SB, !SB
db !B, !O, !M, !B, !SB, !SB, !SB	
db !C, !H, !A, !R, !G, !E, !SB
db !I, !C, !E, !SB, !SB, !SB, !SB
db !H, !I, !SB, !J, !U, !M, !P		
db !S, !P, !E, !E, !D, !SB, !SB		;8
db !W, !A, !V, !E, !SB, !SB, !SB	
db !S, !P, !A, !Z, !E, !R, !SB
db !S, !P, !R, !I, !N, !G, !SB
db !V, !A, !R, !I, !A, !SB, !SB
db !G, !R, !A, !V, !I, !T, !Y
db !X, !R, !A, !Y, !SB, !SB, !SB
db !P, !L, !A, !S, !M, !A, !SB		
db !G, !R, !A, !P, !P, !L, !E		;10
db !S, !P, !SB, !J, !U, !M, !P
db !S, !C, !R, !E, !W, !SB, !SB
db !M, !O, !R, !P, !H, !SB, !SB
db !R, !E, !S, !E, !R, !V, !E
db !T, !I, !M, !E, !SB, !SB, !SB	;15

if !UniversalAmmo_Tundain != 0
db !A, !M, !M, !O, !SB, !SB, !SB	;16
endif

!free82 #= pc()

;--------------------------Stack Energy Tanks----------------------------
{
org $809BD3	;hijack energy drawing loop

JSR STACKTANKS
NOP #9



org !free80 ;!80Free	;free space in $80
STACKTANKS:
CPY #$000E : BPL +	;\-Checks the current index in the draw loop.
LDX #$3430		;|
LDA $14			;|-If drawing the 7th or below e tank, use normal graphics.
BEQ ++			;|
DEC $14			;|
LDX #$2831		;|
++			;|
RTS			;/

+			;\
LDX #$2831		;|
LDA $14			;|-If drawing the 8th or above, use blue for full and pink for empty tank.
BEQ +			;|
DEC $14			;|
LDX #$2C31		;|
RTS			;|
+			;|
RTS			;/

HEALTH_CHECK_ROW2:
LDA $09C2 : CMP #$0320 : BPL +	;Switch how many tanks to draw based on Samus's health.
CPY #$000E : RTS
+
CPY #$001C : RTS

!free80 #= pc()

org $809BE9	;hijack
JSR HEALTH_CHECK_ROW2	;stop drawing e tanks after finishing the first row.

org $809CDC		;change the draw location so the top row overlaps the bottom one.
dw $0042, $0044, $0046, $0048, $004A, $004C, $004E
}