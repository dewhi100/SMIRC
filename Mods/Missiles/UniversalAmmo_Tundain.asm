;This patch gives you a universal ammo system like the one in hyper metroid. Made by Tundain
; Important, edit the tile $5C in the HUD GFX, bc that tile will be used as a symbol between the current ammo and max ammo (a slash for example)
;and you can use the tiles $58,$59,$5A,$5B to write the word "ammo"
;don't forget to credit!

;This version includes an ammo plm, which only gives ammo to the player
;if using SMART, turn on debug when assembling the patch, it will tell you what to use as your ammo plm
;if not using SMART, then look at the console of your favorite assembler
;this is how the plm works:
; high byte = 0XXX, means small ammo tank
; high byte = 1XXX, means large ammo tank
; high byte = X0XX, means regular plm
; high byte = X1XX, means chozo orb plm
; high byte = X2XX, means hidden plm
lorom

;these values are how much ammo it will consume when fired
!supermissileweight = #$0005
!PowerbombWeight = #$000A
;these values is how much ammo you get when picking up ammo drops
!supermissiledropweight = #$0005
!PowerbombdropWeight = #$000A
;these values are how much a plm of it's kind will add to the max ammo count
!supercount = #$0005
!powerbombcount = #$0005

!SBAcost = #$000A ; how much ammo sba's will consume
!crystalflashcost = #$001E ;how much ammo a full crystal flash consumes
!cystalflashtimer = #$0007 ;this has to do with how long it takes between each time health is restored
;lower values and higher values will shorten the delay, but generally you wouldn't want crystal flash to be slow so that's fine
!healthgiven = #$0032;how much energy each time 

;!SRAM = $09EE ; this is a unused RAM address that gets stored to your save files, if you have another patch that's also using it, try to replace this by a different one

; Ammo PLMs
; change the low byte of these values to change which tile in the tilemap selector the small ammo pickup uses
!smallammotilemap = #$B077
!largeammotilemap = #$B076
!SmallammoMsgbox = #$001D ; which msg box small ammo pickups display
!LargeammoMsgbox = #$001E ;msg box of large ammo pickup
!smallammoweight = #$0005 ;how much a small plm gives
!largeammoweight = #$000A ;how much a large plm gives
;FREESPACE!
!Bank80freespace = $80D180 ;repoint this to freespace in bank $80, doesn't need much
!Bank84Freespace = $84F500 ;repoint to freespace in bank $84
!Bank90freespace = $90F640 ;repoint to freespace in bank $90
!Bank86freespace = $86F4B0 ;repoint to freespace in bank $86, doesn't need a lot


;-----------BANK $80 STUFF---------------------
;---placing the missile counter at the right spot---
org $809B09
  LDX #$009C
org $809C10
  LDX #$009C
 ;----------------------

; making the hud initiation only do the missile counter and skip the other ones
org $809B0C
  JSR hijacked
  BRA Inithighlight
; same thing but for the constant hud processing routine
org $809C13
  JSR hijacked
  BRA handlehighlighter
org $809AC9
  LDA !UniversalAmmoRAM ; check if has collected missiles, and not just ammo
  
;labels for the branches
org $809B2B
Inithighlight:
org $809C55
handlehighlighter:

; this displays the current amount and max amount counter
org !free80
hijacked:
  JSR $9D78
  LDA $09C8
  LDX #$00A4
  JSR $9D78
  LDA $09C8
  BEQ skiptoend
  LDA ammotiles
  STA $7EC69C
  LDA ammotiles+$02
  STA $7EC69E
  LDA ammotiles+$04   ; draw the word ammo
  STA $7EC6A0
  LDA ammotiles+$06
  STA $7EC6A2
  LDA #$2C5C ; draw the slash symbol (change the low byte of this value to change which hud gfx to use, or comment out this LDA and the next STA if you don't want it)
  STA $7EC6AA
skiptoend:
  RTS
ammotiles:
DW #$2C58,#$2C59,#$2C5A,#$2C5B ; change the low byte of these value to change which tiles from the hud to use for the word "ammo"

!free80 #= pc()

  ;------------BANK $84 STUFF---------------
org $8489D2 ; super missiles plms affect missile count
  LDA $09C8
  CLC
  ADC $0000,y
  STA $09C8
  LDA $09C6
  CLC
  ADC $0000,y
  JSR updatesupers
  
org $8489FB ; pbs affect missile count
  LDA $09C8
  CLC
  ADC $0000,y
  STA $09C8
  LDA $09C6
  CLC
  ADC $0000,y
  JSR updatepbs
org $8489BA ; hijack to let the game know you've collected missiles, incase your hack allows obtaining supers or pbs before missiles
  JSR updatemissles
  
;plms give variable ammo
org $84E102 ; normal version
DW !supercount
org $84E4D8; chozo orb version
DW !supercount
org $84E9AF ;hidden version
DW !supercount

;powerbombs
org $84E127
DW !powerbombcount;normal version
org $84E50A;chozo orb version
DW !powerbombcount
org $84E9E7;hidden version
DW !powerbombcount

org !free84; this is just so the game knows if you have collected supers or pbs, could be done a bit more efficiently probably, but meh, it works
updatesupers:
  STA $09C6
  INC $09CC
  RTS
updatepbs:
  STA $09C6
  INC $09D0
  RTS
updatemissles:
  STA $09C6
  INC !UniversalAmmoRAM ; unuses SRAM to know if you've collected missiles
  RTS

if !AmmoPLM != 0
SmallAmmotank:
print " ammo tank plm: ",pc
DW Setup : DW main

Setup:
LDA $1DC7,y
BIT #$0100
  BNE orb
  BIT #$0200
  BNE shotblock
  BRA endsetup
orb:
  LDA instlists
  STA $1D27,y
  BRA endsetup
shotblock:
  LDA instlists+$02
  STA $1D27,y
  LDA #$0010
  BRL setshotplmgfx
endsetup:
  LDA #$0010
  BRL setplmitemgfx

main:
DW $887C,skip ;if collected, skip everything
DW $8A24,collected ; set this as linked instruction
DW $86C1,$DF89 ; this triggers the previously linked instructions
DW checksize,smalltilemaps,largetilemaps
smalltilemaps:
DW $0004,smalltilemap1 ; what to display
DW $86B4
largetilemaps:
DW $0004,largetilemap2; 
DW $86B4
collected:
DW $8899
DW $8BDD : DB $02
DW collectammopickup,!smallammoweight,!largeammoweight
skip:
DW $8724,$DFA9

mainbutorb: ;if it's set to be a chozo orb
DW $887C,skiporb_UniversalAmmo
DW $8A2E,$DFAF
DW $8A2E,$DFC7
DW $8A24,collected
DW $86C1,$DF89
DW $874E : DB $16
DW checksize,smalltilemaps,largetilemaps
skiporb_UniversalAmmo:
DW $0001,$A2B5
DW $86BC

mainbutshotblock: ; if it's set to be a hidden plm
DW $8A2E,$E007
DW $887C,shotblockend
DW $8A24,collected
DW $86C1,$DF89
DW $874E : DB $16
DW checksize,smalltilemapshot,largetilemapshot
smalltilemapshot:
DW $0008,smalltilemap1
DW $873F,smalltilemapshot
DW $8A2E,$E020
DW $8724,mainbutshotblock
largetilemapshot:
DW $0008,largetilemap2
DW $873F,largetilemapshot
DW $8A2E,$E020
DW $8724,mainbutshotblock
shotblockend:
DW $8A2E,$E032
DW $8724,mainbutshotblock

smalltilemap1:
DW #$0001,!smallammotilemap,#$0000

largetilemap2:
DW #$0001,!largeammotilemap,#$0000

checksize: ; check which gfx to show based on the plm argument
  LDA $1DC7,x
  BIT #$1000
  BNE largeammo
  LDA $0000,y
  TAY
  RTS
largeammo:
  LDA $0002,y
  TAY
  RTS
  
collectammopickup: ;when collecting, check the argument to see how much to add, and which msg box to show
LDA $1DC7,x
BIT #$1000
BNE addlargeammo
LDA $09C8
CLC
ADC $0000,y
STA $09C8
LDA $09C6
CLC
ADC $0000,y
BRA displaymsgbox
addlargeammo:
LDA $09C8
CLC
ADC $0002,y
STA $09C8
LDA $09C6
CLC
ADC $0002,y
displaymsgbox:
STA $09C6
INY : INY
LDA #$0168
JSL $82E118
LDA $1DC7,x
BIT #$1000
BNE largepickup
LDA !SmallammoMsgbox
JSL $858080
BRA exitcollection
largepickup:
LDA !LargeammoMsgbox
JSL $858080
exitcollection:
INY : INY
RTS

instlists: ;list with pointers to choose which plm it's going to be(in case it's not the default)
DW mainbutorb,mainbutshotblock

!free84 #= pc()

;labels
org $84EE5F
setplmitemgfx:
org $84EE89
setshotplmgfx:
endif
  
 ;-------------bank $90 stuff---------------
if !BombLauncher_Ob == 0 && !SupersNeedMains_Dewhi100 == 0
org $90C564 ;HUD selection for super missiles checks missiles instead
  JSR checkifcanselectsupers
endif

if !BombLauncher_Ob == 0  
org $90C551
  JSR checkifcanselectmissiles
endif

;label
org $90C56B
cantshoot:

org $90BE91; firing ability check regular missiles instead
  LDA $09C6
org $90BEC4 ; decreases you regular ammo count instead
  JSR substractsupermissiles
org $90BF3C
  JSR checkifnotenoughsupers

  
if !BombLauncher_Ob == 0  
org $90C577 ;HUD selection for pbs checks missiles instead
  JSR checkifcanselectpbs
endif

org $90C0A1; firing ability check regular missiles instead
  JSR checkifnotenoughpbs
org $90C028
  LDA $09C6

org $90C02D
  JSR decreasepbs
  NOP
  NOP
  NOP
  
;SBA stuff
org $90CC21 ; cost of ammo for SBA's
DW #$0000,!SBAcost,!SBAcost,#$0000,!SBAcost,#$0000,#$0000,#$0000,!SBAcost,#$0000,#$0000,#$0000
 
org $90CCD2 ;firing sba's decrease universal ammo
  LDA $09C6
  SEC
  SBC $CC21,x
  BPL $03
  LDA #$0000
  STA $09C6
  JSR ($CCF0,x)
  JSR checkSBA
  
;Crystal flash stuff
org $90D64B
  LDA !crystalflashcost
org $90D6E3 ;hijack missile routine to skip and immediately  enter pb routine
  JMP crystalpbs
;label
org $90D729
crystalpbs:

org $90D731 ;make pb decrement decremnt missiles instead
  DEC $09C6
org $90D5D5 ;check if enough ammo to initiate crystal flash
  CMP !crystalflashcost
org $90D5DD; checks if you have 0 supers
  CMP #$0000
  
org $90D5E5;checks if you have 0 pbs
  CMP #$0000
org $90D72C
  BIT !cystalflashtimer
org $90D734
  LDA !healthgiven
  
 ; routines to decrement your ammo by different amounts based off the projectile fired
org !free90
substractsupermissiles:
  LDA $09C6
  SBC !supermissileweight
  STA $09C6
  RTS
decreasepbs:
  LDA $09C6
  SBC !PowerbombWeight
  STA $09C6
  RTS
 ;routines to check if you can select supers based of if 1: you have more then 0 max supers, and 2: you have enough ammo to fire a super
checkifcanselectmissiles:
  LDA $09EE
  BEQ itcantshoot
  LDA $09C6
  RTS
checkifcanselectsupers:
  LDA $09CC
  BEQ itcantshoot
  LDA $09C6
  CMP !supermissileweight
  BMI itcantshoot
  LDA $09C6
  RTS
itcantshoot:
  LDA #$0000
  RTS
checkifnotenoughsupers:
  LDA $09C6
  CMP !supermissileweight
  BMI itcantshoot
  LDA $09C6
  RTS
 ; same things but for pbs
checkifcanselectpbs:
  LDA $09D0
  BEQ itcantshoot
  LDA $09C6
  CMP !PowerbombWeight
  BMI itcantshoot
  LDA $09C6
  RTS

checkifnotenoughpbs:
  LDA $09C6
  CMP !PowerbombWeight
  BMI itcantshoot
  LDA $09C6
  RTS
  
checkSBA:
  LDA $09C6
  CMP !SBAcost
  BMI cannotSBA
  LDA $09C6
  RTS
cannotSBA:
  LDA #$0000
  RTS

!free90 #= pc()





;----------------Bank $86 stuff----------------
;making item drops give you universal ammo
org $86F0F7
  LDA !supermissiledropweight
  JSL $91DF80
  
org $86F0D9
  LDA !PowerbombdropWeight
  JSL $91DF80

 
  
org $86F1B1 ;makes enemies be able to drop other stuff than missiles
  JSR checksuperdrops
  CPY $09C8
org $86F1C8
  JSR checkpbdrops
  CPY $09C8
  
org !free86
checksuperdrops:
  LDY $09CC
  BNE hasitem
  LDY $09C8
  RTS
hasitem:
  LDA $09C6
  RTS
checkpbdrops:
  LDY $09D0
  BNE hasitem
  LDY $09C8
  RTS
  
!free86 #= pc()
  
 ;BANK $A2 stuff---------------
 ;just making it so the gunship only refills samus's missiles
 
org $A2AAB9
  JMP $AAC7 ;skip adding health
org $A2AADF
  JMP $AAEF

  
  