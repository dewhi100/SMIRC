;----------------BOSS AREA EVENT SYSTEM-----------------
;-----------------BOSS BIT BTS VERSION------------------
;------------Original Hex Edits by PHOSPHOTiDYL---------
;---------------Modifications by OmegaDragnet9----------

;Credits to P.JBoy for the Banklogs, which are referenced heavily. 
;This uses code from PHOSPHOTiDYL's Ridley Anywhere.
;This also depends heavily on Nodever2's Torizo speed1 EnemyVar Area Check to function.
;(Resource not included here. Check out https://metroidconstruction.com/resource.php?id=420 )

;-------------------------------------------------------
;--------IN VANILLA, YOU ALREADY SET EVENTS-------------
;---------------WHEN YOU KILL A BOSS--------------------
;-------------------------------------------------------

;A boss requires an area-specific bit.
;This is to spawn the boss, and to keep the boss from coming back. 
;The disadvantage is it requires hardcoding to move to another area.

;It's also easy to overlook that
;this already ties up part of the usable events from $16 to $FF.
;(Specifically Events $40-$7F.)

;(You could unintentionally set a boss as defeated using an Event PLM.)

;The specific events are marked in the defines section AND 
;the Boss Bits Array section for reference and ease of use. 

;-------------------------------------------------------
;----------WHAT THIS RESOURCE CHANGES-------------------
;-------------------------------------------------------

;Bosses can be used in any area. (Not including Mother Brain. This does not address Mother Brain.)
;You set what boss bit gets used per area by
;placing a BTS at the top leftmost part of the room.

;Vanilla uses Bits $01, $02, and $04, but reserves 
;bits $01, $02, $04, $08, $10, $20, $40, and $80 per area.

;This lets you utilize those inside the room editor.

;(This functionality is intended to work in conjunction 
;with Event Gray Doors, specifically the "Miniboss Killed" event is
;now hijacked to look at this same BTS to determine what bit to react to.

;-------------------------------------------------------
;----------HOW TO USE THIS IN THE EDITOR----------------
;-------------------------------------------------------

;Place a BTS collision tile on the topmost left part of the room.
;ONLY PLACE THESE:
;$01, $02, $04, $08, $10, $20, $40, and $80 

;This will be under tile data, then collision. Any BTS will work, but I prefer to use air as it shows up inside the editor.
;You will not find most of the numbers you'll want; navigate under the tile type and select "FULL"
;Place one of the 8 bits I mentioned.

;Make sure to apply the included version of Event Gray Doors.
;Under room data, select the Grey Door.
;Navigate to Misc/arg/Open Condition. Select Mini Boss for the Area is Dead. (This will add #$0400 to whatever the PLM Argument was.) 
;Now the gray doors will look at the same BTS the boss is looking for to determine which bit gets set. 

;Setup the alternate state. 
;Chances are the boss room is already setup with this, but select the state.
;[0xE629] Boss type is dead. 
;This will be under Condtion/testcode.

;Make sure the Boss Type (under Condition) is set to whatever BTS value you placed in the top left of the room. 

;-------------------------------------------------------
;---------A WORD ABOUT THE BOSS MAP ICONS---------------
;-------------------------------------------------------

;Each area is allotted 8 potential bits for bosses.
;Vanilla only really uses the map icons for Bit 1, 
;but there's enough to have 8 boss icons per map.

;Here's where the Boss Bits show up on the array.
;Notice how they occupy a signifcant chunk of the event array?
;Be mindful of this when using Event PLMs. 

;-------------------------------------------------------
;-----------------BOSS BITS-----------------------------
;-------------------------------------------------------

	;RAM
	;ADDRESS     EVENTS
	
	; D828		:40-42	Crateria, only 42 used		  (Bomb Torizo, Bit 4)
				;43-47	Unused
	
	; D829		:48-4A	Brinstar, only 48 and 49 used (Kraid and SporeSpawn, Bits 1 and 2)
				;4B-4F	Unused
	
	; D82A		:50-52	Norfair, only 50 and 52 used  (Ridley and Gold Torizo, Bits 1 and 4)
				;53-57	Unused
	
	; D82B		:58-5A 	Wrecked Ship, only 58 used	  (Phantoon, Bit 1)
				;5B-5F	Unused
	
	; D82C		:60-62	Maridia, only 60 and 61 used  (Draygon and Botwoon, Bits 1 and 2)
				;63-67 	Unused
	
	; D82D		:68-6A	Tourian, only 69 used		  (Mother Brain, Bit 2)
				;6B-6F	Unused
	
	; D82E		:70-72 	Ceres, only 70 used?		  (Ceres Ridley, Bit 1?)
				;73-77 	Unused
	
	; D82F		:78-7A	Debug, nothing used in Vanilla
				;7B-7F	Unused

;-------------------------------------------------------
;--------------THE GOLDEN FOUR--------------------------
;-------------------------------------------------------

;In order to use G4, you must set the Room Index to the exact
;events specified in the Defines section.

;At least one Kraid fight needs to have a Room Index of 48
;to turn the Kraid statue gray. 

 lorom

;-------------------------------------------------------
;----------------DEFINES--------------------------------
;-------------------------------------------------------

!FirstBTS = $7F6402	
!BossBitCheck = $8081DC
!BossBitSet = $8081A6
!EventCheck = $808233	
!EventSet = $8081FA	
!RoomIndex  = $079D
;!80Freespace = $80D2C0

;---Vanilla Boss Events-----
;----Mainly for reference---

!BombTorizo = #$0042
!GoldTorizo = #$0052

!SporeSpawn = #$0048
!Crocomire  = #$0051
!Botwoon    = #$0061

!Kraid      = #$0048
!Phantoon   = #$0058
!Draygon    = #$0060
!Ridley     = #$0050

!BombTorizo = #$0042
!GoldTorizo = #$0052

!PhantoonStatue = #$0006
!RidleyStatue   = #$0007
!DraygonStatue  = #$0008
!KraidStatue    = #$0009


;-------------------------------------------------------
;------------Bank $80 Routines--------------------------
;-------------------------------------------------------

org !free80 ;!80Freespace
BossBitCheck:
LDA !FirstBTS			;Gets first BTS Block from Room
AND #$00FF
JSL !BossBitCheck
RTL

BossBitSet:
LDA !FirstBTS			;Gets first BTS Block from Room
AND #$00FF
JSL !BossBitSet
RTL

warnpc !free80End
!free80 #= pc()

;-------------------------------------------------------
;---------------BOTWOON---------------------------------
;-------------------------------------------------------

org $B39583		;AI Initializing. 

JSL BossBitCheck
NOP #3
BCC $24

;----------Botwoon Set as Dead---------------------------

org $B39B13 

JSL BossBitSet
NOP #3



;------------------------------------------------------
;---------------SPORESPAWN-----------------------------
;------------------------------------------------------

org $A5EA8F 	;AI Initialization

JSL BossBitCheck
NOP #6         
BCC $24

;----------SporeSpawn Set as Dead---------------------------

org $A5EE30

JSL BossBitSet
NOP #3
JMP $EE3E

;------------------------------------------------------
;---------------CROCOMIRE------------------------------
;------------------------------------------------------

org $A48A73		;AI Initialization

JSL BossBitCheck
NOP #6 
BCS $5D


org $A4F67A		;Crocomire Tongue AI Initialization

JSL BossBitCheck
NOP #6 
BCS $25


;----------Crocomire Set as Dead-------------------------

org $A49B90    

JSL BossBitSet
NOP #3
JMP $9B9E		

;------------------------------------------------------
;---------------DRAYGON--------------------------------
;------------------------------------------------------

org $A592D4 			;Draygon set as dead. 

JSL BossBitSet
NOP #3
JMP $92E2				 		

;------------------------------------------------------
;---------------KRAID----------------------------------
;------------------------------------------------------

org $A7A92D

JSL BossBitCheck
NOP #6 
BCC $05


org $A7C822

JSL BossBitCheck
NOP #6 
BCS $0E


org $A7C82E

JSL BossBitSet
NOP #3



;------------------------------------------------------
;---------------PHANTOON-------------------------------
;------------------------------------------------------

org $A7DB7B

JSL BossBitSet
NOP #10

;Wrecked Ship and Phantoon Specific. Only practical for it to be hardcoded. 

org $948E83 ;Region Number

LDA $079F
CMP #$0003
BNE $09 

org $948E8B ;Checks Boss Bit for spike blocks in wrecked ship

LDA !Phantoon
JSL $808233	
BCC $3A

org $8781BA  ; Treadmills

LDA !Phantoon
JSL $808233	
BCS $07

;------------------------------------------------------
;---------------Torizos--------------------------------
;------------------------------------------------------

;Intended to work with Nodever2's Torizo Speed ASM.

org $AAC87F ;If Area Torizo is Dead

JSL BossBitCheck
NOP #3
BCC $0D

org $AAB24D

JSL BossBitSet
NOP #3

;--------------BT Gray Haze Removal----------------------

; org $AAC90F
; db $6B ;originally 22

;-------------------BT Placement-------------------------

; org $AAC8E0
; NOP #3

; org $AAC8E6
; NOP #3 

;------------------------------------------------------
;---------------RIDLEY---------------------------------
;------------------------------------------------------

org $A6A0F5		;Check if Ridley is dead

JSL BossBitCheck
NOP #6
BCC $0D
 
org $A6C5DF		

JSL BossBitSet
NOP #3

org $A6A369		;Checks for Norfair's Region Number 
;Not certain what this is needed for yet. 
LDY $079F
CPY #$0002
BNE $03 

;------------------------------------------------
;----------Other Norfair Checks------------------
;------------------------------------------------

;This next section is from 
;PHOSPHOTiDYL's Ridley Everywhere resource.
;Credit goes to PHOSPHOTiDYL for discovering 
;where to NOP and change all the branches to BRA.

org $A6A15C ;Hiding Ridley before fight begins.

	NOP #6 : BRA $03

org $A6A424 ;Music, determined by area

	NOP #6 : BRA $06

;org $A6A44D ;;The Music Itself

;LDA #$0005 : JSL $808FC1 : RTS

org $A6A469 ;Ridley Roar

	NOP #6 : BRA $06

org $A6A478	;BG Fade in and Lava Rising

	NOP #8

org $A6D914 ;Causes Room shaking, only happens in Ceres. 
;Unreachable code for Norfair. 

	NOP #6 : BRA $38

org $A6D93B ;Screen Shake

	NOP #6 : BRA $05

org $A6DF8A ;Ridley is hit. 

	NOP #6 : BRA $1A

org $A6E4D2

	NOP #6 : BRA $3A





